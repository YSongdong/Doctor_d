//
//  AccountViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BankListViewController.h"
#import "AccountCollectionViewCell.h"
#import "PersonViewModel.h"
#import "YMAddAccountViewController.h"
@interface BankListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonnull,strong,nonatomic)PersonViewModel *viewModel ;

@end

@implementation BankListViewController


- (void)dealloc {
    
    [self.viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self setUP];
    [self.viewModel addObserver:self forKeyPath:@"billLists"
options:NSKeyValueObservingOptionNew context:nil];
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (![self getMember_id]) {
        [self alertViewShow:@"获取账户信息失败"];
        return ;
    }
    NSDictionary *dic = @{@"member_id":[self getMember_id]};
    [self.viewModel getBankListWithParams:dic andView:self.view];
}
- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
}

- (void)setUP {
    
  
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClickOperation)];
    self.navigationItem.rightBarButtonItem = myButton;
    UICollectionViewFlowLayout *layout =  (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout ;
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 40, 130);
    layout.minimumLineSpacing = 20 ;
}


- (void)rightButtonClickOperation {
    
    YMAddAccountViewController *addAccountVC =[[YMAddAccountViewController alloc]init];
    [self.navigationController pushViewController:addAccountVC animated:YES];
    
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.billLists count] ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    AccountCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"accountCollectionViewCellIdentifier" forIndexPath:indexPath];
    cell.model = self.viewModel.billLists[indexPath.item];
    __weak typeof(self)weakSelf = self ;
    [cell deleteCellBlock:^(AccountCollectionViewCell *selectedCell) {
        
        [self alertViewControllerShowWithTitle:@"是否确认删除" message:nil
    sureTitle:@"确定" cancelTitle:@"取消" andHandleBlock:^(id value, NSString *error) {
        if ([value isEqual:@(1)]) {
            
            NSIndexPath *indexpaths = [collectionView indexPathForCell:selectedCell];
            [self.viewModel.billLists mutableCopy];
            //删除银行卡
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if ([weakSelf getMember_id]) {
                [dic setObject:[weakSelf getMember_id] forKey:@"member_id"];
            }
            DemandModel *model = weakSelf.viewModel.billLists[indexpaths.item];
            if (model.card_id) {
                [dic setObject:model.card_id forKey:@"card_id"];
            }
            dispatch_async(dispatch_queue_create("delete.banklist", DISPATCH_QUEUE_CONCURRENT), ^{
                [weakSelf.viewModel deletedBankListWithParams:dic andReturnBlock:^(id statue) {
                    if ([statue isEqual:@(1)]) {
                        NSMutableArray *array = [weakSelf.viewModel.billLists mutableCopy];
                        [array removeObjectAtIndex:indexpaths.item];
                        weakSelf.viewModel.billLists = array ;
                        [collectionView deleteItemsAtIndexPaths:@[indexpaths]];
                    }else {
                        [weakSelf alertViewShow:statue];
                    }
                    
                }];
            });

            
        }
        
    }];
        
    }];
    return  cell ;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"billLists"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
}

@end
