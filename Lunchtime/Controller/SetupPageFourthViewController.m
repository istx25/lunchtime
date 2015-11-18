//
//  SetupPageFourthViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-17.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageFourthViewController.h"

@interface SetupPageFourthViewController ()

@property (nonatomic, weak) IBOutlet UIButton *shareNotificationsPrivilegeButton;

@end

@implementation SetupPageFourthViewController

- (IBAction)shareNotificationsPrivilegeButtonPressed:(UIButton *)sender {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end
