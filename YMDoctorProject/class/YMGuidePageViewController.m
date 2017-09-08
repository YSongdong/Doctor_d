//
//  YMGuidePageViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMGuidePageViewController.h"

@interface YMGuidePageViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,assign)NSInteger guidePageTage;

@property(nonatomic,strong)UIButton *listButton;

@end

@implementation YMGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _guidePageTage = 2;
    // Do any additional setup after loading the view.
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"guidePages1"];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guidePagesChage)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    
    _listButton = [[UIButton alloc]init];
    _listButton.backgroundColor = [UIColor clearColor];
    UIImage *listImage = [UIImage imageNamed:@"guide_list"];
    [_listButton setImage:[UIImage imageNamed:@"guide_list"] forState:UIControlStateNormal];
    [_listButton addTarget:self action:@selector(guidePagesChage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_listButton];
    [_listButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(listImage.size.height);
        make.width.mas_equalTo(listImage.size.width);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-150);
    }];
    
}


-(void)guidePagesChage{
    if (_guidePageTage ==4) {
        
        if ([self.delegate respondsToSelector:@selector(GuidePageController:IKnow:)]) {
            [self.delegate GuidePageController:self IKnow:YES];
        }
    }else{
        if (_guidePageTage>2) {
            
//            UIButton *personalButton = [[UIButton alloc]init];
//            UIImage *image = [UIImage imageNamed:@"imgv_yindao_show_fitness"];
//            [personalButton setImage:image forState:UIControlStateNormal];
//            personalButton.backgroundColor = [UIColor clearColor];
//            [personalButton addTarget:self action:@selector(inputInfor) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:personalButton];
//            [personalButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self.view.mas_centerX);
//                make.height.mas_equalTo(image.size.height);
//                make.width.mas_equalTo(image.size.width);
//                make.top.equalTo(self.view.mas_top).offset(100);
//            }];
            
            UIImage *listImage = [UIImage imageNamed:@"imgv_yindao_show_fitness"];
            [_listButton setImage:listImage forState:UIControlStateNormal];
            [_listButton mas_updateConstraints:^(MASConstraintMaker *make){
                make.height.mas_equalTo(listImage.size.height);
                make.width.mas_equalTo(listImage.size.width);
            }];
        }
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guidePages%ld",(long)_guidePageTage]];
        _guidePageTage ++;
    }
}


-(void)inputInfor{
    NSLog(@"进入个人资料");
    
    if ([self.delegate respondsToSelector:@selector(GuidePageController:inputPerson:)]) {
        [self.delegate GuidePageController:self inputPerson:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
