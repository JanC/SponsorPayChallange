//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferTypesView.h"
#import "SPOfferTypeLabel.h"
#import "UIColor+SPStyle.h"
#import "UIFont+SPStyle.h"

@interface SPOfferTypesView ()

@property(nonatomic, strong, readwrite) NSArray *labelViews;
@end

@implementation SPOfferTypesView
{
}

- (instancetype)initWithOfferTypesTitles:(NSArray *)titles
{
    self = [self init];
    if ( self )
    {
        //
        // Create and add buttons as subview
        //
        NSMutableArray *labelViews = [NSMutableArray array];
        [titles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL *stop) {
            UILabel *offerTypeLabel = [[SPOfferTypeLabel alloc] initWithFrame:CGRectZero];

            //
            // Style
            //
            offerTypeLabel.textColor = [UIColor SPTableViewCellOfferTypeColor];
            offerTypeLabel.backgroundColor = [UIColor SPTableViewCellOfferTypeBackgroundColor];
            offerTypeLabel.font = [UIFont SPTableViewCellOfferTypeFont];

            offerTypeLabel.text = buttonTitle;

            //
            //  prepare auto layout
            //
            offerTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;

            [self addSubview:offerTypeLabel];
            [labelViews addObject:offerTypeLabel];
        }];

        self.labelViews = [NSArray arrayWithArray:labelViews];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];


    //
    // Constraints for subviews: loop over them and add a spacing to the previous view
    //
    __block UIView *previousView = self;

    NSMutableDictionary *metrics = [@{@"spacing" : @2} mutableCopy];

    [self.labelViews enumerateObjectsUsingBlock:^(UIView *labelView, NSUInteger idx, BOOL *stop) {

        // pin horizontally to superview or to previous label
        NSString *constraint =  idx == 0 ? @"H:|[labelView]" : @"H:[previousView]-(spacing)-[labelView]";
        [self addConstraints:
                [NSLayoutConstraint
                        constraintsWithVisualFormat:constraint
                                            options:0 metrics:metrics
                                              views:@{@"previousView" : previousView, @"labelView" : labelView}]];

        [self addConstraints:
                [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[labelView]|"
                                                        options:0 metrics:nil
                                                          views:@{@"labelView" : labelView} ]];


        previousView = labelView;
    }];


    // last one, pin to right, this dictates content size
//    [self addConstraints:
//            [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelView]|"
//                                                    options:0 metrics:nil
//                                                      views:@{@"labelView" : previousView}]];

}

- (CGSize)intrinsicContentSize
{
    if(self.labelViews.count == 0)
    {
        return [super intrinsicContentSize];
    } else
    {
        UILabel *label = self.labelViews[0];
        return CGSizeMake(UIViewNoIntrinsicMetric, label.intrinsicContentSize.height);
    }

}

@end