//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferTypeLabel.h"

static const NSInteger SPOfferTypeLabelHorizontalTextInset = 5;


@interface SPOfferTypeLabel()

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@end

@implementation SPOfferTypeLabel {

}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, SPOfferTypeLabelHorizontalTextInset, 0, SPOfferTypeLabelHorizontalTextInset);
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    return CGRectInset([self.attributedText boundingRectWithSize:CGSizeMake(999, 999)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                         context:nil], -SPOfferTypeLabelHorizontalTextInset, -1);
}

//- (void)drawTextInRect:(CGRect)rect {
//    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
//}

@end