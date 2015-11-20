//
//  CurrentRestaurantView.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kOpenInMapsButtonPressed = @"OpenInMapsButtonPressed";
static NSString *kCategoryButtonPressed = @"CategoryButtonPressed";
static NSString *kReloadButtonPressed = @"ReloadButtonPressed";

@interface CurrentRestaurantView : UIView

@property (nonatomic, weak) IBOutlet UIButton *openInMapsButton;
@property (nonatomic, weak) IBOutlet UILabel *headerTextLabel;

@property (nonatomic, weak) IBOutlet UIButton *categoryButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *reloadButton;

- (void)addConstraintsTo:(UIView *)currentRestaurantView onContainingView:(UIView *)currentRestaurantViewContainer;

@end
