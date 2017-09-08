//
//  QualificationViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "QualificationViewController.h"
#import "CertificationTableViewCell.h"
#import "PersonViewModel.h"
#import "DepartmentsView.h"
#import "ChoiceView.h"
#import "AddressPickerView.h"
#import "ReviewViewController.h"
#import "MYTQualificationAuditViewController.h"

@interface QualificationViewController ()<UITableViewDelegate,UITableViewDataSource,CertificationTableViewCellDelegate,ListViewDelegate,PersonViewModelDelegate>

@property (nonatomic,strong)PersonViewModel *viewModel ;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *hospitals ;
@property (nonatomic,strong)NSArray *departments;
@property (nonatomic,strong)ChoiceView *choiceView ;
@property (nonatomic,strong)NSArray *doctorQualitys ;
@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic,strong)DepartmentsView *departView ;

@end

@implementation QualificationViewController

-(void)dealloc {
    
    [_viewModel removeObserver:self forKeyPath:@"hospitals"];
    [_viewModel removeObserver:self forKeyPath:@"departments"];
    [_viewModel removeObserver:self forKeyPath:@"doctorQulifications"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 10 ;
    
    [self addRightButton];
    [self.rightButton setTitle:@"提交"];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(nextClick)];

    [self requestDataWithView:self.view];
    
    [self setup];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    [self.view addGestureRecognizer:pan];
}

-(void)panfunction:(UIGestureRecognizer*)pan{
    [self.view  endEditing:YES];
}


-(void)nextClick{
    
    [self loadDataWithView:self.view];
    
    if ([self.status isEqualToString:@"40"]) {
        
        [self alertViewShow:@"已认证信息如需修改请联系客服"];
    }
}

//资质提交  提交
- (void)loadDataWithView:(UIView *)view{
    
    self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    
    self.params[@"accession"] = self.params[@"accession"];
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Qualification_Save
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata----------------%@",showdata);
        
        if (showdata == nil){
            return ;
        }
        [self.tableView reloadData];

    }];
}


//资质提交  查看
- (void)requestDataWithView:(UIView *)view{
    
    NSLog(@"Member_id---------------%@",[self getMember_id]);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Qualification_URL
    params:@{ @"member_id":@([[self getMember_id] integerValue])}withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                 
     NSLog(@"showdata----------------%@",showdata);
     
     if (showdata == nil){
         return ;
     }
      
    //把不可变的字典变成可变的
    [self.params setValuesForKeysWithDictionary:showdata];
         
    [self.tableView reloadData];
    }];
}


- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}

- (PersonViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
        _viewModel.delegate = self ;
    }
    return _viewModel ;
}

- (void)setup {
    
    [self.viewModel addObserver:self forKeyPath:@"hospitals" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel addObserver:self forKeyPath:@"departments" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.viewModel addObserver:self forKeyPath:@"doctorQulifications" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel getDepartmentAndhospitalList];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    if (![self getStore_id]){
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.hidesBottomBarWhenPushed = YES ;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getStore_id]) {
        [dic setObject:[self getStore_id] forKey:@"store_id"];
    }
    if (!self.isAuthen) {
        return ;
    }
    dispatch_async(dispatch_queue_create("request.comm", DISPATCH_QUEUE_SERIAL), ^{
        [self.viewModel  requestDoctorAuthenInfoWithParams:dic
                    andUrl:Authen_Info_URL
         andCommpleteBlock:^(id value) {
        
             dispatch_async(dispatch_get_main_queue(), ^{
                 if ([value isKindOfClass:[DemandModel class]]) {
                     self.model = value ;
                     [self.tableView reloadData];
                     self.tableView.userInteractionEnabled =NO ;
                     [self.rightButton setTitle:@""];
                     self.rightButton.enabled = NO ;
                 }
                 else {
                     [self alertViewShow:value];
                 }
            });
        }];
    });
}

