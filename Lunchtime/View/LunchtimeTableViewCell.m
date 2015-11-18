//
//  LunchtimeTableViewCell.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeTableViewCell.h"
#import "UIColor+Lunchtime.h"

@implementation LunchtimeTableViewCell

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = [UIColor lightGray];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

@end
