//
//  MYTQualificationManagementViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTQualificationManageViewController.h"
#import "MYTQualificationManageTableViewCell.h"
#import "PersonViewModel.h"

#import <UIButton+WebCache.h>

@interface MYTQualificationManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NSMutableDictionary *dic;

@property (strong, nonatomic) NSMutableDictionary *params;

@property (strong, nonatomic)UIButton *clickBtn;

@property (nonatomic,strong) NSMutableArray *fileImgArr;


@end

@implementation MYTQualificationManageViewController

-(NSMutableArray *)fileImgArr{
    if (_fileImgArr == nil) {
        _fileImgArr = [[NSMutableArray alloc]init];
    }
    return _fileImgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.dic = [NSMutableDictionary new];
    
    self.params = [NSMutableDictionary new];
    
    [self requestDataWithView:self.view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitClick)];
}

-(void)submitClick{
    
    [self loadDataWithView:self.view];
}

- (void)loadDataWithView:(UIView *)view{
    
    if ([self getMember_id]) {
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    
    self.params[@"zy_imgurl"] = self.dic[@"certificate_zy_img"];
    self.params[@"zg_imgurl"] = self.dic[@"certificate_zg_img"];
    
    NSLog(@"self.params----------------------%@",self.params);
    [[KRMainNetTool sharedKRMainNetTool] upLoadData:Authen_Info_SavequalifPic params:self.params andData:self.fileImgArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
                
        [self requestDataWithView:self.view];
        
        [self.tableView reloadData];
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Authen_Info_QualifPic
        params:@{@"member_id":@([[self getMember_id] integerValue])} withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata ======= %@",showdata);
        
        if (showdata == nil) {
            
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
           
            self.dic = showdata;
        }
            
        [self.tableView reloadData];
    }];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYTQualificationManageTableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        NSString *cellIdentifier = @"cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else {
        
        NSString *cellIdentifier = @"qualificationManageCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
       
        cell.nameLab.text = @"职称编号:";
        cell.numLab.text = self.dic[@"certificate_zy"];
        
        [cell.imageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.dic[@"certificate_zy_img"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
        
        [cell.imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.imageBtn.tag = indexPath.section;
        
    }else{
        
        cell.nameLab.text = @"资格证书编号:";
        cell.numLab.text = self.dic[@"certificate_zg"];
                
        [cell.imageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.dic[@"certificate_zg_img"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];

        [cell.imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.imageBtn.tag = indexPath.section;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float rowheight ;
    
    if (indexPath.row == 0) {
        
        rowheight = 44;
    }
    else {
        
        rowheight = 160;
    }
    return rowheight;
}

-(void)imageBtnClick:(UIButton *)sender{
    
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
   
    NSString * name ;
    if (self.clickBtn.tag==0) {
        name = @"certificate_zy_img";
    }else{
        name = @"certificate_zg_img";

    }
    NSDictionary * imgDict = @{
                               @"data":data,
                               @"name":name
                              };    
    
    [self.fileImgArr addObject: imgDict];
    
    [self.clickBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(NSString *)getImgName{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    int a =(int)[dat timeIntervalSince1970];
    
    
    NSString *timeString = [NSString stringWithFormat:@"%@_%d_jpg",[self getMember_id], a];
    return timeString;    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
