//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDictionaryInitializer.h"

@class SPOfferResponseInformation;


@interface SPOfferResponse : NSObject <SPDictionaryInitializer>

@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, assign, readonly) NSInteger pages;
@property (nonatomic, strong, readonly) SPOfferResponseInformation *information;
@property (nonatomic, strong, readonly) NSArray *offers; // array of SPOffers
@end