//提交
- (void)rightButtonClickOperation {
    
    if ([self.status isEqualToString:@"40"]) {
        
        [self alertViewShow:@"已认证信息如需修改请联系客服"];
        return;
    }
    
    CertificationTableViewCell *cell =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    if (!cell.choiceLabel.text ||
        [cell.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择就职医院"];
        return ;
    }
    
    CertificationTableViewCell *cell1 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell1.choiceLabel.text == nil || [cell1.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择科室"];
        return ;
    }
    
    CertificationTableViewCell *cell2 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (cell2.choiceLabel.text == nil || [cell2.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择医生资质"];
        return;
    }

    CertificationTableViewCell *cell3 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (!cell3.choiceLabel.text ||
        [cell3.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择学历"];
        return ;
    }
    
    CertificationTableViewCell *cell4 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (cell4.writeTextField.text == nil || cell4.writeTextField.text.length == 0) {
        
        [self alertViewShow:@"请输入职业证书编号"];
        
        return ;
    }else {
        
        [self.params setObject:cell4.writeTextField.text
                        forKey:@"certificate_zy"];
    }
    CertificationTableViewCell *cell5 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    if (cell5.writeTextField.text == nil || cell5.writeTextField.text.length == 0) {
        [self alertViewShow:@"请输入职业证书编号"];
        return ;
    }
    else {
        [self.params setObject:cell5.writeTextField.text forKey:@"certificate_zg"];
    }
    
    [self loadDataWithView:self.view];
    
    [self.params setObject:[self getMember_id] forKey:@"member_id"];
    
    NSMutableDictionary *dic = [self.params mutableCopy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.viewModel saveCetertificationWithParams:dic andView:self.view complateHandle:^(id showdata, NSString *error) {
            
            MYTQualificationAuditViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"MYTQualificationAuditViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    });
}

- (void)operateFailure:(NSString *)failureReason {
    
    [self alertViewShow:failureReason];
}

- (void)uploadSucess {
    
    [self performSegueWithIdentifier:@"reviewControllerIdentifier" sender:nil];
}

-(void)operateSuccess:(NSString *)successTitle {
    [self alertViewShow:successTitle];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 2 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CertificationTableViewCell *cell ;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustChoiceIdentifier"];
            cell.titleLabel.text = @"就职医院:";
            cell.type = cellTypeHospital ;
//            if (self.model.accession) {
//                cell.choiceLabel.text = self.model.accession ;
//            }
            
            NSString *hospital_nameStr = self.params[@"hospital_name"];
            if ([hospital_nameStr isEqualToString:@""] || hospital_nameStr == nil) {
                hospital_nameStr = @"请选择";
            }
            cell.choiceLabel.text = hospital_nameStr;
                                          
        }
        if (indexPath.row == 1) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustChoiceIdentifier"];
            cell.titleLabel.text = @"科室:";
            cell.type = cellTypeDepartMent;
//            if (self.model.authentication_ks) {
//                cell.choiceLabel.text = self.model.authentication_ks ;
//            }
            
            NSString *authentication_ks_nameStr = self.params[@"authentication_ks_name"];
            if ([authentication_ks_nameStr isEqualToString:@""] || authentication_ks_nameStr == nil) {
                authentication_ks_nameStr = @"请选择";
            }
            cell.choiceLabel.text = authentication_ks_nameStr;

    }
}
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustChoiceIdentifier"];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"医师资质:";
            cell.type = cellTypeQualification ;
//            if (self.model.member_aptitude) {
//                cell.choiceLabel.text = self.model.member_aptitude ;
//            }
            
            NSString *member_aptitude_nameStr = self.params[@"member_aptitude_name"];
            if ([member_aptitude_nameStr isEqualToString:@""] || member_aptitude_nameStr == nil) {
                member_aptitude_nameStr = @"请选择";
            }
            cell.choiceLabel.text = member_aptitude_nameStr;
            
        }
        if (indexPath.row ==1) {
            cell.titleLabel.text = @"最高学历:";
            cell.type = cellTypeHightestEducational ;
            cell.choiceLabel.text = self.model.authentication_education;
            
            NSString *authentication_education_nameStr = self.params[@"authentication_education_name"];
            if ([authentication_education_nameStr isEqualToString:@""] || authentication_education_nameStr == nil) {
                authentication_education_nameStr = @"请选择";
            }
            cell.choiceLabel.text = authentication_education_nameStr;
        }
    }
        
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustWrite"];
        
        if ([self.status isEqualToString:@"40"]) {
            [cell.writeTextField setEnabled:NO];
        }

        if (indexPath.row == 0) {
            cell.writeTitleLabel.text = @"执业证书编号:";
            cell.writeTextField.keyboardType = UIKeyboardTypeNumberPad ;
            cell.writeTextField.text = self.model.certificate_zy ;
            
            cell.writeTextField.text = self.params[@"certificate_zy"];
        }
        else if (indexPath.row == 1){
            cell.writeTitleLabel.text = @"资格证书编号:";
            cell.writeTextField.text = self.model.certificate_zg ;
            cell.writeTextField.keyboardType = UIKeyboardTypeNumberPad ;
            
            cell.writeTextField.text = self.params[@"certificate_zg"];
        }
    }
    cell.delegate = self ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section== 0) {
        return 10;
    }
    return 0.00001f ;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return @"温馨提示: 资质一旦绑定无法修改\n若要对资质进行修改，请前去“设置”联系客服";
    }
    return nil ;
}

