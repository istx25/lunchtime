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

static NSString *kSetupPageFirstScene = @"setupPageFirstScene";
static NSString *kSetupPageSecondScene = @"setupPageSecondScene";
static NSString *kSetupPageThirdScene = @"setupPageThirdScene";
static NSString *kSetupPageFourthScene = @"setupPageFourthScene";

@interface SetupPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *scenes;

@end

@implementation SetupPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIViewController *firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageFirstScene];
    SetupPageSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageSecondScene];
    SetupPageThirdViewController *thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageThirdScene];
    SetupPageFourthViewController *fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSetupPageFourthScene];

    self.scenes = @[firstViewController, secondViewController, thirdViewController, fourthViewController];

    [self setupUI];
    [self setViewControllers:@[firstViewController] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
}

- (void)setupUI {
    [self setDataSource:self];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
