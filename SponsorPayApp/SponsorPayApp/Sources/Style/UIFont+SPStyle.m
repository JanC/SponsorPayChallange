//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "UIFont+SPStyle.h"


@implementation UIFont (SPStyle)
+ (UIFont *)SPTableViewCellOfferTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
}

+ (UIFont *)SPTableViewCellOfferTeaserFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
}

+ (UIFont *)SPTableViewCellOfferTypeFont {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:9];
}

+ (UIFont *)SPTableViewCellOfferPayoutFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
}

@end