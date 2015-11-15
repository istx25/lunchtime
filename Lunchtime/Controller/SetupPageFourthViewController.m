//
//  SetupPageFourthViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageFourthViewController.h"

static NSString *kUserCreatedFlag = @"USER_CREATED";
static NSString *kSegueFromSetupFlow = @"segueFromSetupFlow";

@interface SetupPageFourthViewController ()

@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@end

@implementation SetupPageFourthViewController

- (IBAction)doneButtonPressed:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:kUserCreatedFlag forKey:kUserCreatedFlag];

    [self performSegueWithIdentifier:kSegueFromSetupFlow sender:self];
}

@end
