//
//  UIImageView+CommonImageView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIImageView+CommonImageView.h"

@implementation UIImageView (CommonImageView)

- (instancetype)init {
    
    self =[super init];
    if (self) {        
        self.contentMode =UIViewContentModeScaleAspectFill ;
        self.contentScaleFactor = [UIScreen mainScreen].scale ;
    }
    return self ;
}

@end
