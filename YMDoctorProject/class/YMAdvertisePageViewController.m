//
//  YMAdvertisePageViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAdvertisePageViewController.h"

@interface YMAdvertisePageViewController ()

@property(nonatomic,strong)UIImageView *defaultStartUpImageView;

@property(nonatomic,strong)UIImageView *networkImageView;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,copy)NSString *requrtUrl;

@property(nonatomic,assign)BOOL clickAdvertising;

@property(nonatomic,strong)UIButton *leapfrogButton;

@property(nonatomic,assign)NSInteger leapfrogNumber;

@end

@implementation YMAdvertisePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _leapfrogNumber = 5;
    [self iniView];
    [self loadRequrt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)iniView{
    self.view.userInteractionEnabled = YES;
    UIImage *advertImage = [UIImage imageNamed:@"advertising_bottom"];
    
    _defaultStartUpImageView = [[UIImageView alloc]initWithImage:advertImage];
    _defaultStartUpImageView.userInteractionEnabled = YES;
    [self.view addSubview:_defaultStartUpImageView];
    [_defaultStartUpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(advertImage.size.height);
    }];
        
    _networkImageView = [[UIImageView alloc]init];
    _networkImageView.image = [UIImage imageNamed:@"advertising_top"];
    _networkImageView.hidden = YES;
    _networkImageView.userInteractionEnabled = YES;
    [self.view addSubview:_networkImageView];
    [_networkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_defaultStartUpImageView.mas_top);
    }];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputAdvertising)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [_networkImageView addGestureRecognizer:tapGestureRecognizer];
    
    _leapfrogButton = [[UIButton alloc]init];
    _leapfrogButton.backgroundColor = [UIColor whiteColor];
    _leapfrogButton.layer.borderWidth = 0.5;
    _leapfrogButton.layer.borderColor = [UIColor blackColor].CGColor;
    _leapfrogButton.layer.masksToBounds = YES;
    _leapfrogButton.layer.cornerRadius = 5.f;
    
    [_leapfrogButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];

    _leapfrogButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_leapfrogButton];
    [_leapfrogButton addTarget:self action:@selector(setTipViewHidden) forControlEvents:UIControlEventTouchUpInside];
    [_leapfrogButton setTitle:[NSString stringWithFormat:@"跳过(%ld)",(long)_leapfrogNumber] forState:UIControlStateNormal];
    [_leapfrogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(leapfrogTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
}

-(void)loadRequrt{
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:StartPage_URL params:@{@"type":@1} withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray class]]) {
            _networkImageView.hidden = NO;
            NSDictionary *dic = showdata[0];
            NSString *imageUrl = dic[@"adv_image"];
            _requrtUrl =dic[@"adv_url"];
            [_networkImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        
    }];
}
-(void)setTipViewHidden{
    [_timer invalidate];
    _timer = nil;
    if (_clickAdvertising) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(advertisePageController:)]) {
        [self.delegate advertisePageController:self];
    }
}

-(void)inputAdvertising{
    _clickAdvertising = YES;
    if ([self.delegate respondsToSelector:@selector(advertisePageController:requrtUrl:inputadvertising:)]) {
        [self.delegate advertisePageController:self requrtUrl:_requrtUrl inputadvertising:_clickAdvertising];
    }
}

-(void)leapfrogTimer{
    _leapfrogNumber --;
    if (_leapfrogNumber==0) {
        [self setTipViewHidden];
    }else{
        [_leapfrogButton setTitle:[NSString stringWithFormat:@"跳过(%ld)",(long)_leapfrogNumber] forState:UIControlStateNormal];
        
    }
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    NSLog(@"%s",__FUNCTION__);
}


@end
