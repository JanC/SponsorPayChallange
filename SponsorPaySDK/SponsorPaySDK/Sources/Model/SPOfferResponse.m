//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferResponse.h"
#import "SPOfferResponseInformation.h"
#import "SPOffer.h"

@implementation SPOfferResponse {

}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];

    if (self)
    {
        _code = dictionary[@"code"];
        _message = dictionary[@"message"];
        _count = [dictionary[@"count"] integerValue];
        _pages = [dictionary[@"pages"] integerValue];

        _information = [[SPOfferResponseInformation alloc] initWithDictionary:dictionary[@"information"]];

        NSMutableArray *offersArray = [NSMutableArray array];
        [(NSArray *)dictionary[@"offers"] enumerateObjectsUsingBlock :^(NSDictionary *offerDictionary, NSUInteger idx, BOOL *stop) {
            SPOffer *offer = [[SPOffer alloc] initWithDictionary:offerDictionary];
            [offersArray addObject:offer];
        }];

        _offers = [NSArray arrayWithArray:offersArray];
    }

    return self;
}

@end