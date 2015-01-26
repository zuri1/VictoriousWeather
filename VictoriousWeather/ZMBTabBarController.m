//
//  ZMBTabBarController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "ZMBTabBarController.h"
#import "ZMBNetworkController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"




@interface ZMBTabBarController ()


@end

@implementation ZMBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)updateWeather {
    
    NSURL *downloadURL = [NSURL URLWithString:@"http://www.myweather2.com/developer/forecast.ashx?uac=KDrRbvwbAt&output=json&query=97006&temp_unit=f"];
    
    ZMBNetworkController *myNetworkController = [ZMBNetworkController sharedController];
    [myNetworkController downloadDataFromURL:downloadURL withCompletionHandler:^(NSData *data) {
        //check if data returned
        if (data != nil) {
            
            NSError *error;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeatherDataDownloaded" object:nil userInfo:JSON];
    
            }
        }
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
