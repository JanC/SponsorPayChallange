//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPThumbnail.h"

@implementation SPThumbnail {

}
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self)
    {
        _highresURL = dictionary[@"highres"] ? [NSURL URLWithString:dictionary[@"highres"]] : nil;
        _highresURL = dictionary[@"lowres"] ? [NSURL URLWithString:dictionary[@"lowres"]] : nil;
    }
    return self;
}

@end