//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSDKManager.h"
#import "SPOfferClient.h"
#import "SPURLGenerator.h"

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

- (NSURLSessionTask *)listOffersPage:(NSUInteger)page completion:(SPOfferCompletionBlock)completion {

    NSAssert(self.offerClient, @"You must call %@ first", NSStringFromSelector(@selector(setupForApplicationId:userId:apiKey:)));

    NSDictionary *requestParameters;
    if(page > 0) {
        requestParameters = @{
                SPURLOffersParamPage : @(page),
               // SPURLOffersParamOfferTypes : @"100,101,102,103,104,105,106,107,108,109,110,111,112,113"
        };
    }


    return [self.offerClient listOffersWithCustomParameter:requestParameters completion:^(SPOfferResponse *offerResponse) {

        //
        // Just forward the completion to the caller. Here is the place where I would do any local persistence or
        // other business logic
        //
        if(completion)
        {
            completion(offerResponse);
        }

    }];
}

@end