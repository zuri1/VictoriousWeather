//
//  FirstViewController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/16/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "FirstViewController.h"
#import "ZMBWeatherModel.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSwipeGestureRecognizer];

    [[ZMBNetworkController sharedController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateWeather];
}

- (void)viewWillLayoutSubviews {
    if (![ZMBNetworkController sharedController].weatherModel) {
        [self.temperature setHidden:YES];
    }
}

- (void)updateWeather {
    // Update the view with the cached weather model
    [self.temperature setHidden:NO];
    
    ZMBWeatherModel *weatherModel = [ZMBNetworkController sharedController].weatherModel;
    
    self.temperature.text = [NSString stringWithFormat:@"%@ F", weatherModel.todaysTemperature];
    self.weatherDescription.text = weatherModel.todaysWeatherDescription;
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
