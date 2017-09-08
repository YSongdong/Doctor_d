//
//  TakingAlertView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//
#define LABEL_TAG 2000
#define BUTTON_TAG 1000 

#import "TakingAlertView.h"

@interface TakingAlertView ()

@property (nonnull,nonatomic,strong)UIView *backView ;
@property (nonatomic,strong)UITapGestureRecognizer *gesture ;
@property (nonatomic,assign)NSUInteger selectedIndex ;
@property (nonatomic,strong)NSMutableDictionary *params ;




@end

@implementation TakingAlertView

+ (TakingAlertView *)takingViewWithXIBWithtitles:(NSArray *)titles  {
TakingAlertView *view = [[[NSBundle mainBundle]loadNibNamed:@"ChoiceView" owner:self options:nil] firstObject];
    view.bounds = CGRectMake(0, 0, WIDTH *0.8,244);
    view.layer.cornerRadius = 10 ;
    view.layer.masksToBounds = YES ;
    view.alpha = 0 ;
    view.labelContents = titles;
    view.selectedIndex = 0 ;
    return view ;
}

- (void)viewShow {
    
    if (_backView) {
        [_backView removeFromSuperview];
        _backView = nil ;
    }
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _backView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureEvent:)];
    [_backView addGestureRecognizer:_gesture];
    for (int i = 0; i < _labelContents.count ; i ++ ) {
        UIButton *btn = [self viewWithTag:BUTTON_TAG + i ];
        [btn setImage:[UIImage imageNamed:@"unchoice"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"choiced"] forState:UIControlStateSelected];
        if (i == 0) {            
            NSLog(@"%@",_labelContents);
            if (_type == singleType) {
                [self.params setObject:_labelContents[i] forKey:@"resson"];
            }
            else {
                [self.params setObject:_labelContents[i] forKey:@"ressonx1"];
            }
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    [_backView addSubview:self];
    self.center = _backView.center ;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1 ;
    } completion:^(BOOL finished) {
    }];
}
- (void)gestureEvent:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.superview];
    if (!CGRectContainsPoint(self.frame, point)) {
        [self hiddenView];
    }
}
- (NSMutableDictionary *)params {
    
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}
- (void)hiddenView {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0 ;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_backView removeFromSuperview];
        _backView = nil ;
    }];
    
}

- (void)setLabelContents:(NSArray *)labelContents {
    
    _labelContents = labelContents ;
    for (int i = 0; i < labelContents.count; i ++ ) {
        UILabel *label = [self viewWithTag:LABEL_TAG + i ];
        [label setText:labelContents[i]];
    }
}

- (void)setType:(ChoiceType)type {
    _type = type ;
}

- (IBAction)choiceDifferentLabel:(UIButton *)sender {
    
    
    UIButton *btn = [self viewWithTag:_selectedIndex + BUTTON_TAG ];
    //单选
    if (_type == singleType) {
        if (_selectedIndex == sender.tag - BUTTON_TAG) {
            return ;
        }
        btn.selected = NO ;
        sender.selected = YES ;
        _selectedIndex = sender.tag - BUTTON_TAG ;
        [self.params setObject:_labelContents[_selectedIndex] forKey:@"resson"];
        
    }
    else {
        NSMutableString *keys = [NSMutableString stringWithFormat:@"ressonx"];
        
        NSInteger index = sender.tag  - BUTTON_TAG ;
        sender.selected =!sender.selected;
         [keys appendFormat:@"%ld",index + 1];
        if (sender.selected) {
        [self.params setObject:_labelContents[index]
                          forKey:keys];
        }
        else {
            [self.params removeObjectForKey:keys];
        }
    }
}


- (IBAction)sureBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSureBtn:andType:)]) {
        [self.delegate didClickSureBtn:[self.params mutableCopy] andType:_type];
    }
    [self hiddenView];
    
}

- (IBAction)cancelBtnClicked:(id)sender {
    
    
    [self.params removeAllObjects];
    [self hiddenView];
}

@end
