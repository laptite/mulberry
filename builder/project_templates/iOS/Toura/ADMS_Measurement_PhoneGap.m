//
//  ADMS_MeasurementPlugin.m
//  PhoneGapTest
//
//  Created by Stephen Benedick on 4/2/12.
//  Copyright (c) 2012 Adobe. All rights reserved.
//

#import "ADMS_Measurement_PhoneGap.h"
#import <Cordova/CDVPluginResult.h>
#import "ADMS_Measurement.h"

@implementation ADMS_Measurement_PhoneGap

#pragma mark - Configuration Methods
- (void) configureMeasurementWithReportSuiteIDsTrackingServer:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];        
    NSString *reportSuiteIDs = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;;
    NSString *trackingServer = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;;
    
    [[ADMS_Measurement sharedInstance] configureMeasurementWithReportSuiteIDs:reportSuiteIDs trackingServer:trackingServer];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setAutoTrackingOptions:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    ADMS_AutoTrackOptions autoTrackingOption = [[arguments objectAtIndex:0] integerValue];
    
    [[ADMS_Measurement sharedInstance] setAutoTrackingOptions:autoTrackingOption];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setOnline:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    [[ADMS_Measurement sharedInstance] setOnline];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setOffline:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    [[ADMS_Measurement sharedInstance] setOffline];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];    
}

#pragma mark - Tracking Methods
#pragma mark Simple Tracking Methods
- (void) trackAppState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *state = [arguments objectAtIndex:0];
    
    [[ADMS_Measurement sharedInstance] trackAppState:state];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackAppStateWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *state = [arguments objectAtIndex:0];
    
    [[ADMS_Measurement sharedInstance] trackAppState:state withContextData:options];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *events = [arguments objectAtIndex:0];
    
    [[ADMS_Measurement sharedInstance] trackEvents:events];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackEventsWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *events = [arguments objectAtIndex:0];
    
    [[ADMS_Measurement sharedInstance] trackEvents:events withContextData:options];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

