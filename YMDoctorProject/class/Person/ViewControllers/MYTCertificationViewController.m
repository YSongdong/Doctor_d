//
//  MYTCertificationViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTCertificationViewController.h"
#import "UIButton+WebCache.h"

#import "MYTCertificationTableViewCell.h"

#import "QualificationViewController.h"
@interface MYTCertificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic)NSMutableDictionary *params;

@property (strong, nonatomic)UIButton *clickBtn;

@property (nonatomic,strong) NSMutableArray *fileImgArr;

@end

@implementation MYTCertificationViewController

-(NSMutableArray *)fileImgArr{
    if (_fileImgArr == nil) {
        _fileImgArr = [[NSMutableArray alloc]init];
    }
    return _fileImgArr;
}

-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary new];
        
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(nextClick)];
    
    [self requestDataWithView:self.view];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    [self.view addGestureRecognizer:pan];
}


-(void)panfunction:(UIGestureRecognizer*)pan{
    [self.view  endEditing:YES];
}

-(void)nextClick{
    
    if ([self.status isEqualToString:@"0"]) {
        
        [self loadDataWithView:self.view];
    }else{
        
        [self alertViewShow:@"已认证信息如需修改请联系客服"];
    }
}


//实名认证  提交
- (void)loadDataWithView:(UIView *)view{
    
    self.params[@"member_id"] = @([[self getMember_id] integerValue]);

    [[KRMainNetTool sharedKRMainNetTool] upLoadData:RealnameAuth_Save params:self.params andData:self.fileImgArr waitView:self.view complateHandle:^(id showdata, NSString *error){
         
         NSLog(@"showdata----------------%@",showdata);
         
         if (showdata == nil){
             return ;
         }
        
        [[NSUserDefaults standardUserDefaults]setObject:self.params[@"authentication_name"] forKey:@"realName"];
        
         [self.tableView reloadData];
        
        //资质提交
       UIViewController *vc =[[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
     }];
}

//实名认证  查看
- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:RealnameAuth_URL
    params:@{
             @"member_id":@([[self getMember_id] integerValue])
             }withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                 
                 NSLog(@"showdata----------------%@",showdata);

                 if (showdata == nil){
                     return ;
                 }
                 
                 [self.params setValuesForKeysWithDictionary:showdata];
                 
                 
                 [self.tableView reloadData];
             }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NSString *cellIdentifier = @"Certification1";
        MYTCertificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ([self.status isEqualToString:@"0"]) {
            [cell.headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.params[@"store_avatar"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"相机"]];
        return cell;
        
    }else if (indexPath.row == 1) {
        
        NSString *cellIdentifier = @"Certification2";
        MYTCertificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if ([self.status isEqualToString:@"1"]) {
            
            [cell.realNameTF setEnabled:NO];
        }
        cell.realNameTF.text = self.params[@"authentication_name"];
        
        cell.CallBack = ^(NSString *str, NSInteger index) {
            
            if (index == 0) {
//                真实姓名
            self.params[@"authentication_name"] = str;
                
            }
        };
        return cell;

    }else if (indexPath.row == 2) {
        
        NSString *cellIdentifier = @"Certification3";
        MYTCertificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        NSString *sexStr = self.params[@"authentication_sex"];
        if ([sexStr isEqualToString:@"1"]) {
            
            sexStr = @"男 ";
            
        }else if ([sexStr isEqualToString:@"2"]) {
            
            sexStr = @"女 ";
        }else{
            
            sexStr = @"请选择 ";
        }
        [cell.sexBtn setTitle:sexStr forState:UIControlStateNormal];
        
        if ([self.status isEqualToString:@"0"]) {
            
            [cell.sexBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        return cell;

    }else if (indexPath.row == 3) {
        
        NSString *cellIdentifier = @"Certification4";
        MYTCertificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ([self.status isEqualToString:@"1"]) {
            
            [cell.numberTF setEnabled:NO];
        }

        cell.numberTF.text = self.params[@"authentication_sid"];
        cell.CallBack = ^(NSString *str, NSInteger index) {
            
            if (index == 1) {
                
            //  身份证号
            self.params[@"authentication_sid"] = str;

            }
        };
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else{
        return 50;
    }
}


-(void)sexBtnClick:(UIButton *)sender{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请选择性别"
    message:nil
    preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        
        weakSelf.params[@"authentication_sex"] = @"1";
            [weakSelf.tableView reloadData];
        }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        weakSelf.params[@"authentication_sex"] = @"2";
        [weakSelf.tableView reloadData];

    }];
    
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)headBtnClick:(UIButton *)sender{
 
    self.clickBtn = sender;
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

//上传头像
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
    
    NSDictionary * imgDict = @{
                               @"data":data,
                               @"name":@"store_avatar"
                               };
    
    [self.fileImgArr addObject: imgDict];
    
    [self.clickBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
