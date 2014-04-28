//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPSigner;

extern NSString *const SPURLOffersParamPage;

@interface SPURLGenerator : NSObject

- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey signer:(id <SPSigner>)signer;


/**
 *  Generates the URL String for the offers API including all the required parameters
 *
 *  @param params Any application supplied parameters.
 *
 *  @return <#return value description#>
 */
-(NSString *) offersURLWithParameters:(NSDictionary *) params;
@end