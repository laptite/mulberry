/*
* If phonegap exists, overwrite the web functions
*/

dojo.provide('mulberry.app.PhoneGap.omniture');

mulberry.app.PhoneGap.omniture = function(pg, device){

          // name of plugin as it is defined in Cordova.plist
        var PLUGIN_NAME = "ADMS_Plugin";
        
        // function names constant strings
        var fCONFIGURE_MEASUREMENT = "configureMeasurementWithReportSuiteIDsTrackingServer";
        var fSET_AUTO_TRACKING = "setAutoTrackingOptions";
        var fSET_ONLINE = "setOnline";
        var fSET_OFFLINE = "setOffline";
        var fTRACK_APP_STATE = "trackAppState";
        var fTRACK_APP_STATE_WITH_CDATA = "trackAppStateWithContextData";
        var fTRACK_EVENTS = "trackEvents";
        var fTRACK_EVENTS_WITH_CDATA = "trackEventsWithContextData";
        var fTRACK = "track";
        var fTRACK_WITH_CDATA = "trackWithContextData";
        var fTRACK_WITH_CDATA_VARS = "trackWithContextDataAndVariables";
        var fTRACK_LINK = "trackLinkURLWithLinkTypeNameContextDataVariables";
        var fTRACK_LIGHT = "trackLightWithProfileIDStoreForSecondsIncrementByContextDataVariables";
        var fSET_EVAR = "setEvarToValue";
        var fSET_PROP = "setPropToValue";
        var fSET_HIER = "setHierToValue";
        var fSET_LIST = "setListVarToValue";
        var fGET_EVAR = "getEvar";
        var fGET_PROP = "getProp";
        var fGET_HIER = "getHier";
        var fGET_LIST = "getListVar";
        var fCLEAR_VARS = "clearVars";
        var fTRACKING_QUEUE = "trackingQueueSize";
        var fCLEAR_TRACKING_QUEUE = "clearTrackingQueue";
        var fGET_VERSION = "getVersion";
        var fSET_DEBUG_LOGGING = "setDebugLogging";
        var fSET_REPORT_SUITE_IDS = "setReportSuiteIDs";
        var fSET_TRACKING_SERVER = "setTrackingServer";
        var fSET_DATA_CENTER = "setDataCenter";
        var fSET_VISITOR_ID = "setVisitorID";
        var fSET_CHAR_SET = "setCharSet";
        var fSET_CURRENCY_CODE = "setCurrencyCode";
        var fSET_SSL = "setSSLEnabled";
        var fSET_PURCHASE_ID = "setPurchaseID";
        var fSET_TRANSACTION_ID = "setTransactionID";
        var fSET_APP_STATE = "setAppState";
        var fSET_CHANNEL = "setChannel";
        var fSET_APP_SECTION = "setAppSection";
        var fSET_CAMPAIGN = "setCampaign";
        var fSET_PRODUCTS = "setProducts";
        var fSET_EVENTS = "setEvents";
        var fSET_GEO_STATE = "setGeoState";
        var fSET_GEO_ZIP = "setGeoZip";
        var fSET_PERSISTENT_CDATA = "setPersistentContextData";
        var fPERSISTENT_CDATA = "persistentContextData";
        var fSET_LINK_TRACK_VARS = "setLinkTrackVars";
        var fSET_LINK_TRACK_EVENTS = "setLinkTrackEvents";
        var fSET_LIGHT_TRACK_VARS = "setLightTrackVars";
        var fSET_OFFLINE_TRACKING_ENABLED = "setOfflineTrackingEnabled";
        var fSET_OFFLINE_THROTTLE_DELAY = "setOfflineThrottleDelay";
        var fSET_OFFLINE_HIT_LIMIT = "setOfflineHitLimit";
        
        // constant strings used for native string manipulation when passing multiple cdata and var overrides at the same time
        var VARS_BEGIN = "*VARS*";
        var SEPARATOR = "&*&";


  var os = device.os,
      init = {

        ios : function() {

          this._cordova = typeof Cordova === 'undefined' ? cordova : Cordova; 

          this.doNothing = function () {
              return null;
          };

          mulberry.app.Omniture.prototype.testing = function() {
            alert('works.');
          }

          // Configuration Methods
          mulberry.app.Omniture.prototype.configureMeasurementWithReportSuiteIDsTrackingServer = function (reportSuiteIDs, trackingServer) {
            alert(this._cordova);
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fCONFIGURE_MEASUREMENT, [reportSuiteIDs, trackingServer]);
          };
            
          mulberry.app.Omniture.prototype.setAutoTrackingOptions = function (autoTrackingOption) {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fSET_AUTO_TRACKING, [autoTrackingOption]);
          };
            
          mulberry.app.Omniture.prototype.setOnline = function () {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fSET_ONLINE, [null]);
          };
            
          mulberry.app.Omniture.prototype.setOffline = function () {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fSET_OFFLINE, [null]);
          };
            
          // Simple Tracking Methods
          mulberry.app.Omniture.prototype.trackAppState = function (stateName) {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fTRACK_APP_STATE, [stateName]);
          };
            
          mulberry.app.Omniture.prototype.trackAppStateWithContextData = function (stateName, cData) {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fTRACK_APP_STATE_WITH_CDATA, [stateName, cData]);
          };
            
          mulberry.app.Omniture.prototype.trackEvents = function (eventNames) {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fTRACK_EVENTS, [eventNames]);
          };

          mulberry.app.Omniture.prototype.trackEventsWithContextData = function (eventNames, cData) {
              return this._cordova.exec(this.doNothing, this.doNothing, PLUGIN_NAME, fTRACK_EVENTS_WITH_CDATA, [eventNames, cData]);
          };

          cordova.addConstructor(function() {
            if(!window.plugins) window.plugins = {};
            window.plugins.omniture = new mulberry.app.Omniture();
          });

        },

        android : function() {

          /**
           * Load Analytics
           */
          cordova.addConstructor(function() {
            cordova.addPlugin('omniture', new mulberry.app.Omniture());
          });
        }
      };
  if (pg && init[os]) {
    init[os]();
    alert('inited');
  }
  else if(!pg) {
    // this fix is to prevent mulberry serve from barfing when running in "device mode" and not having the _gaq object
    var noop = function() {};
    dojo.forEach(['testing', 'doNothing', 'configureMeasurementWithReportSuiteIDsTrackingServer', 'setAutoTrackingOptions', 'setOnline', 'setOffline', 'trackAppState', 'trackAppStateWithContextData', 'trackEvents', 'trackEventsWithContextData'
      ], function(name) {
        mulberry.app.Omniture.µprototype[name] = noop;
      });

    console.log(mulberry.app);

  }
};