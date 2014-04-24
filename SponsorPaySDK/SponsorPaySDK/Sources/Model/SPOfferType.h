//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDictionaryInitializer.h"


@interface SPOfferType : NSObject <SPDictionaryInitializer>

@property(nonatomic, copy, readonly) NSString *readable;
@property(nonatomic, assign, readonly) NSUInteger *uid;

@end