//
//  ContractViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ContractViewController.h"
#import "AddressPickerView.h"
#import "DemandOrderModel.h"
@interface ContractViewController ()<AddressPickerViewDelegate,DemandOrderModelDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *beginTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;
@property (weak, nonatomic) IBOutlet UILabel *protocalBtn;
@property (weak, nonatomic) IBOutlet UILabel *employerLabel; //雇主
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel; //服务商
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (nonatomic,strong)UIImageView *imageView1; //印章1
@property (nonatomic,strong)UIImageView *imageView2 ;//印章2
@property (nonatomic,strong)DemandOrderModel *orderModel ;
@property (nonatomic,assign)NSInteger sureBtnStatus ;
@property (nonatomic,assign)NSInteger operatorType ;

@property (nonatomic,assign)BOOL loadEnd ;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property (nonatomic,strong)NSMutableDictionary *dicParams ;
@end
@implementation ContractViewController

- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
    }return _dicParams ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadEnd = NO ;
    self.sureBtn.layer.cornerRadius = 5 ;
    self.sureBtn.layer.masksToBounds = YES ;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    _orderModel = [DemandOrderModel new];
    _orderModel.delegate = self ;
    _descriptTextView.delegate = self;
    self.sureBtnStatus = 0 ;
    self.imageView1 = [self addImageViewOnPoint:CGPointZero];
    self.imageView2 = [self addImageViewOnPoint:CGPointZero];
    self.serviceLabel.text = @"乙方: ";
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.placeHolder.hidden = YES ;
    return YES ;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (textView.text.length ==0 ) {
        self.placeHolder.hidden = NO ;
    }
    return YES ;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.model.demand_id) {
        dic[@"demand_id"] = self.model.demand_id ;
    }
    if ([self getStore_id]) {
        dic[@"store_id"] = [self getStore_id];
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Contract_Info_Url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
    if (!error) {
        
            [self.model setValuesForKeysWithDictionary:showdata[@"_contract"]];
            [self.model setValuesForKeysWithDictionary:showdata[@"_demand"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[showdata[@"doc_list"][@"doc_content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.protocalBtn.attributedText = attrStr ;
            self.loadEnd = YES ;
            [self viewDidLayoutSubviews];
        }
    }];
}

- (void)setLoadEnd:(BOOL)loadEnd {
    
    _loadEnd = loadEnd ;
    self.employerLabel.text =[NSString stringWithFormat:@" %@",self.model.member_truename] ;
    self.serviceLabel.text =  @"乙方 :鸣医通平台";

    //    self.employerLabel.text = @"鸣医通平台";
//    self.serviceLabel.text = [NSString stringWithFormat:@"乙方(雇主): %@",self.model.member_truename] ;
    if (self.model.contract_id){
        
        //开始就诊时间
        if (self.model.contract_time) {
            [self.beginTimeBtn setTitle: [NSString stringWithFormat:@"就诊开始时间:  %@",[self stringFromTimeInterval:self.model.contract_time]] forState:UIControlStateNormal];
        }
        //结束就诊时间
        if (self.model.contract_time1) {
             [self.endTimeBtn setTitle: [NSString stringWithFormat:@"就诊结束时间:  %@",[self stringFromTimeInterval:self.model.contract_time1]] forState:UIControlStateNormal];
        }
        
        self.beginTimeLabel.text = [self shortTimeInterval:self.model.ascertain_agree2];
        self.endTimeLabel.text = [self shortTimeInterval:self.model.ascertain_agree1];
        
//        self.beginTimeLabel.text = [self shortTimeInterval:self.model.ascertain_agree1];
//        self.endTimeLabel.text = [self shortTimeInterval:self.model.ascertain_agree2];
        
        self.descriptTextView.text = self.model.contract_content ;
        self.placeHolder.hidden = YES ;
        //合同没有签订完成
        if ([self.model.ascertain_state integerValue] == 0
            && [self.model.demand_qb integerValue] != 3 ) {
            //表示没有完成 需求订单 没有完成 雇佣订单
            if (self.model.ascertain_agree1 && !self.model.ascertain_agree2  &&
                [self.model.demand_qb integerValue] != 3) {
                [self.sureBtn setTitle:@"再约时间" forState:UIControlStateNormal];
                self.sureBtnStatus = 1;
            }
        }
        //表示有合同 但是我还没有签订
        if ([self.model.demand_qb integerValue] == 3 &&
            ([self.model.ascertain1 isEqual:[NSNull null]] || !self.model.ascertain1)) {
            [self.sureBtn setTitle:@"添加合同" forState:UIControlStateNormal];
            self.beginTimeBtn.enabled = NO ;
            self.endTimeBtn.enabled = NO ;
            self.descriptTextView.editable = NO ;
        }
        
        if ([self.model.ascertain_state integerValue] == 0) {
            if ([self.model.demand_qb integerValue]== 3 && [self.model.ascertain1 length] > 0) {
                self.sureBtn.hidden = YES ;
            }
        }
        //表示合同签订完成
        if ([self.model.ascertain_state integerValue] == 1) {
            self.sureBtn.hidden = YES ;
        }
    }
    //表示合同还没有发起
    else {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateStyle:NSDateFormatterMediumStyle];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateformatter stringFromDate:[NSDate date]];
        self.beginTimeLabel.text = dateString ;
        self.endTimeLabel.text = dateString ;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.model.ascertain_agree1){
        //表示已经我已经签订了合同
        self.beginTimeBtn.enabled = NO ;
        self.endTimeBtn.enabled = NO ;
        self.descriptTextView.editable = NO ;
    }
}

