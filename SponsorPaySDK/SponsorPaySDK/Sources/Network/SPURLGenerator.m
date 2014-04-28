//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPURLGenerator.h"
#import "SPSigner.h"
#import "SPSHA1Signer.h"
#import "SPCredentials.h"
#import <AdSupport/AdSupport.h>

#pragma mark - Constant Parameter names

NSString *const SPURLOffersParamAppId = @"appid";
NSString *const SPURLOffersParamUid = @"uid";
NSString *const SPURLOffersParamLocale = @"locale";
NSString *const SPURLOffersParamOsVersion = @"os_version";
NSString *const SPURLOffersParamTimeStamp = @"timestamp";
NSString *const SPURLOffersParamHashKey = @"hashkey";
NSString *const SPURLOffersParamIP = @"ip";
NSString *const SPURLOffersParamPub0 = @"pub0";
NSString *const SPURLOffersParamPage = @"page";
NSString *const SPURLOffersParamOfferTypes = @"offer_types";
NSString *const SPURLOffersParamPSTime = @"ps_time";
NSString *const SPURLOffersParamAppleIdFa = @"apple_idfa";
NSString *const SPURLOffersParamAppleIdFaTrackingEnabled = @"apple_idfa_tracking_enabled";
NSString *const SPURLOffersParamMacDevice = @"device";

@interface SPURLGenerator ()


@property(nonatomic, strong, readwrite) SPCredentials *credentials;

@property(nonatomic, strong, readwrite) NSMutableDictionary *parameters;
@property(nonatomic, strong, readwrite) id <SPSigner> requestSigner;

@end

@implementation SPURLGenerator {

}

- (instancetype)initWithCredentials:(SPCredentials *)credentials signer:(id <SPSigner>)signer {
    self = [super init];

    if (self) {
        self.credentials = credentials;


        self.parameters = [@{
                SPURLOffersParamAppId : self.credentials.applicationId,
                SPURLOffersParamUid : self.credentials.userId,
                SPURLOffersParamOsVersion : [[UIDevice currentDevice] systemVersion],
                SPURLOffersParamAppleIdFa : [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],
        } mutableCopy];

        self.requestSigner = signer;
    }

    return self;
}

- (NSString *)offersURLWithParameters:(NSDictionary *)params  {
    //
    // http://api.sponsorpay.com/feed/v1/offers.json?appid=[APP_ID]&uid=[USER_ID]&ip=[IP_ADDRESS]&locale=[LOCALE]&device_id=[DEVICE_ID]&ps_time=[TIMESTAMP]&pub0=[CUSTOM]&timestamp=[UNIX_TIMESTAMP]&offer_types=[OFFER_TYPES]&android_id=[ANDROID_ID]&hashkey=[HASHKEY]
    //
    NSDictionary *dictionary = [self addDynamicParametersToCustomParameters:params];

    NSString *urlString = [self concatenateParameters:dictionary];

    //
    // Create the hash of all parameters and append it as "hashkey" parameter
    //
    if(self.requestSigner)
    {
        NSString *signature = [self.requestSigner signText:urlString withSecretToken:self.credentials.apiKey];
        urlString = [NSString stringWithFormat:@"%@&%@=%@", urlString, SPURLOffersParamHashKey, signature];
    }

    return urlString;
}


// todo
// hashkey
//

#pragma mark - Private

/**
 *  Concatenates all param values in "key=value&key2=value2" format. The keys are sorted alphabetically
 *
 *
 *  @return The concatenated non URL encoded string
 */
- (NSString *)concatenateParameters:(NSDictionary *)parameters {
    __block NSString *urlString = @"";

    [[[parameters allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] enumerateObjectsUsingBlock:^(NSString *parameterKey, NSUInteger idx, BOOL *stop) {

        if (idx > 0) {
            urlString = [urlString stringByAppendingString:@"&"];
        }
        NSString *value = parameters[parameterKey];
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", parameterKey, value]];
    }];

    return urlString;
}

/**
 *  Adds runtime parameters to the static parameters
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)addDynamicParametersToCustomParameters:(NSDictionary *)customParameters {
    // self.parameters[SPURLOffersParamIP] = @""

    NSMutableDictionary *dynamicParameters = [@{

            SPURLOffersParamTimeStamp : [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]],
            SPURLOffersParamLocale : [[NSLocale preferredLanguages] objectAtIndex:0],
            SPURLOffersParamAppleIdFaTrackingEnabled : [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ? @"true" : @"false"
    } mutableCopy];

    [dynamicParameters addEntriesFromDictionary:self.parameters];
    [dynamicParameters addEntriesFromDictionary:customParameters];

    return dynamicParameters;
}

@end