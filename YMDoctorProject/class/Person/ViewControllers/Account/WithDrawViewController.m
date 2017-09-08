//
//  WithDrawViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "WithDrawViewController.h"
#import "WithDrawCell.h"
#import "PersonViewModel.h"
#import "AddAccountViewController.h"
#import "WithDrawSureViewController.h"
#import "BindAlipayViewController.h"
@interface WithDrawViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)PersonViewModel *viewModel ;
@end

@implementation WithDrawViewController


-(void)dealloc {    
    [self.viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 0.0001f ;
    [self.viewModel addObserver:self forKeyPath:@"billLists" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}
- (void)setup {
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    
    [self.viewModel getBankListWithParams:dic andView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    
        
}

- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.viewModel.billLists count] + 1
        ;
    }
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2 ;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UILabel *view = [UILabel new];
        view.frame = CGRectMake(20, 0, WIDTH, 40);
        view.font = [UIFont systemFontOfSize:17];
        view.textColor = [UIColor hightBlackClor];
        view.text = @"  选择到账账户";
        
        return view ;
    }
    return nil ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"withDrawCellIdentifier"];
    if (indexPath.section == 0) {
        if ( self.viewModel.billLists &&
            indexPath.row <= [self.viewModel.billLists count] -1) {
        DemandModel *model = self.viewModel.billLists[indexPath.row];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",model.name,model.card_num];
            cell.nameLabel.textColor = [UIColor textLabelColor];
        }else {
            cell.nameLabel.text = @"支付宝";
            cell.nameLabel.textColor = [UIColor hightBlackClor];
        }
    }
    if (indexPath.section == 1) {
        cell.nameLabel.textColor = [UIColor hightBlackClor];
        cell.nameLabel.text = @"┼ 添加新银行卡";
    }
    return cell ;
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 40 ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //判断是否绑定支付宝
        //支付宝
        if ( [self.viewModel.billLists count] == 0 || (indexPath.row == [self.viewModel.billLists count]
            && [self.viewModel.billLists count] > 0)) {
            [self performSegueWithIdentifier:@"bindAlipayIdentifier" sender:nil];
        }
        else {
            if (self.block){
                self.block(self.viewModel.billLists[indexPath.row]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (indexPath.section == 1) {
    [self performSegueWithIdentifier:@"addBankIdentifier" sender:nil];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"bindAlipayIdentifier"]) {
        
        BindAlipayViewController *vc = segue.destinationViewController ;        
//        if (self.ways == 1) {
//            vc.ways = self.ways;
//        }
    }


}



- (void)choiceBankName:(returnBankNameBlock)block {
    _block = block ;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"billLists"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}


@end
