//
//  InterestTableViewCell.m
//  InterestDemo
//
//  Created by Pranay Mathur on 5/27/15.
//  Copyright (c) 2015 Wedig. All rights reserved.
//

#import "InterestTableViewCell.h"

@implementation InterestTableViewCell
@synthesize lblCategory,ContainerView,btnGroupTap;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = [super pointInside:point withEvent:event];
    
    if (pointInside && ![self.ContainerView pointInside:[self convertPoint:point toView:self.ContainerView] withEvent:event]) {
        return YES;
    }
    
    return NO;
}*/


@end
