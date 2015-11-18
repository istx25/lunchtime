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
@property (nonatomic, weak) IBOutlet UILabel *headerTextLabel;
@property (nonatomic, weak) IBOutlet UIView *bottomSpacerView;
@property (nonatomic, weak) IBOutlet UIButton *openInMapsButton;

@end

@implementation CurrentRestaurantView

- (void)awakeFromNib {
    [super awakeFromNib];

    UIView *placeholderView = [[[NSBundle mainBundle] loadNibNamed:@"CurrentRestaurantView" owner:self options:nil] firstObject];
    [self addSubview:placeholderView];
    [self addConstraintsForCurrentRestaurantView];
}

- (void)addConstraintsForCurrentRestaurantView {
    [self.topSpacerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.headerTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bottomSpacerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.openInMapsButton setTranslatesAutoresizingMaskIntoConstraints:NO];

    // Top SpacerView Constraints
    NSLayoutConstraint *topSpacerViewLeadingSpace = [NSLayoutConstraint constraintWithItem:self.topSpacerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topSpacerViewTrailingSpace = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.topSpacerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topSpacerViewTop = [NSLayoutConstraint constraintWithItem:self.topSpacerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topSpacerViewBottom = [NSLayoutConstraint constraintWithItem:self.headerTextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.topSpacerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topSpacerViewEqualHeight = [NSLayoutConstraint constraintWithItem:self.topSpacerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomSpacerView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];

    [self addConstraints:@[topSpacerViewLeadingSpace, topSpacerViewTrailingSpace, topSpacerViewTop, topSpacerViewBottom, topSpacerViewEqualHeight]];

    // Header Text Label Constraints
    NSLayoutConstraint *headerTextLabelTopSpace = [NSLayoutConstraint constraintWithItem:self.headerTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSpacerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *headerTextLabelBottomSpace = [NSLayoutConstraint constraintWithItem:self.bottomSpacerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerTextLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *headerTextLabelCenterX = [NSLayoutConstraint constraintWithItem:self.headerTextLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    [self addConstraints:@[headerTextLabelTopSpace, headerTextLabelBottomSpace, headerTextLabelCenterX]];

    // Bottom SpacerView Constraints
    NSLayoutConstraint *bottomSpacerViewLeadingSpace = [NSLayoutConstraint constraintWithItem:self.bottomSpacerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomSpacerViewTrailingSpace = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.bottomSpacerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomSpacerViewTop = [NSLayoutConstraint constraintWithItem:self.bottomSpacerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerTextLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomSpacerViewBottom = [NSLayoutConstraint constraintWithItem:self.headerTextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomSpacerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomSpacerViewHeight = [NSLayoutConstraint constraintWithItem:self.bottomSpacerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topSpacerView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];

    [self addConstraints:@[bottomSpacerViewLeadingSpace, bottomSpacerViewTrailingSpace, bottomSpacerViewTop, bottomSpacerViewBottom, bottomSpacerViewHeight]];

    // Open In Maps Button Constraints
    NSLayoutConstraint *openInMapsButtonCenterX = [NSLayoutConstraint constraintWithItem:self.openInMapsButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *openInMapsButtonWidth = [NSLayoutConstraint constraintWithItem:self.openInMapsButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:280.0];
    NSLayoutConstraint *openInMapsButtonHeight = [NSLayoutConstraint constraintWithItem:self.openInMapsButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:45.0];
    NSLayoutConstraint *openInMapsButtonTop = [NSLayoutConstraint constraintWithItem:self.openInMapsButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomSpacerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *openInMapsButtonBottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.openInMapsButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7.0];

    [self addConstraints:@[openInMapsButtonCenterX, openInMapsButtonWidth, openInMapsButtonHeight, openInMapsButtonTop, openInMapsButtonBottom]];
}

@end