//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SPOfferCompletionBlock) (NSObject *spOfferResponse);

@interface SPOfferClient : NSObject

- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey;

/**
 *  Fetches the list if the Offers
 */
-(NSURLSessionTask *) listOffersWithCompletion:(SPOfferCompletionBlock) completion;

@end