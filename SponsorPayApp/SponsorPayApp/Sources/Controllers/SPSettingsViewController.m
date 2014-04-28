//
// Created by Jan on 28/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSettingsViewController.h"
#import "SPOffersViewController.h"


@interface SPSettingsViewController ()
@property(nonatomic, strong) UITextField *apiKeyTextField;
@property(nonatomic, strong) UITextField *userIdTextField;
@property(nonatomic, strong) UITextField *applicationIdTextField;
@property(nonatomic, strong) UIButton *showOffersButton;
@end

@implementation SPSettingsViewController {

}

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Settings");
    }

    return self;
}

- (void)loadView {
    [super loadView];


    //
    // Setup text fields
    //
    self.applicationIdTextField = [[UITextField alloc] init];
    self.applicationIdTextField.placeholder = NSLocalizedString(@"Application ID", @"Application ID");

    self.userIdTextField = [[UITextField alloc] init];
    self.userIdTextField.placeholder = NSLocalizedString(@"User ID", @"User ID");

    self.apiKeyTextField = [[UITextField alloc] init];
    self.apiKeyTextField.placeholder = NSLocalizedString(@"API Key", @"API Key");


    self.showOffersButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showOffersButton setTitle:NSLocalizedString(@"Show offers", @"Show offers") forState:UIControlStateNormal];
    [self.showOffersButton addTarget:self action:@selector(showOffersButtonTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];


    //
    // Style
    //
    self.applicationIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.userIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.apiKeyTextField.borderStyle = UITextBorderStyleRoundedRect;


    //
    // Prepare auto layout
    //

    self.applicationIdTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.userIdTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.apiKeyTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.showOffersButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview: self.applicationIdTextField];
    [self.view addSubview: self.userIdTextField];
    [self.view addSubview: self.apiKeyTextField];
    [self.view addSubview: self.showOffersButton];

    //
    // Auto layout
    //
    id topLayoutGuide = self.topLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(topLayoutGuide, _applicationIdTextField, _userIdTextField, _apiKeyTextField, _showOffersButton);
    NSDictionary *metrics = @{
            @"spacing" : @20
    };

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_applicationIdTextField]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userIdTextField]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_apiKeyTextField]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_showOffersButton]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-[_applicationIdTextField]-[_userIdTextField]-[_apiKeyTextField]-(spacing)-[_showOffersButton]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

}


#pragma mark - Actions -

- (void)showOffersButtonTouchedUpInside:(id)sender {

    //
    // Validate
    //
    if(![self isFormValid])
    {

    }
    else
    {
        [self.navigationController pushViewController:[[SPOffersViewController alloc] init] animated:YES];
    }


}

#pragma mark - Private -

-(BOOL) isFormValid
{
    return YES;

}


@end