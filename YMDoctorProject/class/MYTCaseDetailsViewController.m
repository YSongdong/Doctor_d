//
//  MYTCaseDetailsViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTCaseDetailsViewController.h"
#import "MYTCaseDetailsTableViewCell.h"


#import "YMCaseDetailViewTableViewCell.h"
#import "YMCaseDetailsMonthInformationModel.h"
#import "YMCaseDetailsModel.h"

//#import <NSObject+YYModel.h>
#import <UIImageView+WebCache.h>
static NSString *const caseDetailViewCell = @"caseDetailViewCell";
@interface MYTCaseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *xueWeiLab;
@property (weak, nonatomic) IBOutlet UILabel *leavelLab;
@property (weak, nonatomic) IBOutlet UILabel *guanZhuLab;

@property (weak, nonatomic) IBOutlet UILabel *zhiYeLab;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;

@property (weak, nonatomic) IBOutlet UILabel *chengJiaoLiangLab;
@property (weak, nonatomic) IBOutlet UILabel *liuLanLiangLab;
@property (weak, nonatomic) IBOutlet UILabel *pingFenLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *caseShortLab;

@property (strong, nonatomic)NSMutableArray *dataArr;
@property (strong, nonatomic)NSMutableDictionary *dic;
@property(nonatomic,strong)YMCaseDetailsModel *model;
@end

@implementation MYTCaseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"案例详情";
    
    self.dataArr = [NSMutableArray new];
    self.dic = [NSMutableDictionary new];

    self.headImgView.clipsToBounds = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.bounds.size.height/2.0;
    [self loadDataWithView:self.view];
}

-(void)loadDataWithView:(UIView *)view{
//   __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_FullDetail params:@{
        @"case_id":@([self.case_id integerValue])}withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata-----------%@",showdata);
            
        self.dataArr = showdata[@"case_detail"];
        
        NSLog(@"dataArr-----------%@",self.dataArr);
            
        self.dic = showdata[@"doctor_info"];
        
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"member_avatar"]]];
        
        self.nameLab.text = self.dic[@"member_names"];
        self.xueWeiLab.text = @"";
        self.leavelLab.text = [NSString stringWithFormat:@"LV%@",self.dic[@"grade_id"]];
        if (![self.dic[@"grade_id"] isEqualToString:@""]) {
           self.guanZhuLab.text = [NSString stringWithFormat:@"关注: %@人",self.dic[@"follow_num"]];
        }else{
          self.guanZhuLab.text = [NSString stringWithFormat:@"关注: 0人"];
        }
        self.zhiYeLab.text = [NSString stringWithFormat:@"%@ %@",self.dic[@"member_bm"],self.dic[@"member_aptitude"]];
        self.hospitalLab.text = self.dic[@"member_occupation"];
        if (![self.dic[@"store_sales"] isEqualToString:@""]) {
          self.chengJiaoLiangLab.text = [NSString stringWithFormat:@"成交量: %@笔",self.dic[@"store_sales"]];
        }else{
           self.chengJiaoLiangLab.text = [NSString stringWithFormat:@"成交量: 0笔"];
        }
        if (![self.dic[@"stoer_browse"] isEqualToString:@""]) {
             self.liuLanLiangLab.text = [NSString stringWithFormat:@"浏览量:  %@次",self.dic[@"stoer_browse"]];
        }else{
           self.liuLanLiangLab.text = [NSString stringWithFormat:@"浏览量:  0次"];
        }
        self.pingFenLab.text = [NSString stringWithFormat:@"评分: %@",self.dic[@"avg_score"]];
        
        self.titleLab.text = [NSString stringWithFormat:@"标题: %@",showdata[@"case_title"]];
        self.timeLab.text = [NSString stringWithFormat:@"时间: %@",showdata[@"case_time"]];
        self.caseShortLab.text = [NSString stringWithFormat:@"案例简述:  %@",showdata[@"case_desc"]];
        
        // weakSelf.model = [YMCaseDetailsModel modelWithJSON:showdata];
            
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *arr = self.dataArr[section][@"detail"];
    
    return arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *cellIdentifier = @"CaseDetailsCell";
//    MYTCaseDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    if (indexPath.row == 0) {
//        
//        cell.yearsAndMonthLab.text = self.dataArr[indexPath.section][@"month"];
//    }
//   
//    if (self.dataArr[indexPath.section][@"detail"] != nil && [self.dataArr[indexPath.section][@"detail"] count] > 0) {
//        
//        [cell addCaseDetailsDataWithDictionary:self.dataArr[indexPath.section][@"detail"][indexPath.row]];
//    }
    YMCaseDetailViewTableViewCell *cell = [[YMCaseDetailViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:caseDetailViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //YMCaseDetailsMonthInformationModel *model= [_model caseDetail][indexPath.section];
    
  //  cell.model =[model monthDetail][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.showTitleLabel = YES;
        cell.titleStr = _model.case_title;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // YMCaseDetailsMonthInformationModel *monthModel= [_model caseDetail][indexPath.section];
    
   // YMCaseDetailsDayInformationModel *dayModel =[monthModel monthDetail][indexPath.row];
    
   // return [YMCaseDetailViewTableViewCell caseDetailViewHeight:dayModel];
    return 180;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