#pragma mark----------- cellDelegate

//选择科室
- (void)didClickChoiceDepartmentWithView:(CertificationTableViewCell *)view {
    
    if ([self.status isEqualToString:@"40"]) {
        return;
    }

    if (!self.departments || [self.departments count] == 0) {
        [self alertViewShow:@"未获取到科室"];
        return ;
    }
    if (_departView && _departView.superview) {
        [_departView.superview removeFromSuperview];
        [_departView removeFromSuperview];
        _departView = nil;
    }
    DepartmentsView *depart = [DepartmentsView DepartmentsViewWithDic:self.departments];
    _departView = depart ;
    depart.viewOffsetX = 100 ;
    depart.start_y = CGRectGetMaxY(view.frame) ;
    self.tableView.scrollEnabled = NO ;
    [depart showOnSuperView:self.tableView subViewStartY:0];
    __weak typeof(self)weakSelf = self ;
    depart.block = ^(id dic,NSString *departID) {
        view.choiceLabel.text = dic[@"ename"];
        [weakSelf.params setObject:departID forKey:@"authentication_bm"];
        [weakSelf.params setObject:dic[@"disorder"] forKey:@"authentication_ks"];
    };
}

- (void)didClickWithPoint:(CGPoint)point
                  andView:(CertificationTableViewCell *)view {
    
    if ([self.status isEqualToString:@"40"]) {
        return;
    }
    
    if (_choiceView.superview) {
        [_choiceView removeFromSuperview];
        [_choiceView hidenSelfWithEndPoint] ;
    }
    CGPoint endPoint = [view convertPoint:point toView:self.tableView];
    ChoiceView *listView = [[ChoiceView alloc]init];
    listView.delegate = self ;
    _choiceView = listView ;
    listView.dataList = @[@{@"name":@"大学本科",
                            @"id":@"3"},
                          @{@"name":@"博士",
                            @"id":@"1"},
                          @{@"name":@"硕士",
                            @"id":@"2"},
                          @{ @"name":@"专科",
                             @"id":@"4"}];
   __weak typeof(self)weakSelf = self ;
    [self.tableView addSubview:listView];
    [listView showWithPoint:endPoint];
    listView.block = ^(OperateWays type,
                       id dic){
        
        view.choiceLabel.text = dic[@"name"];
       [weakSelf.params setObject:dic[@"id"]
                           forKey:@"authentication_education"];
    };
}

- (void)didClickChoiceValidateTimeView:(CertificationTableViewCell *)view {
    
    if ([self.status isEqualToString:@"40"]) {
        return;
    }

    NSLog(@"%@",view);
    
    AddressPickerView *pickView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio()) andType:pickViewTypeNormal];
    if (view.type == cellTypeHospital) {
        if (!self.hospitals || [self.hospitals count] == 0) {
            [self alertViewShow:@"暂时获取不到医院信息"];
            return ;
        }
        pickView.dataList = self.hospitals ;
    }
    else if (view.type == cellTypeQualification){
        if (!self.doctorQualitys || [self.doctorQualitys count] == 0) {
            [self alertViewShow:@"暂时获取不到数据"];
            return ;
        }
        pickView.dataList = self.doctorQualitys ;
    }
    
    pickView.block = ^(NSDictionary *address){
        
        if (view.type == cellTypeHospital) {
        [self.params setObject:address[@"hospital_id"] forKey:@"accession"];
            view.choiceLabel.text = address[@"name"];
            }else {
            view.choiceLabel.text = address[@"name"];
            [self.params setObject:address[@"disorder"]
                            forKey:@"member_aptitude"];
        }
    };
    [pickView open];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"departments"]) {
        self.departments = self.viewModel.departments ;
    }
    
    if ([keyPath isEqualToString:@"hospitals"]) {
        self.hospitals = self.viewModel.hospitals ;
    }
    
    if ([keyPath isEqualToString:@"doctorQulifications"]) {
        self.doctorQualitys = self.viewModel.doctorQulifications ;
    }
}

@end
