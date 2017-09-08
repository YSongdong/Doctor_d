//
//  ReviewViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ReviewViewController.h"
#import "ProgressView.h"
#import "PersonDescriptViewController.h"
@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;


@property (weak, nonatomic) IBOutlet UILabel *textLabel;


@property (weak, nonatomic) IBOutlet UILabel *alertTitle;

@property (weak, nonatomic) IBOutlet UIView *textView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {

    _progressView.account = 3 ;
    _progressView.progress = 2 ;
    _progressView.viewWidth = 20 ;
    _progressView.lineHeight =2 ;
    _progressView.roundViewColor = [UIColor orangesColor];
    _progressView.backColor = [UIColor light_GrayColor];
    [_progressView addViews];
    [_progressView setText];
}
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.textView.layer.borderColor = self.textLabel.textColor.CGColor ;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 4 ;
    self.textView.layer.masksToBounds = YES ;    
    
    CGPoint point = [self.textView convertPoint:CGPointMake(0, CGRectGetMaxY(self.textView.frame)) toView:self.backGroundView];
    
    if (point.y < HEIGHT) {
    self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }
}

- (void)leftButtonOperator {
    for (UIViewController *controler  in self.navigationController.viewControllers) {
        if ([controler isKindOfClass:[PersonDescriptViewController class]]) {
            [self.navigationController popToViewController:controler animated:YES];
        }
    }
}

- (IBAction)sureBtnClick:(id)sender {
    [self leftButtonOperator];
}

@end
