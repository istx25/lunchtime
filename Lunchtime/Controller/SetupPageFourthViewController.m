//
//  SetupPageThirdViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageFourthViewController.h"
#import "User.h"

@interface SetupPageFourthViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *priceLimitSegmentedControl;

@end

@implementation SetupPageFourthViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    RLMRealm *realm = [RLMRealm defaultRealm];
    User *user = [User new];

    [user setPriceLimit:(unsigned)self.priceLimitSegmentedControl.selectedSegmentIndex];
    [user setIdentifier:@1];

    [realm beginWriteTransaction];
    [User createOrUpdateInRealm:realm withValue:user];
    [realm commitWriteTransaction];
}

@end
