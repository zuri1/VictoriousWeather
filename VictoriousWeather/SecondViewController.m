//
//  SecondViewController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/16/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSwipeGestureRecognizer];
}

- (void)addSwipeGestureRecognizer {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (IBAction)swipeRight:(id)sender
{
    NSUInteger selectedIndex = [super.tabBarController selectedIndex];
    
    [super.tabBarController setSelectedIndex:selectedIndex - 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
