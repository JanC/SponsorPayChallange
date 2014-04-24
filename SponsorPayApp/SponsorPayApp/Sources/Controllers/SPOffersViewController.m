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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPOffersViewControllerCellId forIndexPath:indexPath];

    //
    // Configure cell
    //
    SPOffer *offer = self.offersArray[(NSUInteger)indexPath.row];

    cell.textLabel.text = offer.title;

    return cell;
}

@end