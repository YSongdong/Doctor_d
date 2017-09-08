//
//  UIView+ActiveIndactorView.m
//  FenYouShopping
//
//  Created by fenyounet on 16/7/31.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "UIView+ActiveIndactorView.h"
#import <objc/runtime.h>
static  char indicatorKeys ;

static char imageViewKeys ;


@implementation UIView (ActiveIndactorView)

- (UIActivityIndicatorView *)add_Indactor  {
    UIActivityIndicatorView *activeIndicator =  objc_getAssociatedObject(self,&indicatorKeys);
    if (activeIndicator) {
        return activeIndicator ;
    }
    activeIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activeIndicator.center = CGPointMake(self.width/2, self.height/2);
    [self addSubview:activeIndicator];
    [activeIndicator startAnimating];
    objc_setAssociatedObject(self, &indicatorKeys,activeIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return activeIndicator;
}

- (void)stopIndactor {
    
    UIActivityIndicatorView *indactor = objc_getAssociatedObject(self, &indicatorKeys);
    if ([indactor isAnimating]){
        [indactor stopAnimating];
    }
    if (indactor.superview) {
        [indactor removeFromSuperview];
        indactor = nil ;
        objc_removeAssociatedObjects(self);
    }
}

- (void)setIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    
    UIActivityIndicatorView *activeIndicator =  objc_getAssociatedObject(self,&indicatorKeys);
    if (activeIndicator) {
        activeIndicator.activityIndicatorViewStyle = style;
    }
}

- (UIImageView *)addImageView {
    
    UIImageView *imageView = objc_getAssociatedObject(self, &imageViewKeys);
    if (!imageView) {
        imageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"background"];
        CGSize size =  image.size ;
        imageView.bounds = CGRectMake(0, 0, size.width, size.height);
         imageView.image = image;
        imageView.center = CGPointMake(WIDTH/2, self.height/4);
        objc_setAssociatedObject(self, &imageViewKeys, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:imageView];
    }
    imageView.hidden = NO ;
    return imageView ;
}


- (void)setImageViewCenter_Y:(CGFloat)centerY {
   id value = objc_getAssociatedObject(self, &imageViewKeys);
    if (value && [value isKindOfClass:[UIImageView class]]) {
        
        UIImageView *imageView = value ;
        imageView.centerY = centerY ;
    }
}

- (void)hiddenImageView {
    id value = objc_getAssociatedObject(self, &imageViewKeys);
    if (value && [value isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = value ;
        imageView.hidden = YES ;
    
    }
}

- (void)setCenter_Y:(CGFloat)center_Y {
     UIActivityIndicatorView *indactor = objc_getAssociatedObject(self, &indicatorKeys);
    if (indactor) {
        indactor.centerY = center_Y ;
    }
}
- (void)setAlertViewWithTitle:(NSString *)title withCount:(NSInteger )rowCount {
    

    UILabel *label = objc_getAssociatedObject(self, "lablekey");
    
    
    if (rowCount == 0) {
        if (!label) {
            label = [UILabel labelWithFont:14];
            label.textColor = [UIColor lightGrayColor];
            objc_setAssociatedObject(self, "lablekey", label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self addSubview:label];
        }
        label.text = title ;
        [label sizeToFit];
        label.center = CGPointMake(self.width/2, self.height/2);
    }else {
        [label removeFromSuperview];
        objc_removeAssociatedObjects(label);
    }
    
}


@end
