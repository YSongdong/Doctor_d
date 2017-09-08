//
//  CertificationViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CertificationViewController.h"
#import "CertificationTableViewCell.h"
#import "ChoiceView.h"
#import <objc/runtime.h>
#import "AddressPickerView.h"
#import "PersonViewModel.h"

@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource,CertificationTableViewCellDelegate,ListViewDelegate,AddressPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)NSMutableDictionary *params ;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)PersonViewModel *viewModel ;

@property (nonatomic,strong)DemandModel *model ;


@property (nonatomic, strong) ChoiceView *choice;


@end


const void *listViewContext = "listViewContext" ;
const void *imageBtnContext = "firstImageBtn";
@implementation CertificationViewController


- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
}


- (NSMutableDictionary *)params {
    
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 10 ;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    [self addRightButton];
    [self.rightButton setTitle:@"下一步"];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     if (!self.isAuthen) {
        return ;
    }
    if ([self getStore_id]) {
        [dic setObject:[self getStore_id] forKey:@"store_id"];
        
        dispatch_async(dispatch_queue_create("request.comm", DISPATCH_QUEUE_SERIAL), ^{
            [self.viewModel requestDoctorAuthenInfoWithParams:dic
                                                       andUrl:Certification_Info_Url
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
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}
    
- (void)rightButtonClickOperation {

    CertificationTableViewCell *cell =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (!cell.writeTextField.text || cell.writeTextField.text.length == 0) {
        [self alertViewShow:@"请输入你的真实名字"];
        return ;
    }else{
        [self.params setObject:cell.writeTextField.text forKey:@"authentication_name"];
    }
    CertificationTableViewCell *cell1 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (cell1.choiceLabel.text == nil || [cell1.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择你的性别"];
        return ;
    }
    CertificationTableViewCell *cell2 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (cell2.choiceLabel.text == nil || [cell2.choiceLabel.text isEqualToString:@"必选"]) {
        [self alertViewShow:@"请选择你的出身日期"];
        return;
    }
    
     CertificationTableViewCell *cell3 =(CertificationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (!cell3.writeTextField.text || cell3.writeTextField.text.length == 0) {
        
        [self alertViewShow:@"请输入身份证码号"];
        return ;
    }else {
        [self.params setObject:cell3.writeTextField.text forKey:@"authentication_sid"];
    }
    [self.params setObject:[self getMember_id] forKey:@"member_id"];
    [self performSegueWithIdentifier:@"qulificationIdentifier" sender:self.params] ;
}

- (void)didClickWithPoint:(CGPoint)point
                  andView:(CertificationTableViewCell *)view {
    if (self.choice) {
        self.choice = nil;
        [self.choice removeFromSuperview];
    } else {
    CGPoint endPoint = [view convertPoint:point toView:self.tableView];
        [self.view endEditing:YES];

    ChoiceView *listView = [[ChoiceView alloc]init];
    self.choice = listView;
    listView.delegate = self ;
    listView.dataList = @[@{@"name":@"男",
                            @"id":@"1"},
                         @{@"name":@"女",
                           @"id":@"2"}];
    objc_setAssociatedObject(self, listViewContext, listView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    __weak typeof(self)weakSelf = self ;
    [self.tableView addSubview:listView];
    [listView showWithPoint:endPoint];
    listView.block = ^(OperateWays type,
                       id dic){
        view.choiceLabel.text = dic[@"name"];
        [weakSelf.params setObject:dic[@"id"] forKey:@"authentication_sex"];
    };
  }
}
- (void)didClickChoiceTimeView:(CertificationTableViewCell *)view andType:(Celltype)type{
    
    [self.view endEditing:YES];
    AddressPickerView *picker = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio()) andType:pickerViewTypeDate];
    
    //先选择小时间  再选择大时间
    picker.block = ^(NSDictionary *dateString) {
    view.choiceLabel.text =dateString[@"time"] ;
        if (type == cellTypeBirthDay) {
            [self.params setObject:dateString[@"time"] forKey:@"authentication_age"];
        }else if (type == cellTypeIdCardValidData) {
            [self.params setObject:dateString[@"time"] forKey:@"effective"];
        }
    };
    [picker open];
}

- (void)didClickChoiceValidateTimeView:(CertificationTableViewCell *)view {
    
    AddressPickerView *picker = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200 *VerticalRatio())];
    picker.block = ^(NSDictionary *dateString) {
        if (view.type == cellTypeIdCardValidData) {
            view.validStartTime.text = [NSString stringWithFormat:@"%@ ⎯",dateString[@"time"]] ;
        }
    };
    [picker open];
}

//拍照
- (void)didClickChoicePicture:(UIButton *)sender {
    
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:nil message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"选取照片"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                       [self takePhoto:sender];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self takePicture:sender];
}];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    [controll addAction:action];
    [controll addAction:action2];
    [controll addAction:action3];
    [self presentViewController:controll animated:YES completion:nil];
}
- (void)takePhoto:(UIButton *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
        controller.allowsEditing = YES ;

        controller.delegate = self ;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
          objc_setAssociatedObject(controller, imageBtnContext, sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)takePicture:(UIButton *)sender {
    
    if ([ UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera ;
        controller.delegate = self ;
            
        [self presentViewController:controller animated:YES completion:nil];
        objc_setAssociatedObject(controller, imageBtnContext, sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}



-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    id value = objc_getAssociatedObject(picker, imageBtnContext);
    if ([value isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)value ;
        [btn setImage:image forState:UIControlStateNormal];
        if(btn.tag == 1001){
            [self.params setObject:image forKey:@"picture1"];
            
        }else if(btn.tag == 1002) {
            [self.params setObject:image forKey:@"picture2"];
            }
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)getTime:(NSString *)time {
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    
    id value = objc_getAssociatedObject(self, listViewContext);
    if (value) {
        if ([value isKindOfClass:[ChoiceView class]]) {
            ChoiceView *view = (ChoiceView *)value ;
            [view hidenSelfWithEndPoint];
        }
    }
}
- (void)didClickWithDifferentWays:(OperateWays)ways {
    
    if (ways == genderType) {
        
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
 
    if (section == 1 ) {
        return 2 ;
    }
    return 1 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    
}- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificationTableViewCell *cell ;
    cell.validStartTime.hidden = YES ;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustWrite"];
        cell.writeTitleLabel.text = @"个人姓名";
        cell.writeTextField.text = self.model.authentication_name ;
    }
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustChoiceIdentifier"];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"性别";
            cell.choiceLabel.text = self.model.authentication_sex ;
            cell.type = cellTypeGender ;
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"出生日期";
            cell.type = cellTypeBirthDay ;
            cell.choiceLabel.text = self.model.authentication_age ;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
             cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCellMustWrite"];
            NSLog(@"%@",cell);
            cell.writeTitleLabel.text = @"身份证号";
            cell.type = cellTypeIDCard ;
            cell.writeTextField.placeholder = @"请输入18位身份证号";
            cell.writeTextField.text = self.model.authentication_sid ;
        }
    }
    cell.delegate = self ;
    return  cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 ;
}

- (CGFloat)tableView:(UITableView *)tableView
   heightForHeaderInSection:(NSInteger)section {
    
    if (section== 0) {
        return 10;
    }
    return 0.00001f ;
}



@end
