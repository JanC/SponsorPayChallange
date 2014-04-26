//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferTableViewCell.h"

@interface SPOfferTableViewCell()

@property (nonatomic, strong, readwrite) UIImageView *offerImageView;
@property (nonatomic, strong, readwrite) UILabel *offerTitleLabel;
@property (nonatomic, strong, readwrite) UILabel *offerTeaserLabel;
@property (nonatomic, strong, readwrite) UILabel *offerPayoutLabel;
@property (nonatomic, strong, readwrite) UILabel *offerTypeLabel;

@property (nonatomic, assign, readwrite) BOOL didUpdateConstraints;

@end


@implementation SPOfferTableViewCell {

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //
        // Init subviews
        //
        self.offerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];

        self.offerTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.offerTeaserLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.offerPayoutLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.offerTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];

        //
        // Style
        //


        //
        // Prepare auto layout
        //
        self.offerImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.offerTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.offerTeaserLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.offerPayoutLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.offerTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addSubview:self.offerImageView];
        [self.contentView addSubview:self.offerTitleLabel];
        [self.contentView addSubview:self.offerTeaserLabel];
        [self.contentView addSubview:self.offerPayoutLabel];
        [self.contentView addSubview:self.offerTypeLabel];

    }

    return self;
}

- (void)updateConstraints {
    [super updateConstraints];

    if(self.didUpdateConstraints)
    {
        return;
    }

    NSDictionary *views = NSDictionaryOfVariableBindings(_offerImageView, _offerPayoutLabel, _offerTeaserLabel, _offerTitleLabel, _offerTypeLabel);
    NSDictionary *metrics = @{
            @"topSpace" : @10,
            @"bottomSpace" : @10,
            @"horizontalSpace" : @10,
            @"verticalSpace" : @0,
            @"imageViewWidth" : @60,
            @"imageViewHeight" : @60

    };


    //
    // Image View: pin to top left
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizontalSpace)-[_offerImageView(imageViewWidth)]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topSpace)-[_offerImageView(imageViewHeight)]" options:0 metrics:metrics views:views]];

    //
    // Title: pin to top and image view
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_offerImageView]-[_offerTitleLabel]-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topSpace)-[_offerTitleLabel]" options:0 metrics:metrics views:views]];

    //
    // Payout: under the title, pinned to right
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_offerPayoutLabel]-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_offerTitleLabel]-[_offerPayoutLabel]" options:0 metrics:metrics views:views]];

    //
    // Offer types e.g. "Task, Free, App"
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_offerImageView]-[_offerTypeLabel]-(>=horizontalSpace)-[_offerPayoutLabel]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_offerTitleLabel]-(verticalSpace)-[_offerTypeLabel]" options:0 metrics:metrics views:views]];

    //
    // Offer teaser: pin to bottom and under offer type
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_offerImageView]-[_offerTeaserLabel]-(>=horizontalSpace)-[_offerPayoutLabel]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_offerTypeLabel]-(verticalSpace)-[_offerTeaserLabel]-(>=bottomSpace)-|" options:0 metrics:metrics views:views]];

    self.didUpdateConstraints = YES;

}


@end