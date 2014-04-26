//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "NSNumber+SPFormat.h"


@implementation NSNumber (SPFormat)

-(NSString *) SPPayoutString {
    static NSNumberFormatter *formatter;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositivePrefix:@"+"];
    });
    return  [formatter stringFromNumber:self];
}
@end