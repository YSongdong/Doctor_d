//
//  SharePlatView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SharePlatView.h"

@interface SharePlatView ()


@property (weak, nonatomic) IBOutlet UIButton *shareDoctor;
@property (weak, nonatomic) IBOutlet UIButton *shareUser;
@property (weak, nonatomic) IBOutlet UIView *backView;



@end

@implementation SharePlatView
{
    NSInteger _selectedBtn ;
}

+ (SharePlatView *)sharePlatViewWithAnimation {
    SharePlatView *view =  [[[NSBundle mainBundle]
                             loadNibNamed:@"SharePlatView" owner:self options:nil]firstObject] ;
    view.frame = CGRectMake(0, HEIGHT, WIDTH, 300);
    
    return view ;
}

//取消
- (IBAction)cancelBtn_event:(id)sender {
    
    [self hiddenShareView];
}

//分享给医生
- (IBAction)share_toDoctor_event:(id)sender {

    
    [self selctedView:sender selcted:YES];
    [self selctedView:self.shareUser selcted:NO];
    _selectedBtn = 0 ;
    self.type = shareDoctor ;
}

//分享给用户
- (IBAction)share_toUserEvent:(id)sender {
    
    [self selctedView:sender selcted:YES];
    [self selctedView:self.shareDoctor selcted:NO];
    self.type = shareUser ;
    
    _selectedBtn = 1;
}

//分享不不同平台
- (IBAction)shareWithDifferentPlatForm:(id)sender {
    
    UIView *btn = (UIButton *)sender ;
    NSArray *array = @[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina),
                       @(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)];

    if (self.shareBlock) {
        self.shareBlock([array[btn.tag - 1000] unsignedIntegerValue],self.type);
    }
    [self hiddenShareView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _backView.layer.cornerRadius = 10 ;
    _backView.layer.masksToBounds = YES ;
    
    _cancelBtn.layer.cornerRadius = 10 ;
    _cancelBtn.layer.masksToBounds = YES ;
    
    _shareBackView.layer.cornerRadius = 10 ;
    _shareBackView.layer.masksToBounds = YES ;
    
    _shareDoctor.layer.cornerRadius = 7 ;
    _shareDoctor.layer.masksToBounds = YES ;
    _shareDoctor.layer.borderColor = [UIColor colorWithRGBHex:0x969696].CGColor;
    _shareDoctor.layer.borderWidth = 1;
    
    _shareUser.layer.cornerRadius = 7 ;
    _shareUser.layer.masksToBounds = YES ;
    _shareUser.layer.borderColor = [UIColor colorWithRGBHex:0x4797FE].CGColor;
    _shareUser.layer.borderWidth = 1;
    
    self.type = shareUser ;
}

- (void)showAnimation {
    
    UIWindow *key = [UIApplication sharedApplication].keyWindow ;    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [key addSubview:backView];
    _backView = backView ;
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [backView addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -300);
    } completion:nil];
}

- (void)selctedView:(UIButton *)view
            selcted:(BOOL)selected{
    
    if (selected){
        
        view.layer.borderColor = [UIColor colorWithRGBHex:0x4797FE].CGColor ;
        [view setTitleColor:[UIColor colorWithRGBHex:0x4797FE] forState:UIControlStateNormal];
    }
    else {

        view.layer.borderColor = [UIColor colorWithRGBHex:0xAAAAAA].CGColor;
          [view setTitleColor:[UIColor colorWithRGBHex:0xAAAAAA] forState:UIControlStateNormal];
    }
}

- (void)hiddenShareView {
    
    [UIView animateWithDuration:0.25 animations:^{
    self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_backView removeFromSuperview];
        _backView = nil ;
    }];
}

@end
