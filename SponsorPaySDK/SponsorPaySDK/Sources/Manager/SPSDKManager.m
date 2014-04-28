//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSDKManager.h"
#import "SPOfferClient.h"
#import "SPURLGenerator.h"
#import "SPCredentials.h"

@interface SPSDKManager ()

//
// API credentials
//

@property(nonatomic, strong, readwrite) SPCredentials *credentials;

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

    self.credentials = [[SPCredentials alloc] initWithApplicationId:applicationId userId:userId apiKey:apiKey];

    self.offerClient = [[SPOfferClient alloc] initWithCredentials:self.credentials];

    //
    // Save Credentials
    //
    [self saveCredentials:self.credentials];

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

#pragma mark - Private -

-(void) saveCredentials:(SPCredentials *)credentials {
    NSDictionary *dictionary = @{
            @"applicationId" : credentials.applicationId,
            @"userId" : credentials.userId,
            @"apiKey" : credentials.apiKey,
    };

    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"SPCredentials"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (SPCredentials *)loadCredentials
{
    SPCredentials *credentials;
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"SPCredentials"];
    if (dictionary) {
        credentials = [[SPCredentials alloc] initWithApplicationId:dictionary[@"applicationId"]
                                                            userId:dictionary[@"userId"]
                                                            apiKey:dictionary[@"apiKey"]];
    }

    return credentials;

}

@end