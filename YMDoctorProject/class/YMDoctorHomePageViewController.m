//
//  YMDoctorHomePageViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorHomePageViewController.h"
#import "UIButton+LZCategory.h"
#import "YMDoctorCaseTableViewCell.h"
#import "YMDoctorHomePageHeaderTableViewCell.h"
//#import "YMGuyongDoctorViewController.h"
#import "YMDoctorDetailsModel.h"

#import "YMDoctorDetailsCaseModel.h"
#import "YMDoctorDetailsHonorModel.h"
#import "YMDoctorDetailsEvaluationModel.h"
#import "YMCaseDetailsViewController.h"

#import "YMDoctorFooterCollectionReusableView.h"

//#import "YMNewReservationDoctorViewController.h"
#import <UShareUI/UMSocialUIManager.h>
#import "ShareView.h"

static NSString *const CaseTableViewCell = @"CaseTableViewCell";
static NSString *const HomePageHeaderTableViewCell = @"HomePageHeaderTableViewCell";

@interface YMDoctorHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,YMDoctorHomePageHeaderTableViewCellDelegate,YMDoctorCaseTableViewCellDelegate>

@property(nonatomic,strong)UITableView *doctorHomePageTableView;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIView *doctorHeaderView;

@property(nonatomic,assign)BOOL detailsClick;// 点击：Yes 没点击：NO

@property(nonatomic,strong)YMDoctorDetailsModel *model;

@property(nonatomic,strong)NSMutableArray *interactionData;

@property(nonatomic,strong)UIButton *attentionButton;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableDictionary *caseParams;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsCaseModel *> *doctorCaseArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsHonorModel *> *doctorHonorArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsEvaluationModel *> *doctorEvaluationArry;

@property(nonatomic,assign)CaseNumber ClickCaseNumber;

@property(nonatomic,assign)NSInteger type;


@property(nonatomic,strong)UIView *reusableView;

@end

@implementation YMDoctorHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftNavigationBar];
   // [self initRightNaviBtn];
    [self createView];
    [self initVar];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
-(void)setStore_id:(NSString *)store_id{
    
    _store_id = store_id;
   
}
-(void)setIsUserDoctor:(BOOL)isUserDoctor{

    _isUserDoctor = isUserDoctor;
    if (isUserDoctor) {
        self.title = @"我的主页";
    }else{
      self.title = @"医生主页";
    }

}

-(void)createView{
    
    _doctorHomePageTableView = [[UITableView alloc]init];
    
    _doctorHomePageTableView.delegate = self;
    _doctorHomePageTableView.dataSource = self;
    [_doctorHomePageTableView registerClass:[YMDoctorCaseTableViewCell class] forCellReuseIdentifier:CaseTableViewCell];
    [_doctorHomePageTableView registerClass:[YMDoctorHomePageHeaderTableViewCell class] forCellReuseIdentifier:HomePageHeaderTableViewCell];
     _doctorHomePageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_doctorHomePageTableView];
    [_doctorHomePageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
  
}
-(void) initRightNaviBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn  setImage:[UIImage imageNamed:@"my_share_icon"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn addTarget:self action:@selector(onShareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =rightItem;
}

-(void)initVar{
    _doctorCaseArry = [NSMutableArray array];
    _doctorHonorArry = [NSMutableArray array];
    _doctorEvaluationArry = [NSMutableArray array];
    _ClickCaseNumber = CaseCaseNumber;
    self.params = [NSMutableDictionary new];
    self.caseParams = [NSMutableDictionary new];
    
}

//请求医生信息
- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    self.params[@"store_id"] = self.store_id;
    self.params[@"member_id"] = [YMUserInfo sharedYMUserInfo].member_id;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:DoctorInfo_URL params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                                    
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
            
            NSMutableDictionary *addBaseUrlDic = [[NSMutableDictionary alloc]init];
            [addBaseUrlDic addEntriesFromDictionary:showdata];
            weakSelf.model = [YMDoctorDetailsModel yy_modelWithDictionary:addBaseUrlDic];
            [weakSelf requrtCase];
            
        
        }
        
    }];
   
}
//关注
-(void)attentionRequrt{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:@"act=users_page&op=follow" params:@{@"friend_frommid":[YMUserInfo sharedYMUserInfo].member_id,@"friend_tomid":_model.member_id,@"type":@(_type)} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([_model.is_follow integerValue]==1) {
            weakSelf.model.is_follow = @"0";
            YMDoctorHomePageHeaderTableViewCell *cell = [self.doctorHomePageTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.isFollowDoctor = NO;
        }else{
            weakSelf.model.is_follow = @"1";
            YMDoctorHomePageHeaderTableViewCell *cell = [self.doctorHomePageTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.isFollowDoctor = YES;
        }
        
    }];
   

}


