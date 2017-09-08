//
//  PersonalViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonTableViewCell.h"
#import "TableHeadView.h"
#import "SetViewController.h"
#import "PersonDescriptViewController.h"

#import "SharePlatView.h"

#import "PersonViewModel.h"
#import <objc/runtime.h>
#import <UShareUI/UShareUI.h>
#import "Share.h"

#import "MYTPersonDataViewController.h"
#import "MYTCertificationViewController.h"
#import "MYTQualificationAuditViewController.h"
#import "NetWorkTool.h"


#import "HealthyHelperViewController.h"


#import "ShareView.h"
#import <UIImageView+WebCache.h>

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PersonViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)TableHeadView *headeView ;
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,strong)PersonViewModel *viewModel ;

@property (nonatomic, strong)NSArray *contentArr;

@property (nonatomic,copy) NSString * complete_status;

@property (nonatomic, strong)ShareView *shareView;

@property (nonatomic, strong)SharePlatView *sharePlatView;

@property (nonatomic,assign) NSUInteger indexSelect;

@end


static NSString *PersonTableViewCellIdentifier = @"PersonTableViewCellIdentifier";

@implementation PersonalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO ;
    self.tabBarController.tabBar.hidden = NO ;
    if ([self getMember_id]) {
        
        [self.viewModel personalInfoRequestWithParmas:@{@"member_id":[self getMember_id]} andCommpleteBlock:^(id model) {
            
            NSLog(@"model=========%@",model);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_headeView setPersonValue:model];
            });
            
        }];
    }
    
    [NetWorkTool GetComplete_statusFromPersonDataWithView:self.view complateHandle:^(NSString *complete_status, NSString *error) {
        if ([complete_status isEqualToString:@""]) {
            
        }else{
            
            self.complete_status = complete_status;
            
            NSLog(@"complete_status--------------%@",self.complete_status);
        }
    }];
}

-(void)setComplete_status:(NSString *)complete_status{
    _complete_status = complete_status;
    
    if ([_complete_status isEqualToString:@"1"]) {
        
        [self.headeView setStyleByIndex:0];
        
    }else if ([_complete_status isEqualToString:@"2"]){
        
        [self.headeView setStyleByIndex:1];
        
    }else if ([_complete_status isEqualToString:@"10"]){
        
         [self.headeView setStyleByIndex:1];
        
    }else if ([_complete_status isEqualToString:@"30"]){
        
         [self.headeView setStyleByIndex:1];
        
    }else if ([_complete_status isEqualToString:@"40"]){
        
         [self.headeView setStyleByIndex:2];
        
    }else if ([_complete_status isEqualToString:@"5"]){
        
         [self.headeView setStyleByIndex:3]; 
    }
    
    //测试
//     [self.headeView setStyleByIndex:3];
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"个人中心";
    self.navigationItem.leftBarButtonItem = nil;

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self createRightBarButtonItem];
    
    NSArray *section1Arr = [NSArray arrayWithObjects:@"账户信息",@"资质管理", nil];
    NSArray *section2Arr = [NSArray arrayWithObjects:@"健康助手", nil];
    NSArray *section3Arr = [NSArray arrayWithObjects:@"推荐给朋友",@"帮助中心", nil];
    self.contentArr = [NSArray arrayWithObjects:section1Arr, section2Arr, section3Arr, nil];
    
    [self setup];
}

