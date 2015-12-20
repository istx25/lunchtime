//
//  CurrentRestaurantView.h
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-18.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kOpenInMapsButtonPressed = @"OpenInMapsButtonPressed";
static NSString *kReloadButtonPressed = @"ReloadButtonPressed";

@interface CurrentRestaurantView : UIView

@property (nonatomic, weak) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic, weak) IBOutlet UIButton *openInMapsButton;
@property (nonatomic, weak) IBOutlet UILabel *headerTextLabel;

- (void)addConstraintsTo:(UIView *)currentRestaurantView onContainingView:(UIView *)currentRestaurantViewContainer;

@end
