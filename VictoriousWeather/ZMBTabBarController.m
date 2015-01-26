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
    
    
    ZMBNetworkController *myNetworkController = [ZMBNetworkController sharedController];
    [myNetworkController downloadData];
    [myNetworkController startTimer];
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
