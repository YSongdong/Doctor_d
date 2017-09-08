//
//  MYTBasicInformationViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MJExtension.h"
#import "Doctor_timeModel.h"
#import "MYTBasicInformationViewController.h"
#import "YMHospitalListViewController.h"
#import "MYTBasicInformationTableViewCell.h"
#import "CustomPickerViewTool.h"

#import "AddressPickerView.h"

#import "MYTDiseaseViewController.h"


@interface MYTBasicInformationViewController ()<UITableViewDelegate,UITableViewDataSource,YMHospitalListViewControllerDelegate,UITextViewDelegate,UITextFieldDelegate,MYTDiseaseViewControllerDelegate>

@property (nonatomic,strong) AddressPickerView * pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)YMHospitalModel *model;

@property (strong,nonatomic)NSMutableDictionary *params;

@property (strong, nonatomic) UILabel *detailsPlaceHolder;
@property (strong, nonatomic) UILabel *personPlaceHolder;

@property (strong, nonatomic) UITextView *selectedTextView;


@property (strong,nonatomic)NSMutableArray * doctor_timeArray;


@property (nonatomic,strong) NSArray * weekArr;
//上午下午 晚上
@property (nonatomic,strong) NSArray * periodArr;


@property (nonatomic,strong) UIButton * jieShouBtn;
//1 星期 2 上午下午
@property (nonatomic,assign) NSInteger  flag;

@property(nonatomic,strong)NSArray *selectDiseaseArry;

@property(nonatomic,copy)NSString *specialty_tags;

@property(nonatomic,copy)NSString *specialty_tagsName;

@property(nonatomic,strong)NSMutableArray *doctorSelecttimeArry;

@end

@implementation MYTBasicInformationViewController



-(AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio()) andType:pickViewTypeNormal1];
        
        __weak typeof(self) weakSelf = self;
        _pickerView.selectedStrBlack = ^(NSString *selectedStr) {
            
            [weakSelf.jieShouBtn setTitle:selectedStr forState:UIControlStateNormal];
            Doctor_timeModel * model = weakSelf.doctor_timeArray[weakSelf.jieShouBtn.tag];
            if (weakSelf.flag==1) {
                //                星期
                
                model.week =[NSString stringWithFormat:@"%ld",(unsigned long)[weakSelf.weekArr indexOfObject:selectedStr]];
                
            }
            if (weakSelf.flag==2) {
                //                上午
                model.period =[NSString stringWithFormat:@"%ld",(unsigned long)[weakSelf.periodArr indexOfObject:selectedStr]+1];
            }
            
        };
    }
    return _pickerView;
}

-(NSArray *)weekArr{
    if (!_weekArr) {
        _weekArr = @[
                     @"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"
                     ];
    }
    
    return _weekArr;
}
-(NSArray *)periodArr{
    if (!_periodArr) {
        _periodArr = @[
                       @"上午",@"下午"
                       ];
    }
    
    return _periodArr;
}
/**
 提交
 */
- (IBAction)tijiaoBtnClick:(UIButton *)sender {
    
    [self nextClick];
}







-(NSMutableArray *)doctor_timeArray{
    if (!_doctor_timeArray) {
        _doctor_timeArray = [NSMutableArray new];
    }
    return _doctor_timeArray;
}
-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary new];
    }
    return _params;
}

