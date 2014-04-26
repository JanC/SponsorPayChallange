//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferType.h"

@implementation SPOfferType {

}
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self)
    {
        _readable = dictionary[@"readable"];
        _uid = [dictionary[@"offer_type_id"] integerValue];

    }
    return self;
}

@end