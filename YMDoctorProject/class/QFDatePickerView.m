//
//  QFDatePickerView.m
//  dateDemo
//
//  Created by 情风 on 2017/1/12.
//  Copyright © 2017年 情风. All rights reserved.
//

#import "QFDatePickerView.h"
#import "AppDelegate.h"
#import <UIView+YYAdd.h>
@interface QFDatePickerView () <UIPickerViewDataSource,UIPickerViewDelegate>{
    UIView *contentView;
    void(^backBlock)(NSString *);
    
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSInteger currentYear;
    NSString *currentMonth;
    NSString *restr;
    
    NSString *selectedYear;
    NSString *selectecMonth;
}


@end

@implementation QFDatePickerView

#pragma mark - initDatePickerView
- (instancetype)initDatePacker{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    [self setViewInterface];
    return self;
}

#pragma mark - ConfigurationUI
- (void)setViewInterface {
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    if (dateArray.count == 2) {//年 月
        currentYear = [[dateArray firstObject]integerValue];
        currentMonth =  dateArray[1];
    }
    selectedYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
    selectecMonth = currentMonth;
    
    //初始化年数据源数组
    yearArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1970; i <= currentYear ; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld年",i];
        [yearArray addObject:yearStr];
    }
    
    //初始化月数据源数组
    monthArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1 ; i <= 12; i++) {
        NSString *monthStr = [NSString stringWithFormat:@"%ld月",i];
        [monthArray addObject:monthStr];
    }
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 364)];
    [self addSubview:contentView];
    //设置背景颜色为黑色，并有0.4的透明度
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //添加白色view
    UIView *closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    closeView.backgroundColor = [UIColor clearColor];
    [contentView addSubview:closeView];
    //添加确定和取消按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 40)];
    [button setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [closeView addSubview:button];
    [button addTarget:self action:@selector(closePicKer:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 210)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor colorWithRed:240.0/255 green:243.0/255 blue:250.0/255 alpha:1];
    
    //设置pickerView默认选中当前时间
    [pickerView selectRow:[selectedYear integerValue] - 1970 inComponent:0 animated:YES];
    [pickerView selectRow:[selectecMonth integerValue] - 1 inComponent:1 animated:YES];
    
    [contentView addSubview:pickerView];
    
    UIButton *fulfillButton = [[UIButton alloc]initWithFrame:CGRectMake(0, pickerView.bottom + 10, SCREEN_WIDTH, 40)];
    fulfillButton.backgroundColor = RGBCOLOR(80, 168, 252);
    [fulfillButton setTitle:@"完成" forState:UIControlStateNormal];
    [fulfillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fulfillButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 11;
    [contentView addSubview:fulfillButton];
    
}

#pragma mark - Actions
- (void)buttonTapped:(UIButton *)sender {
     [self dismiss];
    restr = [NSString stringWithFormat:@"%@-%@",selectedYear,selectecMonth];
    restr = [restr stringByReplacingOccurrencesOfString:@"年" withString:@""];
    restr = [restr stringByReplacingOccurrencesOfString:@"月" withString:@""];
    if ([self.delegage respondsToSelector:@selector(datePickerView:selectStr:)]) {
        [self.delegage datePickerView:self selectStr:restr];
    }
   
}


#pragma mark - 关闭时间选择器
-(void)closePicKer:(UIButton *)sender{
    [self dismiss];
}

#pragma mark - pickerView出现
- (void)show:(UIView *)show{
    
    [show addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y - contentView.frame.size.height);
    }];
    if ([self.delegage respondsToSelector:@selector(datePickerView:disMiss:)]) {
        [self.delegage datePickerView:self disMiss:NO];
    }
}
#pragma mark - pickerView消失
- (void)dismiss{
    
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y + contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if ([self.delegage respondsToSelector:@selector(datePickerView:disMiss:)]) {
        [self.delegage datePickerView:self disMiss:YES];
    }
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return yearArray.count;
    }
    else {
        return monthArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return yearArray[row];
    } else {
        return monthArray[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        selectedYear = yearArray[row];
        monthArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 1 ; i <= 12; i++) {
            NSString *monthStr = [NSString stringWithFormat:@"%ld月",i];
            [monthArray addObject:monthStr];
        }
        selectecMonth = currentMonth;

        [pickerView reloadComponent:1];
        
    } else {
        selectecMonth = monthArray[row];
    }
}

@end
