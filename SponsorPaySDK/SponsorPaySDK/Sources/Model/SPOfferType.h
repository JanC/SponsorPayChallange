//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDictionaryInitializer.h"

typedef NS_ENUM(NSUInteger, SPOfferTypeUID)
{
    SPOfferTypeMobile = 100,
    SPOfferTypeDownload = 101,
    SPOfferTypeTrial = 102,
    SPOfferTypeSale = 103,
    SPOfferTypeInfoRequestOffers = 104,
    SPOfferTypeRegistrationOffers = 105,
    SPOfferTypeGames = 106,
    SPOfferTypeGambling = 107,
    SPOfferTypeRegistrationData = 108,
    SPOfferTypeGamesOffers = 109,
    SPOfferTypeSurveys = 110,
    SPOfferTypeDatingOffers = 111,
    SPOfferTypeFreeOffers = 112,
    SPOfferTypeSaleVideoOffers = 113,
};

@interface SPOfferType : NSObject <SPDictionaryInitializer>

@property(nonatomic, copy, readonly) NSString *readable;
@property(nonatomic, assign, readonly) NSInteger uid;

@end