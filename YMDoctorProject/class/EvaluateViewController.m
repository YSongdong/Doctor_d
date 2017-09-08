//
//  EvaluateViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvaluateTableViewCell.h"
#import "DemandModel.h"
#import "DemandOrderModel.h"
@interface EvaluateViewController ()<UITableViewDataSource,UITableViewDelegate,DemandOrderModelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)DemandOrderModel *demandModel ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomHeight;
@end
@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (DemandOrderModel *)demandModel {
    if (!_demandModel) {
        _demandModel = [DemandOrderModel new];
        _demandModel.delegate = self ;
    }return _demandModel ;
}
- (void)setUp {
    
    
    _tableView.estimatedRowHeight = 100 ;
    _tableView.sectionFooterHeight = 10 ;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
}


- (IBAction)submitEvaluate:(id)sender {
    
    EvaluateTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (cell.content && cell.content.length > 0) {
        [dic setObject:cell.content forKey:@"geval_explain"];
    }else {
        [self alertViewShow:@"请输入评价内容"];
        return ;
    }
    [dic setObject:@(cell.selectedIndex + 1) forKey:@"pinfen"];
    if ([self getStore_id]) {
        [dic setObject:[self getStore_id] forKey:@"store_id"];
    }
    if (self.model.order_id) {
    [dic setObject:self.model.order_id forKey:@"order_id"];
    }                     
    [self.demandModel evaluateWithParams:dic andView:self.view];
}
//评价成功 
- (void)operatorSuccess {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)operatorFailureWithReason:(NSString *)reason {

    [self alertViewShow:reason];
}

- (void)operatorSuccessWithReason:(NSString *)reason {

    [self alertViewShow:reason];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluateTableViewCell *cell ;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderSnTableCellIdentifier"];
        cell.type = cellTypeOrder ;
        cell.model = self.model ;
    }
    if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"EvalauateContentIdentifier"];
        cell.type = cellTypeComment ;
    }
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0001f ;
}

@end
