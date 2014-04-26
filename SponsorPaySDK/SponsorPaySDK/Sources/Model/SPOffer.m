//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOffer.h"
#import "SPTime.h"
#import "SPThumbnail.h"

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

        #warning incomplete implementation
    }

    return self;
}
@end