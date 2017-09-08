//
//  ListView.m
//  FenYouShopping
//
//  Created by fenyounet on 16/9/6.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "ChoiceView.h"
#define BUTTON_HEIGH 35
#define BUTTON_SAPCE 0
#define BUTTON_TAG 1000
#import "LineView.h"
@interface ChoiceView ()
@property (nonatomic,assign)CGFloat maxHeight;

@property (nonatomic,strong)UIScrollView *scrollView ;

@end
@implementation ChoiceView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.clipsToBounds = NO ;
        self.alpha = 0 ;
        self.layer.cornerRadius = 4 *VerticalRatio() ;
        self.layer.masksToBounds = YES ;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRGBHex:0xEEEFF6].CGColor ;
        
        self.isShow = NO ;
        [self initUserInterface];
    }
    
    return self ;
}

- (void)initUserInterface{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds ];
    _scrollView.backgroundColor = [UIColor whiteColor];
     self.maxHeight = 0;
     self.backgroundColor =[UIColor whiteColor];
}

- (void)setDataList:(NSArray *)dataList {
    
    _dataList = dataList ;
    for (int i = 0; i < [dataList count]; i ++) {
        UIButton *btn = [self buttonWithImageName:nil
                                         andTitle:dataList[i][@"name"]];
        btn.x = 0;
        btn.y = BUTTON_SAPCE + i * (BUTTON_HEIGH + BUTTON_SAPCE);
        btn.tag = BUTTON_TAG + i;
        [self addSubview:btn];
        self.maxHeight  = CGRectGetMaxY(btn.frame);
        if (i ==[dataList count] -1) {
            return ;
    }
        
    LineView *line = [LineView LineViewWithPosition:self.maxHeight
                                                       andWidth:BUTTON_WIDTH];
       line.color = [UIColor colorWithRGBHex:0xEEEFF6];
        [self addSubview:line];
    }
    self.maxHeight += BUTTON_SAPCE;
}
-(void)showWithPoint:(CGPoint)point{
    
    
    self.isShow = YES ;
    self.frame = CGRectMake(point.x, point.y + 10,0, 0);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame =  CGRectMake(point.x - BUTTON_WIDTH , point.y ,
                                 BUTTON_WIDTH,self.maxHeight);
        self.alpha = 1 ;
    } completion:^(BOOL finished) {
    }];
}

- (void)hidenSelfWithEndPoint{
    
    CGPoint point = CGPointMake(CGRectGetMaxX(self.frame),CGRectGetMinY(self.frame));
    
    [UIView animateWithDuration:0.25 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
             self.alpha = 0 ;
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(point.x,
                                point.y,
                                0, 0);
        [self removeFromSuperview];
        self.isShow = NO ;
    }];
}

- (void)didClickWithButton:(UIButton *)sender{
    NSInteger index = sender.tag - BUTTON_TAG ;
    
    if (self.block){
        self.block(genderType,self.dataList[index]);
        [self hidenSelfWithEndPoint];
    }
}
- (UIButton *)buttonWithImageName:(NSString *)imageName
                         andTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.width = BUTTON_WIDTH  ;
    btn.height = BUTTON_HEIGH;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor hightBlackClor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(didClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn ;
}

@end
