//
// Created by Jan Chaloupecky on 29/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferDetailViewController.h"
#import "SPOffer.h"
#import "NSError+SPUIError.h"

@interface SPOfferDetailViewController () <UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) SPOffer *offer;
@end

@implementation SPOfferDetailViewController
{
    
}

-(instancetype) initWithOffer:(SPOffer *) offer {
    self = [super init];
    if(self) 
    {
        self.offer = offer;
    }
   return self;
}

#pragma mark - View Life Cycle -


- (void)loadView
{
    [super loadView];
    
    //
    // Setup 
    //
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;


    //
    // Auto Layout
    //
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_webView);
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSLog(@"Loading offer %@", self.offer.link.absoluteString);
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.offer.link]];
}

#pragma mark - Delegates -

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"failed loading offer: %@", error);
    [NSError SPShowGenericError];
}

@end