//
//  SetupPageFourthViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageFourthViewController.h"
#import "LunchtimeLocationManager.h"

@interface SetupPageFourthViewController ()

@property (nonatomic, weak) IBOutlet UIButton *grantPrivilegesButton;

@end

@implementation SetupPageFourthViewController

- (IBAction)grantPrivilegesPressed:(UIButton *)sender {
    [[LunchtimeLocationManager defaultManager] setup];
}

- (IBAction)registerLunchtimeNotificationSettings {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end