- (NSString *)stringFromTimeInterval:(NSString *)timeIntervalString {
    NSInteger timeInterval = [timeIntervalString integerValue];
    
    NSDate *date ;
    if (timeIntervalString == nil) {
        date = [NSDate date];
    }else {
        date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ;
}

- (NSString *)shortTimeInterval:(NSString *)timeIntervalString {
    NSInteger timeInterval = [timeIntervalString integerValue];
    NSDate *date ;
    if (timeIntervalString == nil) {
        date = [NSDate date];
    }else {
        date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ;

}

- (void)viewDidLayoutSubviews {
    
    CGFloat max_height = CGRectGetMaxY(self.sureBtn.frame);
    CGFloat height ;
    if (max_height <= HEIGHT - 64) {
        height = HEIGHT ;
    }
    else {
        height = CGRectGetMaxY(self.sureBtn.frame);
    }
    
    
    if (self.loadEnd) {
        self.imageView1.center = self.employerLabel.center ;
        self.imageView2.center = self.serviceLabel.center ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.model.ascertain_agree1){
                //表示已经我已经签订了合同
                self.imageView2.alpha = 1;
                //self.imageView1.alpha = 1;
            }
            if (self.model.ascertain_agree2) {
              self.imageView1.alpha = 1 ;
          //  self.imageView2.alpha = 1 ;
            }
        });
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width,height);
    
}
//选择开始时间
- (IBAction)beginTimeClickEvent:(id)sender{
    
    UIButton *btn = (UIButton *)sender ;
    AddressPickerView *addressPick = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio()) andType:pickerViewTypeDate];
    addressPick.longType = 1;
    addressPick.delegate = self ;
    addressPick.block = ^(NSDictionary *time){
        [btn setTitle:[NSString stringWithFormat:@"就诊开始时间:  %@",time[@"text"]]  forState:UIControlStateNormal];
        [self.dicParams setObject:time[@"time"] forKey:@"contract_time"];
    };
    [addressPick open];
}
//选择结束时间
- (IBAction)endTimeClickEvent:(id)sender {

    AddressPickerView *addressPick = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio()) andType:pickerViewTypeDate];
    addressPick.longType = 1;
    addressPick.delegate = self ;
    addressPick.minDate = self.dicParams[@"contract_time"];
    addressPick.block = ^(NSDictionary *time){
    [self.dicParams setObject:time[@"time"] forKey:@"contract_time1"];
  [self.endTimeBtn setTitle:[NSString stringWithFormat:@"就诊结束时间:  %@",time[@"text"]]
                 forState:UIControlStateNormal];
    };
    [addressPick open];
}
- (IBAction)sureBtnClick_Btn:(id)sender {
    
    if (self.sureBtnStatus == 1) {
        self.beginTimeBtn.enabled = YES ;
        self.endTimeBtn.enabled = YES ;
        [self.scrollView setContentOffset:CGPointMake(0, 0 ) animated:YES];
        [self.sureBtn setTitle:@"提交合同" forState:UIControlStateNormal];
        self.sureBtnStatus = 0 ;
        self.imageView2.alpha = 0 ;
        [self beginTimeClickEvent:self.beginTimeBtn];
        return ;
    }
    //上传合同
    NSString *url ;
    if ([self.model.demand_qb integerValue] == 3) {
      //表示疑难杂症
        //
        url = MAKE_IncruableContract_URL ;
    }else {
        //雇佣 需求订单
        url = MAKE_DemandOrder_Contract_Url ;
        if (self.model.demand_hire) {
            [self.dicParams setObject:self.model.demand_hire forKey:@"demand_hire"];
        }
    }
    if (self.model.demand_id) {
        [self.dicParams setObject:self.model.demand_id forKey:@"demand_id"];
    }
    if ([self getStore_id]) {
        [self.dicParams setObject:[self getStore_id] forKey:@"store_id"];
    }
    if (self.descriptTextView.text.length > 0) {
        
    [self.dicParams setObject:self.descriptTextView.text forKey:@"contract_content"];
    }
    
    
    if (self.endTimeLabel.text.length > 0) {
        NSDateFormatter *dataFormatter  = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [NSDate date];        
        [self.dicParams setObject:[NSString stringWithFormat:@"%@",[dataFormatter stringFromDate:date]] forKey:@"ascertain_agree1"];
    }
    if (!self.dicParams[@"contract_time"]
        && self.model.contract_time) {
        self.dicParams[@"contract_time"] = self.model.contract_time ;
    }
    if (!self.dicParams[@"contract_time1"]
        && self.model.contract_time1) {
        self.dicParams[@"contract_time1"] = self.model.contract_time1 ;
    }
    [self.dicParams setObject:self.model.member_names forKey:@"ascertain1"];
    self.operatorType = 1 ;
    
    [self.orderModel makeContractWithUrl:url andParams:self.dicParams andView:self.view];
}

