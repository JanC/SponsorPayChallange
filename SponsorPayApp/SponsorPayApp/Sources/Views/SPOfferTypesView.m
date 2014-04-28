//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferTypesView.h"
#import "SPOfferTypeLabel.h"
#import "UIColor+SPStyle.h"
#import "UIFont+SPStyle.h"


@interface SPOfferTypesView()

@property (nonatomic, strong, readwrite) NSArray *labelViews;
@end

@implementation SPOfferTypesView {

}

-(instancetype) initWithOfferTypesTitles:(NSArray *) titles {
    self = [self init];
    if(self)
    {
        //
        // Create and add buttons as subview
        //
        NSMutableArray *labelViews = [NSMutableArray array];
        [titles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL *stop) {
            UILabel *offerTypeLabel  = [[SPOfferTypeLabel alloc] initWithFrame:CGRectZero];

            //
            // Style
            //
            offerTypeLabel.textColor = [UIColor SPTableViewCellOfferTypeColor];
            offerTypeLabel.backgroundColor = [UIColor SPTableViewCellOfferTypeBackgroundColor];
            offerTypeLabel.font = [UIFont SPTableViewCellOfferTypeFont];

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

- (void)updateConstraints {
    [super updateConstraints];


    //
    // Constraints for subviews: loop over them and add a spacing to the previous view
    //
    __block UIView *previousView = self;

    NSMutableDictionary *metrics = [@{@"spacing" : @2} mutableCopy];


    [self.labelViews enumerateObjectsUsingBlock:^(UIView *labelView, NSUInteger idx, BOOL *stop) {


        if(idx == 0 ) {
            metrics[@"spacing"] = @0; // 1st view has no left spacing
        }
        //
        // Center horizontally
        //
        [self addConstraint:[NSLayoutConstraint constraintWithItem:labelView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0]];
        // pin to previous
        [self addConstraints:
                [NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:[previousView]-(spacing)-[labelView]"
                                            options:0 metrics:metrics
                                              views:@{@"previousView" : previousView, @"labelView" : labelView }]];


    }];

}

@end