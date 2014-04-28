//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOffer.h"
#import "SPTime.h"
#import "SPThumbnail.h"
#import "SPOfferType.h"

@implementation SPOffer {

}
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];

    if (self)
    {
        _title = dictionary[@"title"];
        _offerId = dictionary[@"offer_id"];
        _teaser = dictionary[@"teaser"];
        _requiredActions = dictionary[@"required_actions"];
        _payout = @( [dictionary[@"payout"] doubleValue] );

        NSMutableArray *offerTypes = [NSMutableArray array];
        [dictionary[@"offer_types"] enumerateObjectsUsingBlock:^(NSDictionary * offerTypeDictionary, NSUInteger idx, BOOL *stop) {
            SPOfferType *offerType = [[SPOfferType alloc] initWithDictionary:offerTypeDictionary];
            [offerTypes addObject:offerType];
        }];

        _offerTypes = [NSArray arrayWithArray:offerTypes];

        _thumbnail = [[SPThumbnail alloc] initWithDictionary:dictionary[@"thumbnail"]];

    }

    return self;
}

- (NSArray *)offerTypesTitles
{
    NSMutableArray *titles = [NSMutableArray array];
    [self.offerTypes enumerateObjectsUsingBlock:^(SPOfferType * offerType, NSUInteger idx, BOOL *stop) {
        if(![titles containsObject:offerType.readable])
        {
            [titles addObject:offerType.readable];
        }
    }];
    return titles;
}

@end