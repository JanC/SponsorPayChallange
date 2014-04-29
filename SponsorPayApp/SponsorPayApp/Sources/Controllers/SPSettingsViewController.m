//
// Created by Jan on 28/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSettingsViewController.h"
#import "SPOffersViewController.h"
#import "SPCredentials.h"
#import "SPSDKManager.h"
#import "UIColor+SPStyle.h"

@interface SPSettingsViewController ()
@property(nonatomic, strong) UITextField *apiKeyTextField;
@property(nonatomic, strong) UITextField *userIdTextField;
@property(nonatomic, strong) UITextField *applicationIdTextField;
@property(nonatomic, strong) UIButton *showOffersButton;
@property(nonatomic, strong) UIButton *fillDebugDataButton;

@property (nonatomic, strong) SPCredentials *credentials;
@end

@implementation SPSettingsViewController {

}

- (id)initWithCredentials:(SPCredentials *) credentials
{
    self = [super init];

    if (self)
    {
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.credentials = credentials;
    }

    return self;
}

- (void)loadView
{
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

    self.fillDebugDataButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.fillDebugDataButton setTitleColor:[UIColor SPDestructiveColor] forState:UIControlStateNormal];
    [self.fillDebugDataButton setTitle:NSLocalizedString(@"Use Sample Credentials", ) forState:UIControlStateNormal];
    [self.fillDebugDataButton addTarget:self action:@selector(fillDataButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

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
    self.fillDebugDataButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.applicationIdTextField];
    [self.view addSubview:self.userIdTextField];
    [self.view addSubview:self.apiKeyTextField];
    [self.view addSubview:self.showOffersButton];
    [self.view addSubview:self.fillDebugDataButton];

    //
    // Fill saved credentials
    //

    if(self.credentials)
    {
        self.apiKeyTextField.text = self.credentials.apiKey;
        self.userIdTextField.text = self.credentials.userId;
        self.applicationIdTextField.text = self.credentials.applicationId;
    }


    //
    // Add debug button to fill the fields
    //



    //
    // Auto layout
    //
    id topLayoutGuide = self.topLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(topLayoutGuide, _applicationIdTextField, _userIdTextField, _apiKeyTextField, _showOffersButton, _fillDebugDataButton);
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

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_fillDebugDataButton]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-[_applicationIdTextField]-[_userIdTextField]-[_apiKeyTextField]-(spacing)-[_showOffersButton]-[_fillDebugDataButton]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

}

- (void)fillDataButtonTouchUpInside:(id)sender
{
    self.apiKeyTextField.text = @"1c915e3b5d42d05136185030892fbb846c278927";
    self.applicationIdTextField.text = @"2070";
    self.userIdTextField.text = @"spiderman";
}

#pragma mark - Actions -

- (void)showOffersButtonTouchedUpInside:(id)sender
{

    //
    // Validate
    //
    if (![self isFormValid])
    {

    }
    else
    {
        [[SPSDKManager sharedManager] setupForApplicationId:self.applicationIdTextField.text
                                                     userId:self.userIdTextField.text apiKey:self.apiKeyTextField.text];

        [self.navigationController pushViewController:[[SPOffersViewController alloc] init] animated:YES];
    }

}

#pragma mark - Private -

- (BOOL)isFormValid
{
    return YES;

}

@end