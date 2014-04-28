//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDictionaryInitializer.h"

@class SPTime;
@class SPThumbnail;


@interface SPOffer : NSObject <SPDictionaryInitializer>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *offerId;
@property (nonatomic, copy, readonly) NSString *teaser;
@property (nonatomic, copy, readonly) NSString *requiredActions;
@property (nonatomic, strong, readonly) NSURL *link;
@property (nonatomic, strong, readonly) NSArray *offerTypes;
@property (nonatomic, strong, readonly) SPThumbnail *thumbnail;
@property (nonatomic, strong, readonly) SPTime *timeToPayout;
@property (nonatomic, strong, readonly) NSNumber *payout;

// Helper that returns a list of unique offer type tiles
@property (nonatomic, strong, readonly) NSArray *offerTypesTitles;

@end