- (void)operatorFailureWithReason:(NSString *)reason {
    [self alertViewShow:reason];
    if (self.sureBtnStatus == 1) {
        self.sureBtnStatus = 0 ;
    }

}
- (void)operatorSuccessWithReason:(NSString *)reason {
    if (self.operatorType == 1) {
        [self.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        if (self.sureBtnStatus == 1) {
            self.sureBtnStatus = 0 ;
        }
        else {
            [self addImageViewe];
        }
        self.sureBtn.enabled = NO ;
    }
}

- (void)addImageViewe {
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"contract"];
    imageView.bounds = CGRectMake(0, 0, self.view.width * 0.8, self.view.width * 0.8);
    imageView.center =  CGPointMake(self.view.width / 2,self.view.height /2);
    imageView.alpha = 0 ;
    [self.view addSubview:imageView];
    CGPoint endPoint = [self.backView convertPoint:_serviceLabel.center toView:self.view];
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.9 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        imageView.alpha = 1;
        imageView.bounds = CGRectMake(0, 0, imageView.image.size.width * 1.5,  imageView.image.size.height * 1.5);
            imageView.center = endPoint ;
        } completion:^(BOOL finished) {
            imageView.alpha =0 ;
            [imageView removeFromSuperview];
            self.imageView2.alpha = 1 ;
        }];
}
- (UIImageView *)addImageViewOnPoint:(CGPoint)point {
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"contract"];
    imageView.bounds = CGRectMake(0, 0, imageView.image.size.width * 1.5, imageView.image.size.height *1.5);
    imageView.center = point;
    imageView.alpha = 0 ;
    [self.backView addSubview:imageView];
    return imageView ;
}

@end
