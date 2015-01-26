//
//  ZMBNetworkController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "ZMBNetworkController.h"
#import "ZMBWeatherModel.h"

@interface ZMBNetworkController () <NSURLSessionDelegate>

@property (strong, nonatomic) NSTimer *myTimer;

@end

@implementation ZMBNetworkController

+ (ZMBNetworkController *)sharedController {
    static dispatch_once_t pred;
    static ZMBNetworkController *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ZMBNetworkController alloc] init];
        NSLog(@"alloc'ed and init'ed a ZMBNetwork Controller");
    });
    
    return shared;
}

- (void)startTimer {
    self.myTimer = [NSTimer timerWithTimeInterval:1800 target:self selector:@selector(downloadData) userInfo:nil repeats:YES];
}

- (void)downloadData {
    
    NSURL *downloadURL = [NSURL URLWithString:@"http://www.myweather2.com/developer/forecast.ashx?uac=KDrRbvwbAt&output=json&query=97006&temp_unit=f"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:downloadURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            NSLog(@"HTTP status code %ld", (long)HTTPStatusCode);
        }
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.weatherModel = [[ZMBWeatherModel alloc] initWithJSONDict:JSON];
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:self.weatherModel];
        [[NSUserDefaults standardUserDefaults] setObject:myData forKey:@"weather"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate updateWeather];
            
        }];
    }];
    [dataTask resume];
}



@end
