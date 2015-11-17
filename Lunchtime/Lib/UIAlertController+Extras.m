//
//  UIAlertController+Extras.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "UIAlertController+Extras.h"

@implementation UIAlertController (Extras)

+ (instancetype)alertControllerWithTitle:(NSString *)title preferredStyle:(UIAlertControllerStyle)preferredStyle {
    return [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:preferredStyle];
}

- (void)addDefaultAction:(NSString *)title withHandler:(void (^)(UIAlertAction *action))handler {
    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler]];
}

- (void)addCancelAction {
    [self addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
}

@end
