//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPOfferResponse;
@class SPCredentials;

typedef void (^SPOfferCompletionBlock) (SPOfferResponse *offerResponse, NSError *error);

@interface SPOfferClient : NSObject

- (instancetype)initWithCredentials:(SPCredentials *)credentials;

/**
 *  Fetches the list if the Offers
 */
- (NSURLSessionTask *)listOffersWithCustomParameter:(NSDictionary *)customParameters completion:(SPOfferCompletionBlock)completion;

@end