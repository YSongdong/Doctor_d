//
//  MYTOfficialApplyViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/20.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOfficialApplyViewController.h"
#import "MYTOfficialDetailsViewController.h"

@interface MYTOfficialApplyViewController ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLab;


@property (nonatomic, strong)NSMutableDictionary *params;

@end

@implementation MYTOfficialApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动报名";

    self.params = [NSMutableDictionary new];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitClick)];
    
    self.textView.delegate = self;
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    [self.view addGestureRecognizer:pan];
}

-(void)panfunction:(UIGestureRecognizer*)pan{
    [self.view  endEditing:YES];
}


- (void)submitClick{
    
    [self requestListDataWithView:self.view];
    
   // [self alertViewShow:@"报名成功"];
    
    MYTOfficialDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOfficialDetailsViewController"];
    vc.activity_id = self.activity_id;
    [self.navigationController pushViewController:vc animated:YES];
}


//请求列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    self.params[@"activity_id"] = self.activity_id;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Activities_Submit
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
    NSLog(@"showdata===========%@",showdata);
        
    if (showdata == nil){
        return ;
    }
    
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.placeHolderLab.hidden = NO ;
    }
    self.params[@"personal_statement"] = textView.text ;
}


- (void)textViewDidChange:(UITextView *)textView {
    
    self.params[@"personal_statement"] = textView.text ;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.placeHolderLab.hidden = YES ;
    return YES ;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
