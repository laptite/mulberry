dojo.provide('mulberry.app.Bootstrapper');

dojo.require('mulberry.app.PhoneGap');
dojo.require('mulberry.app.DeviceStorage');
dojo.require('mulberry.models.Tour');

dojo.requireLocalization('mulberry', 'mulberry');

(function() {

var bootstrapper = function() {
  var dfd = new dojo.Deferred(),
      app = mulberry.app,
      tour;

  // open up the database connection so we can work with it
  app.DeviceStorage.init(app.Config.get("id"));

  if (app.DeviceStorage.get('tour-version') === 0) {
    app.DeviceStorage.set('tour-verison', null);
  }

  tour = new mulberry.models.Tour({
    bundleDataUrl : './data/tour.js' + (app.PhoneGap.present ? '.jet' : ''),
    remoteDataUrl : app.Config.get('updateUrl'),
    remoteVersionUrl : app.Config.get('versionUrl')
  });

  dojo.subscribe('/page/transition/end', function() {
    // how long has it been since we last checked for an update?
    var lastChecked = tour.lastChecked,
        now = new Date().getTime(),
        since = now - lastChecked,
        maxTime = 1000 * 60 * 60 * (mulberry.otaInterval || 8), // 8 hours
        outdated = since > maxTime;

    if (!outdated) { return; }

    tour.bootstrap().then(function(gotUpdate) {
      if (!gotUpdate) { return; }

      dojo.when(mulberry.app.Tour.getItems(), function(data) {
        mulberry.app.Data.loadData(data);

        mulberry.app.PhoneGap.notification.alert(
          dojo.i18n.getLocalization(
            "mulberry", "mulberry", mulberry.app.Config.get("locale")
          ).OTA_UPDATE_NOTICE
        );

        mulberry.app.Router.home();
      });
    });
  });

  tour.bootstrap().then(function() {
    dfd.resolve(tour);
  }, dfd.reject);

  return dfd.promise;
};

dojo.subscribe('/app/deviceready', function() {

  bootstrapper().then(function(tour) {

    tour.getItems().then(function(data) {

      //>>excludeStart('production', kwArgs.production);
      if (mulberry.extraTourData && dojo.isArray(mulberry.extraTourData)) {
        dojo.forEach(mulberry.extraTourData, function(item) {
          data.push(item);
        });
      }
      //>>excludeEnd('production');

      mulberry.app.Data = new mulberry.app.Data(data);

      // this timeout is here to avoid a nasty problem with webkit
      // where reading a node's innerHTML will not work correctly;
      // this bug manifests itself with an "Invalid template" error,
      // which will make no sense because the template is perfectly
      // valid. this error will only appear intermittently, and almost
      // exclusively on device. long story short:
      //
      // DO NOT REMOVE THIS TIMEOUT
      //

      setTimeout(function() {
        dojo.publish('/app/ready');

        mulberry.app.PhoneGap.network.isReachable().then(
          function(reachable) {
            if (!reachable) {
              mulberry.app.PhoneGap.notification.alert(
                dojo.i18n.getLocalization(
                  "mulberry", "mulberry", mulberry.app.Config.get("locale")
                ).STARTUP_NO_NETWORK
              );
            }
          }
        );
      }, 200);
    });

  });

});

}());