#pragma mark - Advanced Tracking Methods
- (void) track:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];  

    [[ADMS_Measurement sharedInstance] track];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackWithContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    [[ADMS_Measurement sharedInstance] trackWithContextData:options];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackWithContextDataAndVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    
    NSDictionary *overrides = [self getContextDataAndVarsFromString:[arguments objectAtIndex:0]];
        
    [[ADMS_Measurement sharedInstance] trackWithContextData:[overrides objectForKey:kCData] variables:[overrides objectForKey:kVars]];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackLinkURLWithLinkTypeNameContextDataVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    

    NSString *linkUrl = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    NSString *linkType = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;
    NSString *linkName = [[arguments objectAtIndex:2] class] != [NSNull class] ? [arguments objectAtIndex:2] : nil;
    
    NSDictionary *overrides = [self getContextDataAndVarsFromString:[arguments objectAtIndex:3]];
        
    [[ADMS_Measurement sharedInstance] trackLinkURL:linkUrl withLinkType:linkType linkName:linkName contextData:[overrides objectForKey:kCData] variables:[overrides objectForKey:kVars]];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackLightWithProfileIDStoreForSecondsIncrementByContextDataVariables:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    NSString *profileId = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    NSUInteger secondsOfStorage = [[arguments objectAtIndex:1] class] != [NSNull class] ? [[arguments objectAtIndex:1] integerValue] : 0;  
    NSUInteger incrementBy = [[arguments objectAtIndex:2] class] != [NSNull class] ? [[arguments objectAtIndex:2] integerValue] : 0;
    
    NSDictionary *overrides = [self getContextDataAndVarsFromString:[arguments objectAtIndex:3]];    
    
    [[ADMS_Measurement sharedInstance] trackLightWithProfileID:profileId storeForSeconds:secondsOfStorage incrementBy:incrementBy contextData:[overrides objectForKey:kCData] variables:[overrides objectForKey:kVars]];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (NSMutableDictionary *) getContextDataAndVarsFromString:(NSString *)theString {
    NSString *varsAsString = theString;
    NSString *separatingString = nil;
    bool hasCdata = NO;
    bool hasVars = NO;
    NSMutableDictionary *cDataOverrides = nil;
    NSMutableDictionary *varOverrides = nil;
    
    // first checking to see if we have cdata and vars in the overrides
    NSRange both = [varsAsString rangeOfString:[NSString stringWithFormat:@"%@%@%@", kSeparator, kVarsBegin, kSeparator]];
    if (both.location != NSNotFound) {
        hasCdata = YES;
        hasVars = YES;
        separatingString = [NSString stringWithFormat:@"%@%@%@", kSeparator, kVarsBegin, kSeparator];    
    }
    else {
        // if not, checking for cdata only
        NSRange cdataOnly = [varsAsString rangeOfString:[NSString stringWithFormat:@"%@%@", kSeparator, kVarsBegin]];
        if (cdataOnly.location != NSNotFound) {
            hasCdata = YES;
            separatingString = [NSString stringWithFormat:@"%@%@", kSeparator, kVarsBegin];
        }
        else {
            // if not, checking for vars only
            NSRange varsOnly = [varsAsString rangeOfString:[NSString stringWithFormat:@"%@%@", kVarsBegin, kSeparator]];
            if (varsOnly.location != NSNotFound) {
                hasVars = YES;
                separatingString = [NSString stringWithFormat:@"%@%@", kVarsBegin, kSeparator];
            }
        }
    }
    
    if (separatingString != nil) {
        NSArray *cdataAndVars = [varsAsString componentsSeparatedByString:separatingString];    
        
        if (hasCdata) {
            NSArray *cdata = [[cdataAndVars objectAtIndex:0] componentsSeparatedByString:kSeparator];
            cDataOverrides = [NSMutableDictionary dictionary];
            for (NSString *itemAsString in cdata) {
                NSArray *item = [itemAsString componentsSeparatedByString:kEquals];
                [cDataOverrides setObject:[item objectAtIndex:1] forKey:[item objectAtIndex:0]];
            }
        }        
        
        if (hasVars) {
            NSArray *vars = [[cdataAndVars objectAtIndex:1] componentsSeparatedByString:kSeparator];
            varOverrides = [NSMutableDictionary dictionary];
            for (NSString *itemAsString in vars) {
                NSArray *item = [itemAsString componentsSeparatedByString:kEquals];
                [varOverrides setObject:[item objectAtIndex:1] forKey:[item objectAtIndex:0]];
            }            	
        }
    }
    
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionary];
    if ([cDataOverrides count] > 0)
        [returnDictionary setObject:cDataOverrides forKey:kCData];
    if ([varOverrides count] > 0)
        [returnDictionary setObject:varOverrides forKey:kVars];

    return returnDictionary;
}

#pragma mark - Getters/Setters
- (void) setEvarToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger evar = [[arguments objectAtIndex:0] integerValue];
    NSString *value = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;
    
    [[ADMS_Measurement sharedInstance] setEvar:evar toValue:value];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setPropToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger prop = [[arguments objectAtIndex:0] integerValue];
    NSString *value = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;
    
    [[ADMS_Measurement sharedInstance] setProp:prop toValue:value];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setHierToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger hier = [[arguments objectAtIndex:0] integerValue];
    NSString *value = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;
    
    [[ADMS_Measurement sharedInstance] setHier:hier toValue:value];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setListVarToValue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger list = [[arguments objectAtIndex:0] integerValue];
    NSString *value = [[arguments objectAtIndex:1] class] != [NSNull class] ? [arguments objectAtIndex:1] : nil;
    
    [[ADMS_Measurement sharedInstance] setListVar:list toValue:value];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) getEvar:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger evar = [[arguments objectAtIndex:0] integerValue];
    
    NSString *evarValue = [[ADMS_Measurement sharedInstance] getEvar:evar];
    
    CDVPluginResult *result = nil;
    if (evarValue) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:evarValue];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = [NSString stringWithFormat:@"ERROR (PhoneGap): No evar set for index %d", evar];
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) getProp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger prop = [[arguments objectAtIndex:0] integerValue];
        
    NSMutableString *propValue = [NSMutableString stringWithString:[[ADMS_Measurement sharedInstance] getProp:prop]];    

    CDVPluginResult *result = nil;
    if (propValue) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:propValue];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = [NSString stringWithFormat:@"ERROR (PhoneGap): No prop set for index %d", prop];
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) getHier:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger hier = [[arguments objectAtIndex:0] integerValue];
    
    NSMutableString *hierValue = [NSMutableString stringWithString:[[ADMS_Measurement sharedInstance] getHier:hier]];
    
    CDVPluginResult *result = nil;
    if (hierValue) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:hierValue];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = [NSString stringWithFormat:@"ERROR (PhoneGap): No hier set for index %d", hier];
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) getListVar:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSInteger list = [[arguments objectAtIndex:0] integerValue];
    
    NSMutableString *listValue = [NSMutableString stringWithString:[[ADMS_Measurement sharedInstance] getListVar:list]];
    
    CDVPluginResult *result = nil;
    if (listValue) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:listValue];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = [NSString stringWithFormat:@"ERROR (PhoneGap): No list value set for index %d", list];
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) clearVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    [[ADMS_Measurement sharedInstance] clearVars];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) trackingQueueSize:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    NSMutableString *returnValue = [NSMutableString stringWithFormat:@"%d", [[ADMS_Measurement sharedInstance] trackingQueueSize]];
    
    CDVPluginResult *result = nil;
    if (returnValue) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnValue];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = @"ERROR (PhoneGap): Could not retrieve tracking queue size";
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) clearTrackingQueue:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
        
    [[ADMS_Measurement sharedInstance] clearTrackingQueue];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