//分享按钮
-(void)onShareAction:(UIButton *) sender
{
   // [self shareBoardBySelfDefined];

}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return 10;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =RGBCOLOR(234, 234, 234);
    return headerview ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat cellheight =174.f;
        
        if (_detailsClick) {
            cellheight+= [YMDoctorHomePageHeaderTableViewCell DetailsViewHeight:_model.member_service detailsClick:_detailsClick]+18;
            
            cellheight +=[YMDoctorHomePageHeaderTableViewCell memberPersonalInfoHeight:_model.member_Personal]+18;
            
        }else{
            cellheight+= [YMDoctorHomePageHeaderTableViewCell DetailsViewHeight:_model.member_service detailsClick:_detailsClick]+15;
        }
        return cellheight +[YMDoctorHomePageHeaderTableViewCell goodAtHeight:_model.specialty_tags];
    }else{
        switch (_ClickCaseNumber) {
            case CaseTreatmentNumber:{
                NSLog(@"");
                return 0;
            }
                break;
            case CaseCaseNumber:{
                return [YMDoctorCaseTableViewCell cellCaseHeight:_doctorCaseArry];
            }
                break;
            case CaseHonorNumber:{
                NSLog(@"");
                return [YMDoctorCaseTableViewCell cellHonorHeight:_doctorHonorArry];
            }
                break;
            case CaseServerNumber:{
                NSLog(@"");
                return [YMDoctorCaseTableViewCell cellEvaluationHeight:_doctorEvaluationArry];
            }
                break;
            default:
                return 0;
                break;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        YMDoctorHomePageHeaderTableViewCell *cell = [[YMDoctorHomePageHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageHeaderTableViewCell];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clcickEvent = _detailsClick;
        cell.model = _model;
        
        return cell;
    }else{
        YMDoctorCaseTableViewCell *cell = [[YMDoctorCaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CaseTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.doctorCaseArry = _doctorCaseArry;
        cell.doctorHonorArry = _doctorHonorArry;
        cell.doctorEvaluationArry = _doctorEvaluationArry;
        cell.selectCaseNumber = _ClickCaseNumber;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark YMDoctorHomePageHeaderTableViewCellDelegate

-(void)HeaderTableViewCell:(YMDoctorHomePageHeaderTableViewCell *)headerTableViewCell sender:(UIButton *)sender{
    _detailsClick = !_detailsClick;
    [_doctorHomePageTableView reloadData];
}
//关注医生
-(void)selectdFollowDoctorBtnClick
{
    if ([_model.is_follow integerValue]==1) {
        _type = 2;
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"关注" message:@"是否取消对当前医生对关注" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //关注请求
            [self attentionRequrt];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        _type = 1;
        [self attentionRequrt];
    }
}
#pragma mark - YMDoctorCaseTableViewCellDelegate
-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)DoctorCaseViewCell clickTopNumber:(CaseNumber )caseNumber{
    
    _ClickCaseNumber = caseNumber;
    

    switch (caseNumber) {
        case CaseTreatmentNumber:{
            NSLog(@"");
           
        }
            break;
        case CaseCaseNumber:{
            NSLog(@"");
            if (_doctorCaseArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtCase];
            }
        }
            break;
        case CaseHonorNumber:{
            if (_doctorHonorArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtHonor:1];
            }
            
        }
            break;
        case CaseServerNumber:{
            if (_doctorEvaluationArry.count>0) {
                [_doctorHomePageTableView reloadData];
            }else{
                [self requrtEvaluation:1];
            }
            
        }
            break;
        default:
            break;
    }
}
//案例中心
-(void)requrtCase{
  
    if([self getMember_id]){
        
        self.caseParams[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    self.caseParams[@"doctor_member_id"] = _model.member_id;
 
    self.caseParams[@"is_admin"] = @(0);
    
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:Case_URL params:self.caseParams withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in showdata) {
                [weakSelf.doctorCaseArry addObject:[YMDoctorDetailsCaseModel yy_modelWithDictionary:dic]];
            }
            
        }
     [weakSelf.doctorHomePageTableView reloadData];
        
    }];
}
//荣誉中心
-(void)requrtHonor:(NSInteger)page{
    __weak typeof(self) weakSelf = self;
    NSDictionary* params = @{@"member_id":_model.member_id?:@0,
                             @"curpage":@(page)?:@0,
                             @"is_admin":@1};
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:Honor_URL params:params  withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                             if (showdata == nil) {
                                                 return ;
                                             }
                                             
                                             if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
                                                 for (NSDictionary *dic in showdata) {
                                                     [weakSelf.doctorHonorArry addObject:[YMDoctorDetailsHonorModel yy_modelWithDictionary:dic]];
                                                 }
                                             }
                                             [weakSelf.doctorHomePageTableView reloadData];
                                             
                                         }];
}
//服务评价
-(void)requrtEvaluation:(NSInteger)page{
    NSDictionary* params = @{@"store_id":_model.store_id,
                             @"curpage":@(page)?:@1};
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:Comment_URL params:params withModel:nil  waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                             if (showdata == nil) {
                                                 return ;
                                             }                                     
                                             if ([showdata isKindOfClass:[NSMutableArray class]] || [showdata isKindOfClass:[NSArray class]]) {
                                                 for (NSDictionary *dic in showdata) {
                                                     [weakSelf.doctorEvaluationArry addObject:[YMDoctorDetailsEvaluationModel yy_modelWithDictionary:dic]];
                                                 }
                                                 
                                             }
                                             [weakSelf.doctorHomePageTableView reloadData];
                                         }];
}

