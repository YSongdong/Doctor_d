//
//  AddressPickerView.m
//  FenYouShopping
//
//  Created by fenyou on 15/12/22.
//  Copyright © 2015年 fenyou. All rights reserved.
//

#import "AddressPickerView.h"


#define YEAR 0
#define MONTH 1
#define DAY 2

@interface AddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView *pickerView ;
@property (nonatomic,strong)NSArray *cityArray ;
@property (nonatomic,strong)NSArray *provinceArray ;
@property (nonatomic,strong)NSArray *areaArray ;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,strong)NSMutableDictionary *addressInfo ;
@property (nonatomic,strong)UIButton *sureBtn ;
@property (nonatomic,strong)UIButton *cancelBtn ;
@property (nonatomic,strong)UIView *containView ;
@property (nonatomic,strong)UIDatePicker *datePicker ;

@end
@implementation AddressPickerView
-(instancetype)initWithFrame:(CGRect)frame
                     andType:(PickViewType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _addressInfo = [NSMutableDictionary dictionary];
        self.type = type ;
        [self congfigUI];
    }
    return self ;
}
-(void)congfigUI {
    
    
    _cancelBtn = [self buttonWithTitle:@"取消"];
    _cancelBtn.center = CGPointMake(_cancelBtn.width/2,
                                    _cancelBtn.height/2 + 10 *VerticalRatio());
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,- (_cancelBtn.width/2 + 10), 0, 0)];

    _sureBtn = [self buttonWithTitle:@"完成"];
    [_sureBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.center = CGPointMake(self.width - _sureBtn.width/2,
                _cancelBtn.height/2+ 10 *VerticalRatio());
    [_sureBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_sureBtn.width / 2 + 10, 0, 0)];
    [self addSubview:_sureBtn];
    [self addSubview:_cancelBtn];
}
- (void)setDataList:(NSArray *)dataList  {
    
    _dataList = dataList ;
    if (self.type==pickViewTypeNormal1) {
        self.selectedStr =dataList[0];
    }else{
        self.selectedHospital =dataList[0];
    }
    [self.pickerView reloadAllComponents];
    
}

- (void)setMinDate:(NSString *)minDate {
    
    _minDate = minDate ;
    NSDateFormatter *formatter =  [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.datePicker.minimumDate = [formatter dateFromString:minDate];
}
- (void)open
{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *containerView = [[UIView alloc]initWithFrame:keyWindow.bounds];
    containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [containerView addSubview:self];
    containerView.userInteractionEnabled = YES ;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [containerView addGestureRecognizer:gesture];
    _containView = containerView ;
    [keyWindow addSubview:containerView];
    
    UIView *view ;
    
    if (self.type == pickerViewTypeDate) {
        [self addSubview:self.datePicker];
        view = self.datePicker ;
    }
    else if (self.type == pickViewTypeNormal) {
        [self addSubview:self.pickerView];
        view = self.pickerView ;
        [self.pickerView reloadAllComponents];
    }else if (self.type == pickViewTypeNormal1) {
        [self addSubview:self.pickerView];
        view = self.pickerView ;
        [self.pickerView reloadAllComponents];
    }
    
    CGFloat start =  CGRectGetMaxY(_cancelBtn.frame) + 10 ;
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -200 *VerticalRatio());
        view.frame = CGRectMake(0,start,WIDTH, self.height -start ) ;
    } completion:^(BOOL finished) {
    }];
    
    
}
- (void)close {
    
    [UIView animateWithDuration:0.25
                     animations:^{
        self.transform = CGAffineTransformIdentity ;
    } completion:^(BOOL finished) {
        if (self.pickerView.superview) {
            [self.pickerView removeFromSuperview];
        }else if(self.datePicker.superview){
            [self.datePicker removeFromSuperview];
        }
        [self removeFromSuperview];
        [_containView removeFromSuperview];
        _containView = nil ;
    }];
}


- (void)cancel {
    
    [self close];
    
}
- (void)makeSure {
    
    
    if (self.type == pickerViewTypeDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        if (self.longType == 1) {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }else {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }

        NSDateFormatter *formatter2 = [NSDateFormatter new];
        [formatter2 setDateFormat:@"yyyy月MM月dd日 HH时mm分"];
        NSString *str = [formatter stringFromDate:self.datePicker.date];
        NSString *text = [formatter2 stringFromDate:self.datePicker.date];
        if (self.block) {
            self.block(  @{@"time":str
                         ,@"text":text});
        }
    }else {
        
        if (self.type==pickViewTypeNormal1) {
            if (self.selectedStrBlack) {
                self.selectedStrBlack(self.selectedStr);
            }
        }else{
            if (self.block) {
                self.block(self.selectedHospital);
            }
        }

    
    }
    [self close];
}


#pragma mark--UIPickerViewDataSource UIPickerDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1 ;

}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
       return [self.dataList count] ;
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
    if (self.type==pickViewTypeNormal1) {
        self.selectedStr =self.dataList[row];
    }else{
        self.selectedHospital = self.dataList[row];
    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    if (!view) {
        view = [[UIView alloc]initWithFrame:pickerView.bounds];
        UILabel *label = [UILabel new];
        label.frame = view.frame ;
        label.textAlignment = NSTextAlignmentCenter ;
        if (self.type == pickViewTypeNormal1) {
            label.text = [NSString stringWithFormat:@"%@",self.dataList[row]];
        }if (self.type == pickViewTypeNormal) {
            label.text = self.dataList[row][@"name"];
        }
        
        [view addSubview:label];
    }
    return view;
}

#pragma mark---getter
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        if (_longType == 1) {
            _datePicker.datePickerMode = UIDatePickerModeDateAndTime ;
        }
        else {
            _datePicker.datePickerMode = UIDatePickerModeDate ;

        }
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
         _datePicker.autoresizingMask =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth ;
               //_datePicker.minimumDate = [formatter dateFromString:@"1950-1-1"];
       // _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker ;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self ;
        _pickerView.dataSource = self ;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.center = self.center ;
    }
    return _pickerView ;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.width = self.width/2;
    button.height = 20 *VerticalRatio();
    button.titleLabel.font = [UIFont systemFontOfSize:17 *VerticalRatio()];
    return button ;
}
@end
