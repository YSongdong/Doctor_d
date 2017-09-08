//
//  OrderTypeView.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "OrderTypeView.h"

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]


@interface OrderTypeView ()

@property(nonatomic,strong) UIButton *typeBtn;
@property(nonatomic,strong)  UIView *lineView;
@property(nonatomic,assign) CGFloat btnTag;
@property(nonatomic,strong) NSArray *dataArr;
@end


@implementation OrderTypeView


-(instancetype)initWithFrame:(CGRect)frame
{

    if (self  = [super initWithFrame:frame]) {
        [self initBtn];
    }
    return self;

}
-(NSArray *)dataArr{

    if (!_dataArr) {
        _dataArr = [NSArray array];
        
    }
    return _dataArr;
}


-(void)initBtn{
    _dataArr = @[@"鸣医订单",@"预约订单",@"出售的服务"];
    CGFloat btnW = SCREEN_WIDTH/3;
    for (int i=0; i< _dataArr.count; i++) {
        self.typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW, self.frame.size.height)];
        [self addSubview:self.typeBtn];
        [self.typeBtn setTitle:_dataArr[i] forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:RGB(103, 103, 103, 1) forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:RGB(53, 120, 184, 1) forState:UIControlStateSelected];
        self.typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.typeBtn.tag = 100+i;
        if (i== 0) {
            self.typeBtn.selected = YES;
            self.btnTag = self.typeBtn.tag;
            
            self.lineView = [[UIView alloc]init];
            self.lineView.backgroundColor = RGB(53, 120, 184, 1);
            [self addSubview:self.lineView];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.typeBtn.mas_bottom).offset(-1);
                make.left.equalTo(self.typeBtn);
                make.width.equalTo(self.typeBtn);
                make.height.equalTo(@1);
            }];
            
        }
        
        [self.typeBtn addTarget:self action:@selector(selectdTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)selectdTypeBtnAction:(UIButton *)sender{
    if (self.btnTag == sender.tag) {
        return;
    }
    UIButton *btn = [self viewWithTag:self.btnTag];
    btn.selected = NO;
   
    //当前选中
    sender.selected = YES;
    self.btnTag =  sender.tag;
    
    //修改线条view的位置
    [self lineViewFrame:sender];
    
    if ([self.delegate respondsToSelector:@selector(selectdOrderTypeNSIntager:)]) {
        [self.delegate selectdOrderTypeNSIntager:sender.tag-99];
    }
    
}
//修改lineview的位置
-(void)lineViewFrame:(UIButton *)sender
{
    CGRect lineViewFrame = self.lineView.frame;
    lineViewFrame.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration: 0.5 animations:^{
        self.lineView.frame = lineViewFrame;
    }];
    
}


@end
