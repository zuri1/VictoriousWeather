//
//  SecondViewController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/16/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <NSURLSessionDownloadDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *downloadURL = [NSURL URLWithString:@"http://www.myweather2.com/developer/forecast.ashx?uac=KDrRbvwbAt&output=json&query=97006"];
    [self downloadDataFromURL:downloadURL withCompletionHandler:^(NSData *data) {
        if (data != nil) {
            
            NSError *error;
            NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                NSLog(@"%@", weatherDict);
            }
        }
    }];
}

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *data))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            NSLog(@"HTTP status code %ld", (long)HTTPStatusCode);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(data);
        }];
    }];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
