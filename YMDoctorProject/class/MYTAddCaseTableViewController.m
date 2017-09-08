//
//  MYTAddCaseViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/19.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIButton+WebCache.h>
#import "MJExtension.h"
#import "MYTAddCaseTableViewController.h"
#import "MYAddClassTableCell.h"
#import "PersonViewModel.h"
#import "Masonry.h"

#import "MYTCaseViewController.h"

@interface MYTAddCaseTableViewController ()

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *detailTimeBtn;

@property (nonatomic, strong) UIButton *fengMianBtn;
@property (nonatomic, strong) UIButton *detailImgBtn;

@property (nonatomic, strong) NSString *timeStr;

@property (nonatomic, strong) UIImageView *detailImageView;
@property (nonatomic, strong) UIImageView *fengMianImageView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (strong, nonatomic) UITextField *textF;

@end

@implementation MYTAddCaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [self makeDateView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.isEdit) {
        [self loadData];
    }

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick)];

    [self addObjToDataArray];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    [self.view addGestureRecognizer:pan];
}


-(void)panfunction:(UIGestureRecognizer*)pan{
    [self.view  endEditing:YES];
}


//编辑加载数据
-(void)loadData{
    
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:Case_Detail params:self.pushDict withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
       
        [self.params setValuesForKeysWithDictionary:showdata];
        
        [self.dataArray setArray:self.params[@"case_detail"]];
        
        NSMutableArray * temArr = [NSMutableArray new];
        for (NSDictionary * dict in self.dataArray) {
            NSMutableDictionary * mutDict = [NSMutableDictionary new];
            NSMutableArray * temArrImg = [NSMutableArray new];
            [temArrImg setArray:dict[@"d_imgs"]];
            
            [mutDict setValuesForKeysWithDictionary:dict];
            mutDict[@"d_imgs"] =  temArrImg;
            [temArr addObject:mutDict];
        }
        
        [self.dataArray setArray:temArr];
        
        [self.tableView reloadData];
    }];
}


-(void)addObjToDataArray{
    NSMutableDictionary * cellDict = [[NSMutableDictionary alloc]init];
    
    [self.dataArray addObject:cellDict];
}


//保存按钮点击
- (void)saveClick{
    
    //endEditing:结束编辑,键盘消失
    [self.view endEditing:YES];
    
    [self requestDataWithView:self.view];
}

//请求列表数据
- (void)requestDataWithView:(UIView *)view{
    
    self.params[@"case_detail"] = [self.dataArray mj_JSONString];
   
    if (self.pushDict) {
        
        //        标志编辑
        [self bianjiNetWorkWithView:view];
        
    }else{
        
        //        新增
        [self xinzengNetWorkWithView:view];
    }
}


//编辑
- (void)bianjiNetWorkWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:Case_Save params:self.params andData:self.fileImgArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"==%@",showdata);
        MYTCaseViewController *vc = self.navigationController.viewControllers[1];
        [vc requestListDataWithView:vc.view];
        
        [self.navigationController popToViewController:vc animated:YES];
    }];
}


