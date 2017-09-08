//
//  HealthyHelperViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HealthyHelperViewController.h"

#import "HelperInfoTableViewCell.h"
#import "TakeDrugTableViewCell.h"
#import "RemindTableViewCell.h"


#import "TakeDrugFootView.h"

#define HELPERINFOTABLEVIEW_CELL  @"HelperInfoTableViewCell"
#define TAKEDRUGTABLEVIEW_CELL    @"TakeDrugTableViewCell"
#define REMINDTABLEVIEW_CELL     @"RemindTableViewCell"
@interface HealthyHelperViewController ()<UITableViewDelegate,UITableViewDataSource,TakeDrugFootViewDelegate>

@property(nonatomic,strong) UITableView *heplerTableView;
@property(nonatomic,strong) NSMutableArray *drugArr;//药品数组
@property(nonatomic,assign) NSInteger cellPage;
@end

@implementation HealthyHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"健康助手";
    self.cellPage = 1;
    [self initTableView];
}
-(void)initTableView
{
    self.heplerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_WIDTH, Screen_HEIGHt-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.heplerTableView];
    self.heplerTableView.dataSource = self;
    self.heplerTableView.delegate = self;
    self.heplerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.heplerTableView registerNib:[UINib nibWithNibName:HELPERINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:HELPERINFOTABLEVIEW_CELL];
    [self.heplerTableView registerNib:[UINib nibWithNibName:TAKEDRUGTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:TAKEDRUGTABLEVIEW_CELL];
    [self.heplerTableView registerNib:[UINib nibWithNibName:REMINDTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:REMINDTABLEVIEW_CELL];
}
#pragma mark   -- UITableViewSoucre -- 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _drugArr.count;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        HelperInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HELPERINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        TakeDrugTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TAKEDRUGTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REMINDTABLEVIEW_CELL forIndexPath:indexPath];
        return cell;
    }

}

#pragma mark -- UITableViewDelegate----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 104;
    }else if (indexPath.section == 1) {
        return 125;
    }else{
        return 305;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else  if (section == 1) {
        return 175.f;
    }else{
        return 50.f;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else {
        return 10.f;
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor cellBackgrounColor];
    return headerView;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        TakeDrugFootView *drugFootView = [[[NSBundle mainBundle]loadNibNamed:@"TakeDrugFootView" owner:nil options:nil]lastObject];
        drugFootView.delegate = self;
      return drugFootView;
    }
    if (section == 2) {
        UIView *remindFootView = [[UIView alloc]init];
        remindFootView.backgroundColor = [UIColor whiteColor];
        UIButton *remindAddBtn = [[UIButton alloc]init];
        remindAddBtn.layer.borderWidth = 1;
        remindAddBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
        remindAddBtn.layer.cornerRadius = 5;
        remindAddBtn.layer.masksToBounds = YES;
        [remindAddBtn setTitle:@" 新增提醒" forState:UIControlStateNormal];
        [remindAddBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
        [remindAddBtn setImage:[UIImage imageNamed:@"healthy_add"] forState:UIControlStateNormal];
        [remindFootView addSubview:remindAddBtn];
        [remindAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(remindFootView.mas_top).offset(5);
            make.left.equalTo(remindFootView.mas_left).offset(5);
            make.bottom.equalTo(remindFootView.mas_bottom).offset(-5);
            make.right.equalTo(remindFootView.mas_right).offset(-5);
        }];
        
        return remindFootView;
    }
    return nil;
    
}
#pragma mark  --- 点击按钮事件 ----
//点击添加药品
-(void)selectdAddTakeDrugBtn
{
    self.cellPage += 1;
    [self.drugArr addObject:[NSString stringWithFormat:@"%ld",(long)self.cellPage]];
    [self.heplerTableView reloadData];
}

-(NSMutableArray *)drugArr
{
    if (!_drugArr) {
        _drugArr = [NSMutableArray array];
        [self.drugArr addObject:[NSString stringWithFormat:@"%d",1]];
    }
    return _drugArr;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
