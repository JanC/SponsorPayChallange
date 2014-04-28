//
// Created by Jan on 28/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPLoadingCell.h"
#import "UIFont+SPStyle.h"
#import "UIColor+SPStyle.h"

@implementation SPLoadingCell {

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {

        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;

        label.font = [UIFont SPTableViewCellOfferTeaserFont];
        label.textColor = [UIColor SPTableViewCellOfferTeaserColor];

        label.text = NSLocalizedString(@"Loading ...", @"Loading ...");

        [self.contentView addSubview:label];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1
                                                                      constant:0]];

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];

    }

    return self;
}

@end