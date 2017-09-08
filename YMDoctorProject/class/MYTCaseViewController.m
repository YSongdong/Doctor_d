//
//  MYTCaseViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIImageView+WebCache.h>

#import "UIView+tool.h"
#import "MYTCaseTableViewCell.h"
#import "MYTCaseViewController.h"

#import "MYTAddCaseTableViewController.h"

@interface MYTCaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addCaseBtn;
@property (nonatomic, strong)UIButton *recordEditBtn;
@property (nonatomic, strong)UIButton *recordStateBtn;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableDictionary *params;

@property(nonatomic,strong)UIButton *senderButton;

@end

static NSInteger clickCount;

@implementation MYTCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.params = [NSMutableDictionary new];
    
    [self.addCaseBtn setCornerRadius:CGRectGetHeight(self.addCaseBtn.frame)/2 hexColor:@"" borderWidth:0];
    
    clickCount = 0;
    
    //self.tableView.estimatedRowHeight = 148;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.refresh.enableInsetBottom = 128;
    
    [self requestListDataWithView:self.view];    
}

//下拉刷新上拉加载
-(void)didRefreshComplectWith:(DJRefresh *)refresh direction:(DJRefreshDirection)direction info:(NSDictionary *)info{
    //下拉刷新
    if (direction == DJRefreshDirectionTop) {
        
        self.curpageNum = 0;
        self.stateR = 0;
    }else {
        
        self.stateR = 1;
        self.curpageNum ++;
    }
    
    [self requestListDataWithView:self.view];
}


//请求列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    if([self getMember_id]){
        
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    if ([self getStore_id]){
        self.params[@"doctor_member_id"] =  @([[self getMember_id] integerValue]);
;
    }
    
    self.params[@"is_admin"] = @(1);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_URL
     params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
         
         [self.refresh finishRefreshing];
         
        NSLog(@"showdata ======= %@",showdata);
         
         if (showdata == nil) {
             return ;
         }
         
         self.dataArray = showdata;
         
        [self.tableView reloadData];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"caseCell";
    MYTCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row][@"case_thumb"]] placeholderImage:[UIImage imageNamed:@"方形图片"]];
    cell.titleLab.text = self.dataArray[indexPath.row][@"case_title"];
    cell.contentLab.text = self.dataArray[indexPath.row][@"case_desc"];
    cell.readNumLab.text = self.dataArray[indexPath.row][@"page_view"];
    cell.dateLab.text  = self.dataArray[indexPath.row][@"case_time"];
    
    self.case_id = self.dataArray[indexPath.row][@"case_id"];
    
    NSString *state = self.dataArray[indexPath.row][@"status"];
    if ([state isEqualToString:@"2"]) {
        
        self.type = @"2";
        [cell.stateBtn setTitle:@" 显示" forState:UIControlStateNormal];
    }else if ([state isEqualToString:@"1"]) {
        
        self.type = @"1";
        [cell.stateBtn setTitle:@" 隐藏" forState:UIControlStateNormal];
    }
    
    cell.editBtn.hidden = NO;
    
    [cell.editBtn addTarget:self action:@selector(editCase:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;

    
    [cell.stateBtn addTarget:self action:@selector(hideOrShowCase:) forControlEvents:UIControlEventTouchUpInside];
    cell.stateBtn.tag = indexPath.row;
    
    
    if (clickCount % 2 == 0) {
//        管理
        cell.editBtn.hidden = NO;
        
        
        UIColor *color = [UIColor colorWithRed:75.0/255.0 green:166.0/255.0 blue:255.0/255.0 alpha:1];
        [cell.stateBtn setTitleColor:color forState:UIControlStateNormal];
        [cell.stateBtn setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
        cell.stateBtn.layer.borderColor = color.CGColor;
        
    }else{
//        保存
        
        cell.editBtn.hidden = YES;
        [cell.stateBtn setTitle:@"删除" forState:UIControlStateNormal];
        UIColor *color = [UIColor colorWithRed:156.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1];
        [cell.stateBtn setTitleColor:color forState:UIControlStateNormal];
        cell.stateBtn.layer.borderColor = color.CGColor;
        [cell.stateBtn setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 148;

}

- (void)editCase:(UIButton *)sender {
    
    MYTAddCaseTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTAddCaseTableViewController"];
    vc.title = @"编辑案例";

    vc.isEdit = YES;
    vc.pushDict =@{
               @"case_id":self.dataArray[sender.tag][@"case_id"]
               };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hideOrShowCase:(UIButton *)sender{
    
    _senderButton = sender;
    
    NSLog(@"tag===%ld",(long)sender.tag);
    
    NSString *state = self.dataArray[sender.tag][@"status"];
    
    NSString *tipStr = @"您确定要隐藏这个案例吗";
    
    if ([state isEqualToString:@"2"]) {
        
         tipStr = @"您确定要显示这个案例吗";
    }

    [self showAlterViewStr:tipStr];
}
-(void)showAlterViewStr:(NSString *)str{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (clickCount % 2 ==1) {
            
            //        保存 ---删除
            [self deleteClick:_senderButton];
            return;
        }
        
        NSInteger state1= [self.dataArray[_senderButton.tag][@"status"] integerValue];
        NSInteger state = state1 == 2 ? 1:2;
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_ChangeStatus  params:@{@"case_id":@([self.dataArray[_senderButton.tag][@"case_id"]  integerValue]) ,@"type": @(state)} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {   [self requestListDataWithView:self.view];
        }];

    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alterVC animated:YES completion:nil];

}

//
//- (void)hideOrShowCase:(UIButton *)sender {
//
//    if (clickCount % 2 ==1) {
////        保存 ---删除
//        
//        [self deleteClick:sender];
//        return;
//    }
//    
//    NSInteger state1= [self.dataArray[sender.tag][@"status"] integerValue];
//    NSInteger state = state1 == 2 ? 1:2;
//    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_ChangeStatus
//    params:@{@"case_id":@([self.dataArray[sender.tag][@"case_id"]  integerValue]) ,@"type": @(state)} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
//        
//        NSLog(@"showdata ===--------==== %@",showdata);
//        [self requestListDataWithView:self.view];
//    }];
//}

//删除按钮点击事件
-(void)deleteClick:(UIButton *)sender{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_Del
    params:@{@"case_id":@([self.dataArray[sender.tag][@"case_id"] integerValue])} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata ===--------==== %@",showdata);
        
        [self requestListDataWithView:self.view];
    }];
}

- (IBAction)UIBarButtonItemClick:(UIBarButtonItem *)sender {
    clickCount ++;
    if (clickCount % 2 == 1) {
        
        sender.title = @"保存";
        
        self.recordEditBtn.hidden = YES;
        [self.recordStateBtn setTitle:@"  删除" forState:UIControlStateNormal];
        UIColor *color = [UIColor colorWithRed:156.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1];
        [self.recordStateBtn setTitleColor:color forState:UIControlStateNormal];
        self.recordStateBtn.layer.borderColor = color.CGColor;
        [self.recordStateBtn setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
        
        [self.recordStateBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (clickCount % 2 == 0){
        
        sender.title = @"管理";
        self.recordEditBtn.hidden = NO;
        [self.recordStateBtn setTitle:@"  显示" forState:UIControlStateNormal];
        UIColor *color = [UIColor colorWithRed:75.0/255.0 green:166.0/255.0 blue:255.0/255.0 alpha:1];
        [self.recordStateBtn setTitleColor:color forState:UIControlStateNormal];
        [self.recordStateBtn setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
        self.recordStateBtn.layer.borderColor = color.CGColor;
    }
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
