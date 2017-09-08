//
//  ComImageView.m
//  FenYouShopping
//
//  Created by fenyounet on 16/7/20.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "ComImageView.h"

@implementation ComImageView


- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setContentScaleFactor:[UIScreen mainScreen].scale];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        self.clipsToBounds = YES ;
        self.contentMode = UIViewContentModeScaleAspectFill ;
    }
    return self ;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentScaleFactor:[UIScreen mainScreen].scale];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        self.clipsToBounds = YES ;
        self.contentMode = UIViewContentModeScaleAspectFill ;

    }
    return self ;
}
@end
