//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPOfferResponse;

typedef void (^SPOfferCompletionBlock) (SPOfferResponse *offerResponse);

@interface SPOfferClient : NSObject

- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey;

/**
 *  Fetches the list if the Offers
 */
- (NSURLSessionTask *)listOffersWithCustomParameter:(NSDictionary *)customParameters completion:(SPOfferCompletionBlock)completion;

@end