//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOffersViewController.h"
#import "SPOfferTableViewCell.h"
#import "SPSDKManager.h"
#import "SPSDKManager+Dummy.h"
#import "SPOffer.h"

#pragma mark - Constants

NSString *const SPOffersViewControllerCellId = @"SPOffersViewControllerCellId";

@interface SPOffersViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *offersArray;

@end

@implementation SPOffersViewController {

}

- (id)init
{
    self = [super init];

    if (self)
    {

    }

    return self;
}

#pragma mark - View Life Cycle

- (void)loadView
{
    [super loadView];

    //
    // Setup Table View
    //
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[SPOfferTableViewCell class] forCellReuseIdentifier:SPOffersViewControllerCellId];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];

    //
    // Auto Layout for Table View
    //
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_tableView);
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];

    #warning dummy content
    self.offersArray = [[SPSDKManager sharedManager] sampleOffers];
}

#pragma mark - Protocols -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.offersArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    //
    // Calculate dynamically the height of the cell after the auto layout has been applied
    //

    SPOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPOffersViewControllerCellId];

    [self configureCell:cell forIndexPath:indexPath];

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];


    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct cell height for different table view widths if the cell's height depends on its width (due to
    // multi-line UILabels word wrapping, etc). We don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    // Also note, the final width of the cell may not be the width of the table view in some cases, for example when a
    // section index is displayed along the right side of the table view. You must account for the reduced cell width.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));

    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
    // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
    // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
    [cell setNeedsLayout];
    [cell layoutIfNeeded];

    // Get the actual height required for the cell's contentView
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1.0f;

    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPOffersViewControllerCellId forIndexPath:indexPath];

    //
    // Configure cell
    //
    [self configureCell:cell forIndexPath:indexPath];

    return cell;
}

#pragma mark - Private -

- (void)configureCell:(SPOfferTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    SPOffer *offer = self.offersArray[(NSUInteger)indexPath.row];
    cell.offerImageView.image = [UIImage imageNamed:@"cellTestImage"];
    cell.offerTitleLabel.text = offer.title;
    cell.offerTeaserLabel.text = offer.teaser;
    cell.offerTypeLabel.text = @"Free";
    cell.offerPayoutLabel.text = @"90";
}

@end