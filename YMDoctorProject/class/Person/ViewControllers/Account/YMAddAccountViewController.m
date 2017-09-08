//
//  YMAddAccountViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddAccountViewController.h"
#import "YMAddAccountTableViewCell.h"
#import "AddAccountViewController.h"
#import "BindAlipayViewController.h"

static NSString *const addAccountViewCell = @"addAccountViewCell";

@interface YMAddAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *addAccountTabeleView;
@property(nonatomic,strong)NSArray *listData;

@end

@implementation YMAddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"添加帐户";
    [self initView];
    [self initArry];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initTableView];
}

-(void)initArry{
    _listData = @[@"添加银行卡账户",@"添加支付宝账户"];
}

-(void)initTableView{
    _addAccountTabeleView = [[UITableView alloc]init];
    _addAccountTabeleView.delegate = self;
    _addAccountTabeleView.dataSource = self;
    _addAccountTabeleView.backgroundColor = [UIColor clearColor];
    
    [_addAccountTabeleView registerClass:[YMAddAccountTableViewCell class] forCellReuseIdentifier:addAccountViewCell];
    
    _addAccountTabeleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_addAccountTabeleView];
    [_addAccountTabeleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}

- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor clearColor];
    return headerview ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMAddAccountTableViewCell *cell = [[YMAddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addAccountViewCell];;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == _listData.count -1){
        cell.lastOne = YES;
    }
    if (indexPath.row !=0) {
        cell.lineInterval = YES;
    }
    cell.titleName = _listData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     UIStoryboard *sd = [UIStoryboard storyboardWithName:@"Account" bundle:nil];
    switch (indexPath.row) {
        case 0:{
            
            AddAccountViewController *addAccountVC = [sd instantiateViewControllerWithIdentifier:@"AddAccountViewController"];
            [self.navigationController pushViewController:addAccountVC animated:YES];
            
        }    
            break;
        case 1:{
            
            BindAlipayViewController *bindAliVC = [sd instantiateViewControllerWithIdentifier:@"BindAlipayViewController"];
            [self.navigationController pushViewController:bindAliVC animated:YES];

        }
            break;
        default:
            break;
    }
}

@end
