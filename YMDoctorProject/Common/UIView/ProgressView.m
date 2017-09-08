//
//  ProgressView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ProgressView.h"
#import "LineView.h"

#define LEFT_edge  30
@interface ProgressView ()


@property (nonatomic,strong)LineView *lineView ;

@property (nonatomic,strong)NSArray *views ;

@property (nonatomic,strong)CALayer *maskLayer ;


@end

@implementation ProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backColor =  [UIColor light_GrayColor] ;
    self.roundViewColor = [UIColor bluesColor];
    self.lineHeight = 1.0 ;
    self.viewWidth =15 ;
    [self.lineView.layer addSublayer:self.maskLayer];
    [self addSubview:self.lineView];
    self.clipsToBounds = YES ;
}
- (void)drawRect:(CGRect)rect {
    
}
- (void)layoutSubviews {
    
    CGFloat witdth = self.width - 2 * LEFT_edge ;
    
    for (int i = 0; i < [self.views count]; i ++) {
        UIView *view = self.views[i];
        CGFloat x = LEFT_edge +  (witdth / ([self.views count] - 1)) * i ;
        view.center = CGPointMake(x, _lineView.centerY);
    }    CGFloat ratio = (_progress * 1.0) / (_account * 1.0);
    self.lineView.height = self.lineHeight ;
    self.lineView.width = self.width ;
    _maskLayer.backgroundColor = self.roundViewColor.CGColor;
    _maskLayer.frame = CGRectMake(0, 0, ratio * _lineView.width ,_lineView.height);
}

- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
    }
    return _maskLayer ;
}


- (LineView *)lineView {

    if (!_lineView) {
        _lineView = [LineView LineViewWithPosition:self.height/2 - self.lineHeight/2 andWidth:self.width];
        _lineView.centerY = self.height /2 ;
        _lineView.layer.masksToBounds = YES ;
    }
    return _lineView ;
}

- (void)setAccount:(NSInteger)account {
    
    _account = account ;
}

- (void)setProgress:(NSInteger)progress {

    _progress = progress ;
}

- (void)addViews {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _account; i ++) {
        UILabel *view = [UILabel new];
        view.bounds = CGRectMake(0, 0, self.viewWidth, self.viewWidth);
        view.layer.cornerRadius = view.width/2 ;
        view.layer.masksToBounds = YES ;
        view.backgroundColor =self.backColor;
        view.textColor = [UIColor lightGrayColor];
        view.textAlignment = NSTextAlignmentCenter ;
        view.font  = [UIFont systemFontOfSize:14];
        if (i < _progress) {
            view.backgroundColor = self.roundViewColor;
            view.textColor = [UIColor whiteColor];
        }
        [array addObject:view];
        [self addSubview:view];
    }
    self.views = [array mutableCopy];
   [self layoutSubviews];
}

- (void)setText {
    
    for (int i = 0; i < [self.views count]; i ++ ) {
        
        UILabel *view = self.views[i];
        view.text = [NSString stringWithFormat:@"%d",i];
    }
}
@end
