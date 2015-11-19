//
//  SetupPageSecondViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageFifthViewController.h"
#import "User.h"
#import "LunchtimeNotification.h"

@interface SetupPageFifthViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *lunchtimeDatePicker;

@end

@implementation SetupPageFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.lunchtimeDatePicker setDatePickerMode:UIDatePickerModeTime];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    RLMRealm *realm = [RLMRealm defaultRealm];
    User *user = [User new];
    
    [user setPreferredDistance:@1500];
    [user setLunchtime:self.lunchtimeDatePicker.date];
    [user setIdentifier:@1];

    [realm beginWriteTransaction];
    [User createOrUpdateInRealm:realm withValue:user];
    [realm commitWriteTransaction];

    // Setup and schedule the lunchtime notification
    LunchtimeNotification *notification = [LunchtimeNotification lunchtimeNotificationWithDate:self.lunchtimeDatePicker.date];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSLog(@"firedate = %@", notification.fireDate);
}

@end
