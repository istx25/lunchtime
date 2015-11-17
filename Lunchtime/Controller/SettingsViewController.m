//
//  SettingsViewController.m
//  Lunchtime
//
//  Created by Alex on 2015-11-17.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SettingsViewController.h"
#import "LunchtimeNotification.h"
#import "User.h"

@interface SettingsViewController ()

@property (nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UISlider *setDistanceSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *setPriceLimitSegControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *setNotificationTimeDatePicker;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.user = [User objectForPrimaryKey:@1];
    
    self.setDistanceSlider.value = [self.user.preferredDistance floatValue];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", [self.user.preferredDistance stringValue]];
    
    self.setPriceLimitSegControl.selectedSegmentIndex = self.user.priceLimit;
    
    self.setNotificationTimeDatePicker.datePickerMode = UIDatePickerModeTime;
    self.setNotificationTimeDatePicker.date = self.user.lunchtime;
    
}

- (IBAction)setDistanceSlider:(id)sender {
    
    NSNumber *distance = [NSNumber numberWithInt:(int)self.setDistanceSlider.value];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", [distance stringValue]];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    self.user.preferredDistance = [NSNumber numberWithFloat:self.setDistanceSlider.value];
    self.user.priceLimit = self.setPriceLimitSegControl.selectedSegmentIndex;
    self.user.lunchtime = self.setNotificationTimeDatePicker.date;
    
    
}


@end