#pragma mark - Properties
//Library Information
- (void) getVersion:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    NSString *version = [ADMS_Measurement sharedInstance].version;
    
    CDVPluginResult *result = nil;
    if (version) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = @"ERROR (PhoneGap): Could not retrieve version";
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

//Logging
- (void) setDebugLogging:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    BOOL debugLogging = [[arguments objectAtIndex:0] boolValue];
    
    [[ADMS_Measurement sharedInstance] setDebugLogging:debugLogging];
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

//Configuration Variables
- (void) setReportSuiteIDs:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *reportSuiteIDs = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [[ADMS_Measurement sharedInstance] setReportSuiteIDs:reportSuiteIDs];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setTrackingServer:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *trackingServer = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;

    [ADMS_Measurement sharedInstance].trackingServer = trackingServer;
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setDataCenter:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *dataCenter = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].dataCenter = dataCenter;
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];    
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setVisitorID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].visitorID = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setCharSet:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].charSet = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setCurrencyCode:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].currencyCode = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setSSLEnabled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    BOOL sslEnabled = [[arguments objectAtIndex:0] boolValue];
    
    [ADMS_Measurement sharedInstance].ssl = sslEnabled;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

//Persistent Tracking Variables
- (void) setPurchaseID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].purchaseID = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setTransactionID:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].transactionID = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setAppState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].appState = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setChannel:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].channel = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setAppSection:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].appSection = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setCampaign:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].campaign = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setProducts:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].products = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].events = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setGeoState:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].geoState = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setGeoZip:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].geoZip = value;
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setPersistentContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    [[ADMS_Measurement sharedInstance] setPersistentContextData:options];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) persistentContextData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[ADMS_Measurement sharedInstance] persistentContextData]];
    
    CDVPluginResult *result = nil;
    if (dict) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[dict JSONString]];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        NSString *error = @"ERROR (PhoneGap): Could not retrieve context data";
        if ([[ADMS_Measurement sharedInstance] debugLogging])
            NSLog(@"%@", error);
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:error];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

- (void) setLinkTrackVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].linkTrackVars = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setLinkTrackEvents:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].linkTrackEvents = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setLightTrackVars:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].lightTrackVars = value;    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

//Offline Tracking Vars
- (void) setOfflineTrackingEnabled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].offlineTrackingEnabled = [value boolValue];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setOfflineThrottleDelay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].offlineThrottleDelay = [value doubleValue];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void) setOfflineHitLimit:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];    
    NSString *value = [[arguments objectAtIndex:0] class] != [NSNull class] ? [arguments objectAtIndex:0] : nil;
    
    [ADMS_Measurement sharedInstance].offlineHitLimit = [value integerValue];    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kOK];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

@end