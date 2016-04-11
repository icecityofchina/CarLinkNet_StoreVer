//
//  ScaleBackButton.m
//  CLWsdht
//
//  Created by tom on 16/4/9.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "ScaleBackButton.h"

@implementation ScaleBackButton



- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        UIImage *orgImage = [self backgroundImageForState:UIControlStateNormal];
        UIImage *scaleImage = [orgImage resizableImageWithCapInsets:UIEdgeInsetsMake(19, 2, 19, 2)];
        [self setBackgroundImage:scaleImage forState:UIControlStateNormal];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
