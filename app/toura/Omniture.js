dojo.provide('toura.Omniture');

/**
 * Instantiate toura, and 
 */


dojo.declare('toura.Omniture', null, {

  /**
   * @constructor
   * @param {String} id  The site ID to associate with publisher id
   *
   * Subscribes to various application events.
   */
  constructor : function (id) {
    //can do pub/sub type stuff in here if needed
    //need to listen for orientation change

    this.test();

  },

  test : function() {

    window.plugins.omniture.testing();

    // try {
    //   window.plugins.omniture.configureMeasurementWithReportSuiteIDsTrackingServer('foo', 'bar');      
    // } catch ( e ) {
    //   alert('error calling window.plugins...');
    // }
    
  }

});

(function(){
  dojo.subscribe('/app/ready', function() {
    var amConfig = mulberry.app.Config.get('app');
    
    if ( amConfig.omniture ) {
      toura.Omniture = new toura.Omniture(amConfig.omniture.oid);
    } else {
      return;
    }

  });
}());
