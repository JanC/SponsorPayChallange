//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPOfferResponse;

@protocol SPDataParser <NSObject>

/**
* Parser the response from the backend API as defined in
* http://developer.sponsorpay.com/content/ios/offer-wall/offer-api/
*/
- (SPOfferResponse *)parseOfferListResponse:(NSData *)data;
@end