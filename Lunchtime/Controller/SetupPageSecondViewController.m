//
//  SetupPageFourthViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageSecondViewController.h"
#import "LunchtimeLocationManager.h"

@interface SetupPageSecondViewController ()

@property (nonatomic, weak) IBOutlet UIButton *grantNotificationPrivilegesButton;
@property (nonatomic, weak) IBOutlet UIButton *grantLocationPrivilegesButton;

@end

@implementation SetupPageSecondViewController

- (IBAction)grantLocationPrivilegesButtonPressed:(UIButton *)sender {
    [[LunchtimeLocationManager defaultManager] setup];
}

- (IBAction)grantNotificationPrivilegesButtonPressed:(UIButton *)sender {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end