/**
 TODO:viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    [self requestDataWithView:self.view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(nextClick)];
    
    //    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificiation:) name:@"MYTBasicInformationTableViewCellClick" object:nil];
    //    [self.view addGestureRecognizer:pan];
    
    _specialty_tags = @"";
    _specialty_tagsName = @"";
    _doctorSelecttimeArry = [NSMutableArray array];
}


-(void)panfunction{
    [self.view  endEditing:YES];
}


-(void)nextClick{
    
    //    if ([self.status isEqualToString:@"0"]) {
    [self loadDataWithView:self.view];
    //
    //    }else{
    //
    //        [self alertViewShow:@"已认证信息如需修改请联系客服"];
    //
    //    }
}

//基本信息   保存
- (void)loadDataWithView:(UIView *)view{
    
    self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    
    self.params[@"specialty_tags"] = _specialty_tags;
    
    
    
    NSLog(@"self.params--------------%@",self.params);
    
    [_doctorSelecttimeArry removeAllObjects];
    for (Doctor_timeModel *model in _doctor_timeArray) {
        NSDictionary *dic = @{@"week":model.week,
                              @"period":model.period,
                              @"hospital":model.hospital,
                              @"ks":@""};
        
        [_doctorSelecttimeArry addObject:dic];
    }
    if (_doctorSelecttimeArry.count >0) {
        NSError *error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_doctorSelecttimeArry
                                                           options:kNilOptions
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        self.params[@"doctor_time"] = jsonString;
    }else{
        self.params[@"doctor_time"]=@"";
    }
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Doctor_personal_Save
                                                params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                                                    
                                                    NSLog(@"showdata----------------%@",showdata);
                                                    
                                                    if (showdata == nil){
                                                        return ;
                                                    }
                                                    [self navBackAction];
                                                    
                                                    //        [self.tableView reloadData];
                                                }];
}

//基本信息  查看
- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Doctor_personal_URL
                                                params:@{   @"member_id":@([[self getMember_id] integerValue])
                                                         }withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                                                             
                                                             NSLog(@"showdata----------------%@",showdata);
                                                             
                                                             if (showdata == nil){
                                                                 return ;
                                                             }
                                                             self.params[@"member_occupation"] = showdata[@"member_occupation"];
                                                             _specialty_tags= showdata[@"specialty_tags"];
                                                             
                                                             [self.params setValuesForKeysWithDictionary:showdata] ;
                                                             NSArray * tempArr =showdata[@"doctor_time"];
                                                             if (tempArr.count==0) {
                                                                 //初始化
                                                                 Doctor_timeModel * doctor_timeModel = [[Doctor_timeModel alloc]init];
                                                                 [self.doctor_timeArray addObject:doctor_timeModel];
                                                             }else{
                                                                 self.doctor_timeArray = [Doctor_timeModel mj_objectArrayWithKeyValuesArray:tempArr];
                                                             }
                                                             [self.tableView reloadData];
                                                         }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4+self.doctor_timeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYTBasicInformationTableViewCell *cell;
    
    switch (indexPath.section) {
            case 0:{
                NSString *cellIdentifier = @"basicCell1";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                NSString *hospitalStr = self.params[@"member_occupation_name"];
                if ([hospitalStr isEqualToString:@""] || hospitalStr == nil) {
                    hospitalStr = @"请选择";
                }
                cell.hospitalLabel.text = hospitalStr;
            }
            break;
            
            case 1:{
                
                NSString *cellIdentifier = @"basicCell2";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                
                NSString *tagName =self.params[@"specialty_tags_name"];
                NSString *diseaseStr = [tagName stringByReplacingOccurrencesOfString:@"\r\n" withString:@"、"];
                
                if ([diseaseStr isEqualToString:@""] || diseaseStr == nil) {
                    diseaseStr = @"请选择";
                }
                
                cell.diseaseTagesLabel.text = diseaseStr;
            }
            break;
            
            case 2:{
                
                NSString *cellIdentifier = @"basicCell3";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                //            if ([self.status isEqualToString:@"1"]) {
                //                [cell.detailsTextView setEditable:NO];
                //            }
                
                id detailsStr = self.params[@"member_service"];
                
                if (![detailsStr isEqualToString:@""] && detailsStr != nil) {
                    
                    cell.detailsTextView.text = detailsStr;
                    cell.detailsPlaceHolder.hidden = YES;
                }
                //            cell.detailsTextView.text = self.params[@"member_service"];
                cell.detailsTextView.delegate = self;
                cell.detailsTextView.tag = indexPath.section;
                
                self.detailsPlaceHolder = cell.detailsPlaceHolder;
            }
            break;
            
            case 3:{
                
                NSString *cellIdentifier = @"basicCell4";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                id personStr = self.params[@"member_Personal"];
                if (![personStr isEqualToString:@""] && personStr != nil) {
                    
                    cell.personTextView.text = personStr;
                    cell.personPlaceHolder.hidden = YES;
                }
                cell.personTextView.delegate = self;
                cell.personTextView.tag = indexPath.section;
                
                self.personPlaceHolder = cell.personPlaceHolder;
            }
            break;
            
        default:{
            
            NSInteger index = indexPath.section-4;
            
            Doctor_timeModel * model = [Doctor_timeModel getModelWithIndex:index modelArr:self.doctor_timeArray];
            
            NSString *cellIdentifier = @"basicCell5";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            cell.endBtn.tag = index;
            cell.startBtn.tag = index;
            cell.jiahaoBtn.tag = index;
            cell.jianhaoBtn.tag = index;
            cell.contentTF.tag = index;
            [cell.contentTF addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
            [cell.startBtn setTitle:[model getWeekStr] forState:UIControlStateNormal];
            [cell.endBtn setTitle:[model getPeriodStr] forState:UIControlStateNormal];
            
            
            cell.contentTF.text = [model getHospitalAndKs];
            
            
            [cell.startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.endBtn addTarget:self action:@selector(endBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.jiahaoBtn addTarget:self action:@selector(jiahaoClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell.jianhaoBtn addTarget:self action:@selector(jianhaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [model hiddenIndex:index addBtn:cell.jiahaoBtn jianHaoBtn:cell.jianhaoBtn arrCount:self.doctor_timeArray.count];
        }
    }
    return cell ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            case 0:{
                return 44;
            }
            break;
            case 1:
        {
            NSString *text=self.params[@"specialty_tags_name"];
            NSString *diseaseStr = [text stringByReplacingOccurrencesOfString:@"\r\n" withString:@"、"];
            CGFloat height =  [diseaseStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 105, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height+20;
            
            if ([NSString isEmpty:text]||height<44) {
                return 44;
            }else{
                return height;
            }
        }
            break;
            
            case 2:
        {
            return 80;
        }
            break;
            
            case 3:{
                return 110;
            }
            break;
            
        default:
            return 90;
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0){
        YMHospitalListViewController *vc = [YMHospitalListViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1){
        MYTDiseaseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTDiseaseViewController"];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self panfunction];
}

#pragma mark - YMHospitalListViewControllerDelegate
-(void)hospitalList:(YMHospitalListViewController *)hospitalList hospitalModel:(YMHospitalModel *)hospitalModel{
    
    self.model = hospitalModel;
    self.params[@"member_occupation_name"] = hospitalModel.hospital_name;
    self.params[@"member_occupation"] = hospitalModel.hospital_id;
    [self.tableView reloadData];
}

//星期
-(void)startBtnClick:(UIButton *)sender{
    [self panfunction];
    self.flag = 1;
    self.jieShouBtn = sender;
    self.pickerView.dataList = self.weekArr;
    [self.pickerView open];
    
}

//上午下午
-(void)endBtnClick:(UIButton *)sender{
    [self panfunction];
    self.flag = 2;
    
    self.jieShouBtn = sender;
    self.pickerView.dataList = self.periodArr;
    [self.pickerView open];
}

-(void)jiahaoClick:(UIButton *)sender{
    [self panfunction];
    [Doctor_timeModel addModelWithMutArr:self.doctor_timeArray];
    [self.tableView reloadData];
}

-(void)jianhaoBtnClick:(UIButton *)sender{
    [self panfunction];
    [Doctor_timeModel jianHaoModelWithMutArr:self.doctor_timeArray index:sender.tag];
    
    [self.tableView reloadData];
}

#pragma mark -  UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.selectedTextView = textView;
    
    if (self.selectedTextView.tag == 2) {
        
        self.params[@"member_service"] = self.selectedTextView.text;
        
        if (self.selectedTextView.text.length == 0) {
            
            self.detailsPlaceHolder.hidden = NO ;
        }
        
        
    }else if (self.selectedTextView.tag == 3){
        
        self.params[@"member_Personal"] = self.selectedTextView.text;
        
        if (self.selectedTextView.text.length == 0) {
            
            self.personPlaceHolder.hidden = NO;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    self.selectedTextView = textView;
    
    if (self.selectedTextView.tag == 2) {
        
        self.params[@"member_service"] = self.selectedTextView.text;
        
    }else if (self.selectedTextView.tag == 3){
        
        self.params[@"member_Personal"] = self.selectedTextView.text;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.detailsPlaceHolder.hidden = YES ;
    self.personPlaceHolder.hidden = YES;
    
    return YES ;
}


#pragma mark -  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES ;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //    params[@"title"] = textField.text ;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)receiveNotificiation:(NSNotification*)sender{
    
    ClickType type = [[sender.userInfo objectForKey:@"type"] integerValue];
    switch (type) {
            case ClickHospitalType:{
                YMHospitalListViewController *vc = [YMHospitalListViewController new];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            break;
            case ClickDiseaseType:{
                MYTDiseaseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTDiseaseViewController"];
                vc.delegate = self;;
                [self.navigationController pushViewController:vc animated:YES];
            }
        default:
            break;
    }
    
}

#pragma mark - MYTDiseaseViewControllerDelegate

-(void)diseaseViewController:(MYTDiseaseViewController *)diseaseView selectDiseaseArry:(NSArray *)selectDiseaseArry{
    _selectDiseaseArry = [selectDiseaseArry copy];
    for (NSDictionary *dic in _selectDiseaseArry) {
        if ([NSString isEmpty:_specialty_tags]) {
            self.params[@"specialty_tags_name"] = [NSString stringWithFormat:@"%@",dic[@"ename"]];
            _specialty_tags = [NSString stringWithFormat:@"%@",dic[@"disorder"]];
        }else{
            self.params[@"specialty_tags_name"] = [NSString stringWithFormat:@"%@,%@",self.params[@"specialty_tags_name"],dic[@"ename"]];
            _specialty_tags = [NSString stringWithFormat:@"%@,%@",_specialty_tags,dic[@"disorder"]];
        }
    }
    [_tableView reloadData];
}

#pragma mark -dismis
- (void)navBackAction
{
    UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)valueChanged:(UITextField *)textField{
    NSString *hosName = textField.text;
    Doctor_timeModel *model  = _doctor_timeArray[textField.tag];
    model.hospital = hosName;
}

@end
