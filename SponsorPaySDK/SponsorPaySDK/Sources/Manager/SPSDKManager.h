//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPOfferClient.h"

@interface SPSDKManager : NSObject

+ (id)sharedManager;

- (void)setupForApplicationId:(NSString *)applicationId
    userId:(NSString *)userId
    apiKey:(NSString *)apiKey;

/**
* If any, returns saved credentials. Nil if no saved data
*/
- (SPCredentials *)loadCredentials;

- (NSURLSessionTask *)listOffersPage:(NSUInteger)page completion:(SPOfferCompletionBlock)completion;
@end