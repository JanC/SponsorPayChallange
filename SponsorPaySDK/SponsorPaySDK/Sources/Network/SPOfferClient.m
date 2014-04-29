//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferClient.h"
#import "SPDataParser.h"
#import "SPJSONDataParser.h"
#import "SPOfferResponse.h"
#import "SPURLGenerator.h"
#import "SPSigner.h"
#import "SPSHA1Signer.h"
#import "SPCredentials.h"
#import "NSError+SPError.h"

#pragma mark - Constants

// http://api.sponsorpay.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186 &ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&uid=player1 &timestamp=1312471066&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d

NSString *const SPOfferClientBaseURL = @"http://api.sponsorpay.com/feed/v1/offers.json";

@interface SPOfferClient ()

@property(nonatomic, strong, readwrite) SPCredentials *credentials;


@property(nonatomic, strong) NSURLSession *urlSession;

@property(nonatomic, strong) id <SPDataParser> dataParser;
@property (nonatomic, strong) SPURLGenerator *urlGenerator;
@property(nonatomic, strong, readwrite) id <SPSigner> requestSigner;
@end

@implementation SPOfferClient {

}

#pragma mark - Public

- (instancetype)initWithCredentials:(SPCredentials *)credentials {
    self = [super init];

    if (self)
    {
        self.credentials = credentials;

        //
        // Setup network
        //
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // Keep-Alive
        sessionConfiguration.HTTPAdditionalHeaders = @{
                @"Connection" : @"Keep-Alive",
                @"TestHeader" : @"Test Value"

        };

        self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];

        //
        // Setup parse
        //
        self.dataParser = [[SPJSONDataParser alloc] init];

        //
        // Setup URL Generator and response verifier
        //

        self.requestSigner = [[SPSHA1Signer alloc] init];
        self.urlGenerator = [[SPURLGenerator alloc] initWithCredentials:credentials signer:self.requestSigner];

    }

    return self;
}

- (NSURLSessionTask *)listOffersWithCustomParameter:(NSDictionary *)customParameters completion:(SPOfferCompletionBlock)completion
{


    //
    // prepare request
    //
    NSString *parametersString = [self.urlGenerator offersURLWithParameters:customParameters];
    NSURL *requestUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@?%@", SPOfferClientBaseURL, parametersString]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:requestUrl];
    //
    // send request
    //

    NSURLSessionTask *sessionTask = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
        if (httpResponse.statusCode == 200)
        {

            NSDictionary *headers = [httpResponse allHeaderFields];
            NSString *responseSignature = headers[@"X-Sponsorpay-Response-Signature"];

            //
            // Verify response signature
            //
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            BOOL isValid = [self.requestSigner signatureValid:responseSignature forText:responseString secretToken:self.credentials.apiKey];
            if(!isValid)
            {
                NSLog(@"Response signature %@ is not valid", responseSignature);
            }

            SPOfferResponse * offerResponse = [self.dataParser parseOfferListResponse:data];
            if(completion)
            {
                completion(offerResponse, nil);
            }
        }
        else
        {


            //
            // this is kind of poor implementation, no time to do better
            //
            if(!error)
            {
               error = [NSError errorWithSPCode:(SPErrorCode) httpResponse.statusCode];
            }

            NSLog(@"error %@", error);

            if(completion)
            {
                completion(nil, error);
            }


        }
    }];

    [sessionTask resume];

    return sessionTask;

}

#pragma mark
#pragma mark - Delegates

#pragma mark
#pragma mark - Private

@end