//新增
- (void)xinzengNetWorkWithView:(UIView *)view{
    
    if([self getMember_id]){
        
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:Case_Save params:self.params andData:self.fileImgArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata----------------===========%@",showdata);
        MYTCaseViewController *vc = self.navigationController.viewControllers[1];
        [vc requestListDataWithView:vc.view];
        
        [self.navigationController popToViewController:vc animated:YES];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYAddClassTableCell *cell;
    if (indexPath.section == 0) {
        //案例标题
        cell = [tableView dequeueReusableCellWithIdentifier:@"MYAddClassTableCell1" forIndexPath:indexPath];
        cell.textField.tag = 0;
        
        if (self.isEdit) {
            cell.textField.text = self.params[@"case_title"];
        }
        
        self.textF = cell.textField;

    }else if(indexPath.section == 1){
        //案例时间
        cell = [tableView dequeueReusableCellWithIdentifier:@"MYAddClassTableCell2" forIndexPath:indexPath];
        [cell.timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.timeBtn.tag =indexPath.section;
        //        self.params[@"case_time"] = [dateformatter stringFromDate:date];
        
        if (self.isEdit) {
            [cell.timeBtn setTitle:self.params[@"case_time"] forState:UIControlStateNormal];
        }

    }else if(indexPath.section == 2){
        //案例简述
        cell = [tableView dequeueReusableCellWithIdentifier:@"MYAddClassTableCell1" forIndexPath:indexPath];
        cell.titleLab.text = @"案例简述";
        cell.textField.tag = 2;
        
        if (self.isEdit) {
           cell.textField.text = self.params[@"case_desc"];
        }
        
        self.textF = cell.textField;

    }else if(indexPath.section == 3){
        //案例封面
        cell = [tableView dequeueReusableCellWithIdentifier:@"MYAddClassTableCell3" forIndexPath:indexPath];
        [cell.fengMianBtn addTarget:self action:@selector(imageChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.fengMianBtn.tag =indexPath.section;
        if (self.isEdit) {
            
            [cell.fengMianBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.params[@"case_thumb"]] forState:UIControlStateNormal];
        }

    }else if(indexPath.section >= 4){
        //案例详情 这个是动态的 第一个
        cell = [tableView dequeueReusableCellWithIdentifier:@"MYAddClassTableCell4" forIndexPath:indexPath];
        [cell.addBtn addTarget:self action:@selector(addBtnclick) forControlEvents:UIControlEventTouchUpInside];
        cell.jianHaoBtn.tag = indexPath.section-4;
        [cell.jianHaoBtn addTarget:self action:@selector(jianHaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.jianHaoBtn.hidden = NO;
        cell.addBtn.hidden = YES;
        
        cell.modelDict = self.dataArray[indexPath.section-4];
        
        if (indexPath.section == 4 && self.dataArray.count == 1) {
            
            cell.jianHaoBtn.hidden = YES;
            cell.addBtn.hidden = NO;
        }
        if (indexPath.section == 4 && self.dataArray.count > 1) {
            
            cell.jianHaoBtn.hidden = YES;
            cell.addBtn.hidden = YES;
        }
        //  最后一个
        if (indexPath.section != 4 && indexPath.section == (4 + self.dataArray.count) - 1) {
            
            cell.addBtn.hidden = NO;
            cell.jianHaoBtn.hidden = NO;
        }
        
        [cell.detailTimeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.detailTimeBtn.tag = indexPath.section;
        
        [cell.detailImgBtn addTarget:self action:@selector(imageChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.detailImgBtn.tag = indexPath.section;
        
        
        if (self.isEdit) {
            cell.d_imgs = self.dataArray[indexPath.section-4
                                         ][@"d_imgs"];
            [cell.detailTimeBtn setTitle:self.dataArray[indexPath.section-4 ][@"d_time"] forState:UIControlStateNormal];
            
            cell.detailTextView.text = self.dataArray[indexPath.section-4 ][@"d_con"];
            
            if (cell.detailTextView.text.length == 0) {
                
                cell.placeHolderLab.hidden = NO ;
                
            }else{
                cell.placeHolderLab.hidden = YES ;

            }
        }
    }
    cell.vc = self;
    
    return cell;
}

//获得输入框的值
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES ;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4 + self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(void)jianHaoBtnClick:(UIButton*)btn{
    
    [self.dataArray removeObjectAtIndex:btn.tag];
    [self.tableView reloadData];
}

-(void)addBtnclick{
    
    [self addObjToDataArray];
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 2) {
        
        return 50;
    }
    if (indexPath.section == 2) {
        
        return UITableViewAutomaticDimension +50;
    }
    if (indexPath.section <= 3) {
        
        return 130;
    }
    return 210;
}

#pragma mark - 避免NavigationBar与cell之间的空隙
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001f;
}

-(void)timeBtnClick:(UIButton *)sender{
    
    self.timeBtn = sender;
    
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
        
        NSString * timeStr__ = [dateformatter stringFromDate:date];
        [self.timeBtn setTitle:timeStr__ forState:UIControlStateNormal];
        if (self.timeBtn.tag == 1) {
//            案例时间
            self.params[@"case_time"] = timeStr__;
            return;
        }
        
        NSMutableDictionary * dict = [self GetDictDataArrayWithIndex:self.timeBtn.tag];
        dict[@"d_time"] = timeStr__;
    }
}

-(NSMutableDictionary * )GetDictDataArrayWithIndex:(NSInteger)index{
    NSMutableDictionary * dict = nil;
    
    if (index >= 4) {
        
    dict  = self.dataArray[index-4];
    }
    
    return dict;
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
    
    [[self getKeWindow] addSubview:self.dateView];
}

-(UIWindow *)getKeWindow{
    
    return [UIApplication sharedApplication].keyWindow;
}

-(NSString *)getImgName{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    int a =(int)[dat timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%@_%d_jpg",[self getMember_id], a];
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
                               @"name":@"case_thumb"
                               };
    
    [self.fileImgArr addObject: imgDict];
    
    [self.fengMianBtn setBackgroundImage:image forState:UIControlStateNormal];
        
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageChooseBtnClick:(UIButton *)sender{
    
    self.fengMianBtn = sender;
    
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


-(NSMutableArray *)fileImgArr{
    if (_fileImgArr == nil) {
        _fileImgArr = [[NSMutableArray alloc]init];
    }
    return _fileImgArr;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary new];;
    }
    return _params;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
