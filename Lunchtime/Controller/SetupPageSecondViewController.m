//
//  SetupPageSecondViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageSecondViewController.h"
#import "User.h"

@interface SetupPageSecondViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *lunchtimeDatePicker;

@end

@implementation SetupPageSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.lunchtimeDatePicker setDatePickerMode:UIDatePickerModeTime];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    RLMRealm *realm = [RLMRealm defaultRealm];
    User *user = [User new];
    
    [user setLunchtime:self.lunchtimeDatePicker.date];
    [user setIdentifier:@1];

    [realm beginWriteTransaction];
    [User createOrUpdateInRealm:realm withValue:user];
    [realm commitWriteTransaction];
}

@end
