//
//  AlertView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AlertView.h"
@interface AlertView()
@property (nonatomic,strong)UILabel *textLable;
@property (nonatomic,strong)UIView *loadView;

@end

@implementation AlertView


+ (AlertView *)alertViewWithSuperView:(UIView *)view
                              andData:(NSString *)message {
    AlertView *alert = [[AlertView alloc]initWithSuperView:view];
    alert.message = message ;
    return alert;
}

- (instancetype)initWithSuperView:(UIView *)view{
    self = [super init];
    self.frame = view.frame ;
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addLoadView];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)addLoadView {
    _loadView = [UIView new];
    _loadView.backgroundColor = [UIColor whiteColor];
    _loadView.center = CGPointMake(self.width/2, self.height/2);
    _textLable = [UILabel new];
    _textLable.font = [UIFont systemFontOfSize:14];
    _textLable.numberOfLines = 0 ;
    _textLable.center = CGPointMake(_loadView.width/2, _loadView.height/2);
    [_loadView addSubview:_textLable];
    [self addSubview:_loadView];
}

- (void)show {
    CGSize size = [_message sizeWithBoundingSize:CGSizeMake(self.width * 0.8,0) font:[UIFont systemFontOfSize:14 weight:1]];
    _textLable.text = _message ;
    [UIView animateWithDuration:0.2 animations:^{
        
         _loadView.bounds = CGRectMake(0, 0, size.width + 60 *HorizontalRatio(), size.height + 40);
        _textLable.bounds = CGRectMake(0, 0, size.width, size.height );
        _loadView.layer.cornerRadius = 8 ;
        _loadView.layer.masksToBounds = YES ;
        _textLable.center = CGPointMake(_loadView.width/2, _loadView.height/2);
        
    } completion:^(BOOL finished) {
        [self performSelector:@selector(viewHidden) withObject:nil afterDelay:1.0f];
    }];
}

- (void)viewHidden {
    [UIView animateWithDuration:0.1 animations:^{
        _textLable.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        _loadView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [_textLable removeFromSuperview];
        [_loadView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
