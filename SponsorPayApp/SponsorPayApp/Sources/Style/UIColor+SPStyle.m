//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "UIColor+SPStyle.h"


@implementation UIColor (SPStyle)

+ (UIColor *)SPTableViewCellOfferTitleColor {
    return [UIColor colorWithRed:0.37 green:0.43 blue:0.51 alpha:1];
}

+ (UIColor *)SPTableViewCellOfferTeaserColor {
    return [UIColor colorWithRed:0.56 green:0.58 blue:0.6 alpha:1];
}



+ (UIColor *)SPTableViewCellOfferTypeColor {
   return [UIColor colorWithRed:0.49 green:0.54 blue:0.6 alpha:1];
}

+ (UIColor *)SPTableViewCellOfferTypeBackgroundColor {
    return [UIColor colorWithRed:0.91 green:0.93 blue:0.95 alpha:1];
}

+ (UIColor *)SPTableViewCellOfferPayoutColor {
    return [UIColor whiteColor];
}

+ (UIColor *)SPTableViewCellOfferPayoutBackgroundColor {
    return [UIColor colorWithRed:0.08 green:0.73 blue:0.84 alpha:1];
}

+ (UIColor *)SPDestructiveColor {
    return [UIColor colorWithRed:1 green:0.23 blue:0.19 alpha:1];
}

@end