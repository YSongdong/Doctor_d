//
//  OrderStateView.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "OrderStateView.h"

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

@interface OrderStateView ()

@property(nonatomic,strong) UIButton *stateBtn;
@property(nonatomic,strong)  UIView *lineView;
@property(nonatomic,assign) CGFloat btnTag;
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSArray *stateArr;
@end


@implementation OrderStateView

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
-(NSArray *)stateArr{

    if (!_stateArr) {
        _stateArr = [NSArray array];
        
    }
    return _stateArr;
}

-(void)initBtn{
    self.backgroundColor = [UIColor lineColor];
    self.dataArr = @[@"全部",@"进行中",@"已完成",@"已失败"];
    self.stateArr =@[@"all",@"going",@"over",@"fail"];
    CGFloat btnW = SCREEN_WIDTH/4;
    for (int i=0; i< _dataArr.count; i++) {
        self.stateBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW+i*1, 0, btnW, self.frame.size.height-1)];
        [self addSubview:self.stateBtn];
        self.stateBtn.backgroundColor = [UIColor whiteColor];
        [self.stateBtn setTitle:_dataArr[i] forState:UIControlStateNormal];
        [self.stateBtn setTitleColor:[UIColor hightBlackClor] forState:UIControlStateNormal];
        [self.stateBtn setTitleColor:[UIColor bluesColor] forState:UIControlStateSelected];
        self.stateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.stateBtn.tag = 200+i;
        if (i== 0) {
            self.stateBtn.selected = YES;
            self.btnTag = self.stateBtn.tag;
            
            self.lineView = [[UIView alloc]init];
            self.lineView.backgroundColor = RGB(53, 120, 184, 1);
            [self addSubview:self.lineView];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottom).offset(-1);
                make.centerX.equalTo(self.stateBtn.mas_centerX);
                make.width.equalTo(self.stateBtn);
                make.height.equalTo(@1);
            }];
        }
        
        [self.stateBtn addTarget:self action:@selector(selectdTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    if ([self.delegate respondsToSelector:@selector(selectdOrderStateNSString:)]) {
        NSString *stateStr = self.stateArr[sender.tag-200];
        [self.delegate selectdOrderStateNSString:stateStr];
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
