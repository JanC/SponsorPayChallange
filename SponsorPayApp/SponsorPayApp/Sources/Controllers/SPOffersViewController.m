//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOffersViewController.h"
#import "SPOfferTableViewCell.h"
#import "SPSDKManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SPOffer.h"
#import "NSNumber+SPFormat.h"
#import "SPOfferResponse.h"
#import "SPThumbnail.h"
#import "SPOfferType.h"
#import "SPLoadingCell.h"
#import "NSError+SPUIError.h"
#import "SPOfferDetailViewController.h"

#pragma mark - Constants

NSString *const SPOffersViewControllerCellId = @"SPOffersViewControllerCellId";
NSString *const SPOffersViewControllerLoadingCellId = @"SPOffersViewControllerLoadingCellId";


static CGFloat const SPOffersViewControllerLoadingCellHeight = 40.0;

// The number of the 1st page from the API
static NSUInteger const SPOffersViewControllerFirstPageIndex = 1;

@interface SPOffersViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong) UIRefreshControl *refreshControl;

// data source
@property(nonatomic, strong, readwrite) SPOfferResponse *offerResponse;
@property(nonatomic, strong, readwrite) NSMutableArray *cumulatedOffers;
@property(nonatomic, assign, readwrite) NSUInteger currentPage;

@end

@implementation SPOffersViewController {

}

- (id)init
{
    self = [super init];

    if (self)
    {
         self.title = NSLocalizedString(@"Offers", @"Offers");
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
    [self.tableView registerClass:[SPLoadingCell class] forCellReuseIdentifier:SPOffersViewControllerLoadingCellId];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];

    //
    // Setup refresh control
    //
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

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

    // 1st page
    self.currentPage = SPOffersViewControllerFirstPageIndex;
    self.cumulatedOffers = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.refreshControl beginRefreshing];
    [self handleRefresh:nil];
}

#pragma mark - Protocols -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRows = self.cumulatedOffers.count;

    //
    // add the loading cell if we are not displaying the last page
    //
    if (self.currentPage < self.offerResponse.pages)
    {
        numberOfRows++;
    }

    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat height = SPOffersViewControllerLoadingCellHeight;

    if (![self isIndexOfLoadingCell:indexPath])
    {
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
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

        // Add an extra point to the height to account for the cell separator, which is added between the bottom
        // of the cell's contentView and the bottom of the table view cell.
        height += 1.0f;
    }

    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //
    // If we are beyond the offer count, we are showing the loading cell
    //

    NSString *cellId = [self isIndexOfLoadingCell:indexPath] ? SPOffersViewControllerLoadingCellId : SPOffersViewControllerCellId;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    [self configureCell:cell forIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    SPOffer *offer = self.cumulatedOffers[(NSUInteger)indexPath.row];
    SPOfferDetailViewController *offerDetailViewController = [[SPOfferDetailViewController alloc] initWithOffer:offer];
    [self.navigationController pushViewController:offerDetailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isIndexOfLoadingCell:indexPath])
    {
        [self listOffersForNextPage];
    }
}

#pragma mark - Private -

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    if ([self isIndexOfLoadingCell:indexPath])
    {
        [self configureLoadingCell:cell forIndexPath:indexPath];
    }
    else
    {
        [self configureOffersCell:cell forIndexPath:indexPath];
    }
}

- (void)configureLoadingCell:(UITableViewCell *)tableViewCell forIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([tableViewCell isKindOfClass:[SPLoadingCell class]], @"%@ must be called a class of %@", NSStringFromSelector(@selector(configureLoadingCell:forIndexPath:)), NSStringFromClass([SPLoadingCell class]));
    // if there is anything to configure here, do it.
}

- (void)configureOffersCell:(UITableViewCell *)tableViewCell forIndexPath:(NSIndexPath *)indexPath
{

    // safety
    NSAssert([tableViewCell isKindOfClass:[SPOfferTableViewCell class]], @"%@ must be called a class of %@", NSStringFromSelector(@selector(configureCell:forIndexPath:)), NSStringFromClass([SPOfferTableViewCell class]));

    SPOfferTableViewCell *cell = (SPOfferTableViewCell *)tableViewCell;
    SPOffer *offer = self.cumulatedOffers[(NSUInteger)indexPath.row];
    cell.offerImageView.image = [UIImage imageNamed:@"cellTestImage"];
    cell.offerTitleLabel.text = offer.title;
    cell.offerTeaserLabel.text = offer.teaser;
    [cell setOfferTypeTitles:offer.offerTypesTitles];
    cell.offerPayoutLabel.text = [offer.payout SPPayoutString];

    cell.offerImageView.alpha = 0;
    SPOfferTableViewCell *__weak weakCell = cell;

    [cell.offerImageView cancelCurrentImageLoad];
    [cell.offerImageView setImageWithURL:offer.thumbnail.highresURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        // if image downloaded, make a alpha animation
        if (error)
        {
            NSLog(@"failed getting tumbnail image %@: %@", offer.thumbnail.highresURL.absoluteString, error);
        }
        [UIView animateWithDuration:cacheType == SDImageCacheTypeNone ? 1.0:0.0 animations:^{
                weakCell.offerImageView.alpha = 1;
            }];
    }];
}

/**
 * Resets the current page and loads the data
 */
- (void)handleRefresh:(id)handleRefresh
{
    self.currentPage = SPOffersViewControllerFirstPageIndex;
    [self listOffersForCurrentPage];
}

- (void)listOffersForCurrentPage
{
    [[SPSDKManager sharedManager] listOffersPage:self.currentPage completion:^(SPOfferResponse *offerResponse, NSError *error) {
        self.offerResponse = offerResponse;
        [self.cumulatedOffers addObjectsFromArray:offerResponse.offers];
        dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];

            if(error)
            {
                [NSError SPShowErrorWithTitle:@"Oups" message:error.localizedDescription];
            } else
            {
                [self.tableView reloadData];
            }


            });
    }];
}

- (void)listOffersForNextPage
{
    self.currentPage++;
    [self listOffersForCurrentPage];
}

- (BOOL)isIndexOfLoadingCell:(NSIndexPath *)indexPath
{
    return indexPath.row >= self.cumulatedOffers.count;
}

@end