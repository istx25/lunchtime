//
//  UIAlertController+Extras.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extras)

+ (instancetype)alertControllerWithTitle:(NSString *)title preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addDefaultAction:(NSString *)title withHandler:(void (^)(UIAlertAction *action))handler;
- (void)addCancelAction;


@end
