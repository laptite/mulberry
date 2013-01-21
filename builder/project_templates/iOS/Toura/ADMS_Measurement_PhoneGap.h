//
//  ADMS_MeasurementPlugin.h
//  PhoneGapTest
//
//  Created by Stephen Benedick on 4/2/12.
//  Copyright (c) 2012 Adobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#define kOK         @"OK"
#define kCData      @"cData"
#define kVars       @"vars"
#define kVarsBegin  @"*VARS*"
#define kSeparator  @"&*&"
#define kEquals     @"="

@interface ADMS_Measurement_PhoneGap : CDVPlugin {
}

#pragma mark - Configuration Methods
//reportSuiteIDs and trackingServer provided by Adobe
- (void) configureMeasurementWithReportSuiteIDsTrackingServer:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

//Defaults to ADMS_AutoTrackOptionsLifecycle
- (void) setAutoTrackingOptions:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

/*
 When measurement is offline:
 If offlineTrackingEnabled is true: hits are stored until measurement is online.
 If offlineTrackingEnabled is false: hits are thrown away. 
 */
- (void) setOnline:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setOffline:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


#pragma mark - Tracking Methods
#pragma mark Simple Tracking Methods
//appState is put in the pageName variable on the call.
- (void) trackAppState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) trackAppStateWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
//eventNames is a comma delimited list of all events.
- (void) trackEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) trackEventsWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


#pragma mark Advanced Tracking Methods
- (void) track:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) trackWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) trackWithContextDataAndVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

- (void) trackLinkURLWithLinkTypeNameContextDataVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

//Light tracking must be configured with Adobe ClientCare
- (void) trackLightWithProfileIDStoreForSecondsIncrementByContextDataVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


#pragma mark - Getters/Setters
/*
 These methods should be avoided if possible.  
 We recommend using contextData to append additional information to a hit.
 */
- (void) setEvarToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setPropToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setHierToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setListVarToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) getEvar:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) getProp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) getHier:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) getListVar:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

/*
 Clears Persistent Tracking Variables and all eVars, props, hiers 
 and lists.
 */
- (void) clearVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

- (void) trackingQueueSize:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) clearTrackingQueue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


#pragma mark - Properties
//Library Information
- (void) getVersion:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

//Logging
- (void) setDebugLogging:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;           //Defaults to false

//Configuration Variables
- (void) setReportSuiteIDs:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;         //Comma delimited
- (void) setTrackingServer:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setDataCenter:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setVisitorID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;              //Defaults to CFUUID
- (void) setCharSet:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;                //Defaults to UTF-8
- (void) setCurrencyCode:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setSSLEnabled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;             //Defaults to false

//Persistent Tracking Variables
- (void) setPurchaseID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setTransactionID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

- (void) setAppState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;               //Sent as pageName
- (void) setChannel:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setAppSection:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;             //Previously server
- (void) setCampaign:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setProducts:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;               //Comma delimited
- (void) setEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;                 //Comma delimited

- (void) setGeoState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) setGeoZip:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

- (void) setPersistentContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
- (void) persistentContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

- (void) setLinkTrackVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;          //Comma delimited
- (void) setLinkTrackEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;        //Comma delimited
- (void) setLightTrackVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;         //Comma delimited

//Offline Tracking Vars
- (void) setOfflineTrackingEnabled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options; //Defaults to true
- (void) setOfflineThrottleDelay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;   //Defaults to 0
- (void) setOfflineHitLimit:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;        //Defaults to 1000

@end








































