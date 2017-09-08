//
//  MYTAddHonourTableViewController.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTAddHonourTableViewController.h"
#import "PersonViewModel.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>
#import "MYTHonourViewController.h"

@interface MYTAddHonourTableViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic,strong) NSDictionary *imgDict;

@end

@implementation MYTAddHonourTableViewController

-(NSMutableDictionary*)params{
    
    if (_params == nil) {
        _params = [NSMutableDictionary new];
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeDateView];
    
    if (self.pushDict) {
        
        self.honorNameTF.text = self.pushDict[@"honor_name"];
        [self.honorTimeBtn setTitle:self.pushDict[@"honor_time"] forState:UIControlStateNormal];
        self.params[@"honor_time"] =self.pushDict[@"honor_time"] ;
        [self.honorImageView sd_setImageWithURL:[NSURL URLWithString:self.pushDict[@"honor_image"]]];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick)];
    [self.honorTimeBtn addTarget:self action:@selector(honorTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * pan =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    [self.tableView addGestureRecognizer:pan];
}

-(void)panfunction:(UIGestureRecognizer*)pan{
    
    [self.honorNameTF resignFirstResponder];
}

- (IBAction)endeditingClick:(UITextField *)sender {
    
}


//点击保存按钮
- (void)saveClick{
    
    //endEditing:结束编辑,键盘消失
    [self.view endEditing:YES];
    
    [self requestDataWithView:self.view];
}


//请求列表数据
- (void)requestDataWithView:(UIView *)view{
    
    if (self.pushDict) {
//        b标识编辑
        [self bianjiNetWorkWithView:view];
    }else{
//        新增
        [self xinzengNetWorkWithView:view];
    }
}

//编辑
-(void)bianjiNetWorkWithView:(UIView*)view
{
    if([self getMember_id]){
        
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    
    self.params[@"honor_name"] = self.honorNameTF.text;
    self.params[@"honor_image"] = self.imgDict ==  nil ?self.pushDict[@"honor_image"]:[self getImgName];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:Honor_Save params:self.params andData:self.imgDict==nil?@[]:@[self.imgDict] waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"==%@",showdata);
        MYTHonourViewController *vc = self.navigationController.viewControllers[1];
        [vc requestListDataWithView:vc.view];
        
        [self.navigationController popToViewController:vc animated:YES];
    }];
}

//新增
-(void)xinzengNetWorkWithView:(UIView*)view
{
    if([self getMember_id]){
        
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    
    self.params[@"honor_name"] = self.honorNameTF.text;
    self.params[@"honor_image"] =[self getImgName];
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:Honor_Save params:self.params andData:self.imgDict==nil?@[]:@[self.imgDict] waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"==%@",showdata);
        MYTHonourViewController *vc = self.navigationController.viewControllers[1];
        [vc requestListDataWithView:vc.view];
        
        [self.navigationController popToViewController:vc animated:YES];
    }];
}

//获得输入框的值
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.honorNameTF.text = textField.text;
}

//获得时间
-(void)honorTimeBtnClick{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect rect = self.dateView.frame;
        
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
        }
        else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
}

- (void)selected:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
        }
        else {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        
        NSDate *date = self.datePicker.date;
        
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy-MM-dd";
        
        self.params[@"honor_time"] = [dateformatter stringFromDate:date];
        [self.honorTimeBtn setTitle:self.params[@"honor_time"] forState:UIControlStateNormal];
    }
}

- (void)makeDateView {
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 45)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    cancle.titleLabel.textColor = [UIColor whiteColor];
    cancle.titleLabel.font = [UIFont systemFontOfSize:15];
    cancle.backgroundColor = [UIColor clearColor];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, 0, 50, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 101;
    button.titleLabel.textColor = [UIColor whiteColor];
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    linview.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview];
    UIView *linview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];
    linview1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview1];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:button];
    [self.dateView addSubview:cancle];
    [self.dateView addSubview:self.datePicker];
    
    [self.view addSubview:self.dateView];
    UILabel *titlesLabel = [[UILabel alloc]init];
    [self.dateView addSubview:titlesLabel];
    titlesLabel.font = [UIFont systemFontOfSize:15];
    titlesLabel.text = @"请选择时间";
    titlesLabel.textColor = [UIColor whiteColor];
    
    
    [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.dateView.mas_top);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.lessThanOrEqualTo(@250);
    }];
    
    [self.view addSubview:self.dateView];
}

//上传图片
- (IBAction)imageGetClick:(UIButton *)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相册
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    [controller addAction:action];
    [controller addAction:action1];
    [controller addAction:action2];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

-(NSString *)getImgName{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%@_%f.jpg",[self getMember_id], a];
    return timeString;
}

//上传头像
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
    
    NSString *timeString =[self getImgName];
    NSDictionary * imgDict = @{
                               @"data":data,
                               @"name":timeString
                               
                               };
    self.imgDict = imgDict;
    
    self.honorImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
