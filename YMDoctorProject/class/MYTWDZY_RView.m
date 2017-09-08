//
//  MYTWDZY_RView.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTWDZY_RView.h"

@interface MYTWDZY_RView ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (nonatomic,strong) UIButton * jieshouBtn;
@property (nonatomic,strong) NSMutableArray * btnArray;

@end


@implementation MYTWDZY_RView

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self initView];
    
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.height/2.0;
    self.headImage.clipsToBounds = YES;
}

-(void)setJieshouBtn:(UIButton *)jieshouBtn{
    _jieshouBtn = jieshouBtn;
    
    [_jieshouBtn setBackgroundColor:[UIColor colorWithRed:66/255.f green:147/255.f blue:247/255.f alpha:1]];
}

-(void)setSelectedBtnWithIndex:(NSInteger)index{
    self.jieshouBtn.selected = NO;
    [self.jieshouBtn setBackgroundColor:[UIColor whiteColor]];

    self.jieshouBtn = self.btnArray[index];
    self.jieshouBtn.selected = YES;
}

- (IBAction)btnClick:(UIButton *)sender {
    
    if (self.jieshouBtn!= sender) {
        self.jieshouBtn.selected = NO;
        [self.jieshouBtn setBackgroundColor:[UIColor whiteColor]];
        
        sender.selected = YES;
        self.jieshouBtn = sender;
    }
    
    if (self.BtnClickBack) {
        self.BtnClickBack(sender.tag);
    }
}

-(void)initView
{
//    [self.btnArray addObject:_btn1];
    [self.btnArray addObject:_btn2];
    [self.btnArray addObject:_btn3];
    [self.btnArray addObject:_btn4];
    
    NSInteger index = 0;
    for (UIButton * btn  in self.btnArray) {
        
        btn.layer.cornerRadius = btn.frame.size.height/2.00f;
        btn.clipsToBounds = YES;
        btn.tag = index;
        
        index ++;
    }
}




@end