- (void)createRightBarButtonItem{
    
    // 自定义导航栏右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width-46, 2, 44, 40);
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];

    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    [rightBtn addTarget:self action:@selector(onRightTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


// 右侧导航栏点击事件处理
- (void)onRightTap {
    NSLog(@"点击了导航栏右侧按钮");
    
    SetViewController *vc = [[UIStoryboard storyboardWithName:@"SettingStoryBoard" bundle:nil]instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}


- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
        _viewModel.delegate = self ;
    }
    return _viewModel ;
}


- (void)viewDidLayoutSubviews {
    
    if ([_complete_status isEqualToString:@"5"]) {
        self.headeView.frame = CGRectMake(0, 0, WIDTH, 145);
    }else{
        self.headeView.frame = CGRectMake(0, 0, WIDTH, 250);
    }
    [self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO ;
}

- (void)setup {
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.headeView = [[[NSBundle mainBundle]
                    loadNibNamed:@"TableHeadView" owner:self options:nil]firstObject];
    self.headeView.frame = CGRectMake(0, 0, WIDTH, 250);
    
    [self.headeView.improveBtn addTarget:self action:@selector(improveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headeView.arrowBtn addTarget:self action:@selector(arrowBtnClick) forControlEvents:UIControlEventTouchUpInside];

    self.tableView.tableHeaderView = self.headeView;
    [_tableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PersonTableViewCellIdentifier];
    __weak typeof(self)weakSelf = self ;
    _headeView.block = ^(UIImageView *sender) {
        [weakSelf  didClickChoicePicture:nil];
        objc_setAssociatedObject(weakSelf, "headViewBtn", sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    };
}

-(void)improveBtnClick{
    UIViewController * pushVC;
    
    switch (self.headeView.currentIndex) {
        case 0:
        {
            //实名认证
            self.hidesBottomBarWhenPushed = YES;
           // pushVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCertificationViewController"];
            MYTCertificationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCertificationViewController"];
            vc.status = @"0";
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1:
        {
 //            资质提交
            self.hidesBottomBarWhenPushed = YES;
            if ([self.complete_status isEqualToString:@"10"]) {
                //资料审核
                MYTQualificationAuditViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"MYTQualificationAuditViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else{
                 pushVC = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
            }

        }
            break;
        case 2:
        {
//            基本信息
             self.hidesBottomBarWhenPushed = YES;
            pushVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTBasicInformationViewController"];
        }
        default:
    
            break;
    }
    //个人资料
   // MYTPersonDataViewController *personVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTPersonDataViewController"];
    if (pushVC) {
         [self.navigationController pushViewController:pushVC animated:YES];
         self.hidesBottomBarWhenPushed = NO;
    }
}

-(void)arrowBtnClick{
    //个人资料
    MYTPersonDataViewController *personVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTPersonDataViewController"];
    [self.navigationController pushViewController:personVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.headImageView.image = [UIImage imageNamed:self.contentArr[indexPath.section][indexPath.row]];
    cell.nameLabel.text = self.contentArr[indexPath.section][indexPath.row];
    
    return cell ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:{
            
            switch (indexPath.row) {
                    
                case 0:{
                    
                    //账户信息
//                    [self MYTPersonPushNextPageWithStoryboardID:@"MYTAccountInfoViewController"];
                    
                    [self performSegueWithIdentifier:@"intoAccountInfoIdentifier" sender:nil];
                }
                    break;
                    
                case 1:{
                    
                    if ([_complete_status isEqualToString:@"40"] || [_complete_status isEqualToString:@"5"]){
                    
                    //资质管理
                    [self MYTPersonPushNextPageWithStoryboardID:@"MYTQualificationManageViewController"];
                    }
                    else{
                        
                        [self alertViewShow:@"资质审核还未通过，暂不能进行此操作"];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:{
            
            //健康助手
          
//            self.hidesBottomBarWhenPushed = YES;
//            HealthyHelperViewController *healthyHelperVC = [[HealthyHelperViewController alloc]init];
//            [self.navigationController pushViewController:healthyHelperVC animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
             [self alertViewShow:@"该功能正在建设中！ "];
        }
            break;
            
        case 2:{
            
            switch (indexPath.row) {
                    
                case 0:{
                    
                    //推荐给朋友
//                    [self MYTPersonPushNextPageWithStoryboardID:@"MYTRecommendToFriendsViewController"];
                    
                    [self showShareView];
                }
                    break;
                    
                case 1:{
                    
                    //帮助中心
                    [self MYTPersonPushNextPageWithStoryboardID:@"MYTHelpCenterViewController"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)showShareView{

    //弹出分享菜单
     if (self.shareView == nil) {
         ShareView *view = [ShareView initWithXib];
         [view.userShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
         view.userShare.tag == 100;
         [view.doctorShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
         view.doctorShare.tag == 200;
         self.shareView = view;
     }
     [self.shareView show];
}

-(void)shareClick:(UIButton *)sender{
    
    self.indexSelect = sender.tag;
    
    [self.shareView miss];
    
    [self requestDataWithView:self.view];
}

#pragma mark - 从个人页面跳到下一个页面
-(void)MYTPersonPushNextPageWithStoryboardID:(NSString *)storyboardID {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:storyboardID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)operateFailure:(NSString *)failureReason {
    
    [self alertViewShow:failureReason];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1 ;
    }else{
        return 2 ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {    
    return 0.01 ;
}

//个人中心   获取分享二维码
- (void)requestDataWithView:(UIView *)view{
    
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Person_Info_Url
                                                params:@{
     @"member_id":@([[self getMember_id] integerValue])
     }withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
         
         NSLog(@"showdata----------------%@",showdata);
         
         if (showdata == nil){
             return ;
         }
         
         SharePlatView *shareView = [SharePlatView sharePlatViewWithAnimation];
         [shareView showAnimation];
         
         self.sharePlatView = shareView;
         
         NSString *url;
         
         if (self.indexSelect == 100) {
             
             url = showdata[@"qrcode"];
             
         }else{
             
             url = showdata[@"qrcode_doctor"];
             
         }
        // [self.sharePlatView.shareImageView sd_setImageWithURL:[NSURL URLWithString:url]];
         
         shareView.shareBlock = ^(UMSocialPlatformType platform,ShareType type){
             
         NSString *url;
        Share *share = [Share new];
         if (self.indexSelect == 100) {
             
             url =  @"http://weixin.ys9958.com/index.php/Wap/Invite/InviteUser";
           [share shareWebPageToPlatformType:platform shareUrl:url shareConnet:@"用鸣医通,轻松解决挂专家号难的烦恼,我在用,你不要犹豫哦!"];
         }else{
             
             url = @"http://weixin.ys9958.com/index.php/Wap/Invite/DoctorSharing";
            [share shareWebPageToPlatformType:platform shareUrl:url shareConnet:@"开启自由执业,成都私人医生,尽在鸣医通,我们期待您的加入!"];
         }
             
       
         //NSString *urlStr = @"http://weixin.ys9958.com/index.php/Wap/Invite/DoctorSharing";
       
     };
         [self.tableView reloadData];
     }];
}
//-(void)createAlertVC
//{
//    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:nil message:@"该功能正在建设中" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//       
//    }];
//    [alertVC addAction:action3];
//    [self presentViewController:alertVC animated:YES completion:nil];
//
//
//}



- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender{
    
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
    handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
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
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)takePicture:(UIButton *)sender {
    
    if ([ UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera ;
        controller.delegate = self ;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

//上传头像
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
    objc_setAssociatedObject(self, "imageKey",image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSArray *images = @[@{@"data":data,
            @"name":@"member_avatar"}];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    dispatch_async(dispatch_queue_create("uploadImage", DISPATCH_QUEUE_SERIAL), ^{
        [self.viewModel uploadAvatarWithImages:images
                            andParamas:dic
                                       andView:self.tabBarController.view];
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)operateSuccess:(NSString *)successTitle {
    
    //上传成功
    id value  = objc_getAssociatedObject(self, "headViewBtn");
    id image = objc_getAssociatedObject(self, "imageKey");
    if ([value isKindOfClass:[UIImageView class]]){
        UIImageView *btn = (UIImageView *)value;
        btn.image = image ;
        [self alertViewShow:@"头像修改成功"];
    }
}

@end
