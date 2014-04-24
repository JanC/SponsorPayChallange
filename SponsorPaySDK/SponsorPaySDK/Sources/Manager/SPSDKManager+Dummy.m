//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSDKManager+Dummy.h"
#import "SPJSONDataParser.h"
#import "SPOfferResponse.h"


@implementation SPSDKManager (Dummy)

-(NSArray *) sampleOffers {
    static NSArray *offersArray;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        SPJSONDataParser *parser = [[SPJSONDataParser alloc] init];

        NSString *path = [[NSBundle mainBundle] pathForResource:@"response" ofType:@"json"];

        SPOfferResponse *offerResponse = [parser parseOfferListResponse:[NSData dataWithContentsOfFile:path]];
        offersArray = offerResponse.offers;

    });

    return offersArray;

}
@end