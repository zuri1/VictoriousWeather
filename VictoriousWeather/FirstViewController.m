//
//  FirstViewController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/16/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "FirstViewController.h"
#import "ZMBNetworkController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;
@property (strong, nonatomic) NSDictionary *weatherDict;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSwipeGestureRecognizer];
//    [self downloadWeatherData];
    
    
    
    
}

- (void)addSwipeGestureRecognizer {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
}

- (IBAction)swipeLeft:(id)sender
{
    NSUInteger selectedIndex = [super.tabBarController selectedIndex];
    
    [super.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
