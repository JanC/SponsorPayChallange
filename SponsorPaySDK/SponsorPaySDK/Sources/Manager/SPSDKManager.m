//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSDKManager.h"
#import "SPOfferClient.h"

@interface SPSDKManager ()

//
// API credentials
//
@property(nonatomic, copy, readwrite) NSString *applicationId;
@property(nonatomic, copy, readwrite) NSString *userId;
@property(nonatomic, copy, readwrite) NSString *apiKey;

//
// Network client
//
@property(nonatomic, strong, readwrite) SPOfferClient *offerClient;

@end

@implementation SPSDKManager {

}

+ (id)sharedManager
{
    static SPSDKManager *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[SPSDKManager alloc] init];

    });

    return instance;
}

- (void)setupForApplicationId:(NSString *)applicationId
    userId:(NSString *)userId
    apiKey:(NSString *)apiKey
{

    self.applicationId = applicationId;
    self.userId = userId;
    self.apiKey = apiKey;

    self.offerClient = [[SPOfferClient alloc] initWithApplicationId:applicationId userId:userId apiKey:apiKey];

}

@end