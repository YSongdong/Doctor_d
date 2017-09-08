//
//  UIView+Rect.m
//  微信电话本
//
//  Created by archerzz on 15/5/15.
//  Copyright (c) 2015年 archerzz. All rights reserved.
//

#import "UIView+Rect.h"
#import <objc/runtime.h>

#define COMMON_STATEMENT_WITH_DIFFERENCE(STATEMENT) {CGRect frame = self.frame;STATEMENT;self.frame = frame;}



@implementation UIView (Rect)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = x);
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
     COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.y = y);
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
     COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.width = width);
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.height = height);
}

- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

@end