//点击案例中心
-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)doctorCaseViewCell caseModel:(YMDoctorDetailsCaseModel *)caseModel{
    self.hidesBottomBarWhenPushed = YES;
    YMCaseDetailsViewController *vc = [[YMCaseDetailsViewController alloc]init];
    vc.case_id =caseModel.case_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    
    //    //创建分享消息对象
    //    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //    messageObject.title = @"分享下载";
    //    //创建图片内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:@"我正在使用鸣医通，看病找专家，预约不排队，快来试试吧！" thumImage:[UIImage imageNamed:@"LOGOS"]];
    //    NSString *url;
    //    url = @"http://ys9958.com/shop/index.php?act=invite&op=reg";
    //    shareObject.webpageUrl = [url stringByAppendingFormat:@"&inviter_id=%@&type=1",[YMUserInfo sharedYMUserInfo].member_id];
    //    //分享消息对象设置分享内容对象
    //    messageObject.shareObject = shareObject;
    //    //调用分享接口
    //    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
    //        if (error) {
    //            NSLog(@"************Share fail with error %@*********",error);
    //        }else{
    //            NSLog(@"response data is %@",data);
    //        }
    //    }];
    [self createAlertVC];
}
-(void)createAlertVC
{
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:nil message:@"该功能正在建设中" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}





@end
