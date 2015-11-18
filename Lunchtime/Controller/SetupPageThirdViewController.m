//
//  SetupPageFourthViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageThirdViewController.h"
#import "LunchtimeLocationManager.h"

@interface SetupPageThirdViewController ()

@property (nonatomic, weak) IBOutlet UIButton *shareLocationPrivilegeButton;

@end

@implementation SetupPageThirdViewController

- (IBAction)shareLocationPrivilegeButtonPressed:(UIButton *)sender {
    [[LunchtimeLocationManager defaultManager] setup];
}

@end