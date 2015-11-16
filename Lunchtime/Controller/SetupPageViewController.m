//
//  SetupPageViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "SetupPageViewController.h"
#import "SetupPageSecondViewController.h"
#import "SetupPageThirdViewController.h"
#import "SetupPageFourthViewController.h"
#import "SetupPageFifthViewController.h"
#import "LunchtimeLocationManager.h"

static NSString *kSetupPageFirstScene = @"setupPageFirstScene";
static NSString *kSetupPageSecondScene = @"setupPageSecondScene";
static NSString *kSetupPageThirdScene = @"setupPageThirdScene";
static NSString *kSetupPageFourthScene = @"setupPageFourthScene";
static NSString *kSetupPageFifthScene = @"setupPageFifthScene";

@interface SetupPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic) LunchtimeLocationManager *locationManager;
@property (nonatomic, strong) NSArray *scenes;

@end

@implementation SetupPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    UIViewController *firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageFirstScene];
    SetupPageSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageSecondScene];
    SetupPageThirdViewController *thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageThirdScene];
    SetupPageFourthViewController *fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageFourthScene];
    SetupPageFifthViewController *fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageFifthScene];

    self.scenes = @[firstViewController, secondViewController, thirdViewController, fifthViewController];

    if ([self.locationManager needsSetup]) {
        self.scenes = @[firstViewController, secondViewController, thirdViewController, fourthViewController, fifthViewController];
    }

    [self setViewControllers:@[firstViewController] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
}

- (void)setupUI {
    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setDataSource:self];
}

#pragma mark - <UIPageViewControllerDataSource>
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSInteger index = [self.scenes indexOfObject:viewController];
    index++;

    if (index >= self.scenes.count) {
        return nil;
    }

    return self.scenes[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSInteger index = [self.scenes indexOfObject:viewController];
    index--;

    if (index < 0) {
        return nil;
    }
    
    return self.scenes[index];
}


@end
