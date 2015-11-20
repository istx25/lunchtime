//
//  CurrentRestaurantView.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "CurrentRestaurantView.h"

@interface CurrentRestaurantView ()

@property (nonatomic, weak) IBOutlet UIView *topSpacerView;
@property (nonatomic, weak) IBOutlet UIView *bottomSpacerView;

@end

@implementation CurrentRestaurantView

- (instancetype)init {
    return [[[NSBundle mainBundle] loadNibNamed:@"CurrentRestaurantView" owner:self options:nil] firstObject];
}

- (IBAction)openInMapsButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kOpenInMapsButtonPressed object:nil];
}

- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadButtonPressed object:nil];
}

- (void)addConstraintsTo:(UIView *)currentRestaurantView onContainingView:(UIView *)currentRestaurantViewContainer {
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:currentRestaurantView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:currentRestaurantViewContainer attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:currentRestaurantView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:currentRestaurantViewContainer attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:currentRestaurantView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:currentRestaurantViewContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:currentRestaurantView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:currentRestaurantViewContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];

    [currentRestaurantViewContainer addConstraints:@[leading, trailing, top, bottom]];
}

@end