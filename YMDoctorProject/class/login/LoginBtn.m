//
//  LoginBtn.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/3/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LoginBtn.h"

@implementation LoginBtn



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.cornerRadius = 10 ;
        self.layer.masksToBounds = YES ;
        self.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        [self addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self configUI];
    }return self;
}


- (void)configUI {

    _roundlayer = [CAShapeLayer layer];
    _roundlayer.fillColor = [UIColor whiteColor].CGColor ;
    _roundlayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10, self.frame.size.height/2) radius:8 startAngle:0 endAngle:2 *M_PI clockwise:YES].CGPath;
    _roundlayer.shadowOffset = CGSizeMake(1, 1);
    _roundlayer.shadowColor = [UIColor blackColor].CGColor;
    _roundlayer.shadowOpacity = 0.7 ;
    [self.layer addSublayer:_roundlayer];
}

- (void)btnClicked{
    if (self.selected) {
        self.selected = NO ;
        self.backgroundColor =  [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.x";
        animation.duration = 0.25 ;
        animation.fromValue = @(self.width - 20);
        animation.toValue = @(0);
        animation.fillMode = kCAFillModeForwards ;
        animation.removedOnCompletion = NO ;
        [_roundlayer addAnimation:animation forKey:@"key"];
    }
    else {
        self.selected = YES ;
        self.backgroundColor = self.tintColor;
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.x";
        animation.duration = 0.25 ;
        animation.fromValue = @(0);
        animation.toValue = @(self.width - 20);
        animation.fillMode = kCAFillModeForwards ;
        animation.removedOnCompletion = NO ;
        [_roundlayer addAnimation:animation forKey:@"key"];
    }
    
    if (self.block) {
        self.block(self.selected);
    }
}
@end
