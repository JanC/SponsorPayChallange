//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPOfferTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *offerImageView;
@property (nonatomic, strong, readonly) UILabel *offerTitleLabel;
@property (nonatomic, strong, readonly) UILabel *offerTeaserLabel;
@property (nonatomic, strong, readonly) UILabel *offerPayoutLabel;


@property(nonatomic, strong) NSDictionary *metrics;

-(void) setOfferTypeTitles:(NSArray *)offerTypeTitles;
@end