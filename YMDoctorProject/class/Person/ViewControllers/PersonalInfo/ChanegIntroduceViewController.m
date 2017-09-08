//
//  ChanegIntroduceViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChanegIntroduceViewController.h"
#import "PersonIntroTableViewCell.h"
#import "PersonViewModel.h"

#define TEXT_LENGTH 20

#define SkillString  @"请在此填写您所擅长的专业技能(必填)"
#define ProfileString @"请在此填写您的个人简介，有助于患者更了解医生的能力"
@interface ChanegIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate,PersonViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *titles ;
@property (nonatomic,strong)PersonViewModel *viewModel ;
@property (nonatomic,strong)NSMutableDictionary *params ;

@property (nonatomic,strong)NSMutableDictionary *dicParams ;//将要传递的参数

@property (nonatomic,assign)BOOL haveData;

@end

@implementation ChanegIntroduceViewController

- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
            if ([self getMember_id]) {
                _dicParams[@"member_id"] = [self getMember_id];
            }
    }
    return _dicParams ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup {
    _tableView.sectionFooterHeight = 10 ;
    [self addRightButton];
    self.rightButton.title = @"修改";
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getStore_id]) {
        dic[@"store_id"]= [self getStore_id];
    }
    if ([self getMember_id]) {
        dic[@"member_id"] = [self getMember_id];
    }
    [self.viewModel requestPersonalInfo:dic
                                   view:self.view];
}

-(PersonViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
        _viewModel.delegate = self ;
    }
    return _viewModel ;
}

//点击完成
- (void)rightButtonClickOperation {
    
    if ([self.dicParams[@"member_service"] length] == 0) {
        [self alertViewShow:@"职业擅长不能为空"];
        return ;
    }
    
    if ([self.dicParams[@"member_Personal"] length]== 0) {
        [self alertViewShow:@"个人简介不能为空"];
        return ;
    }
    
    if ([self getStore_id]){
        self.dicParams[@"store_id"]= [self getStore_id];
    }
    [self.viewModel changePersonalIntroduceWithParams:self.dicParams];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIntroduceTableCellIdentifier"];
    if (indexPath.section == 0) {
        cell.title = @"职业擅长";
        cell.type = beGoodAt ;
        cell.placeHolder = [NSString stringWithFormat:SkillString];
        if ([self.params objectForKey:@"member_service"]) {
            cell.contentTextView.editable = YES ;
            cell.content = self.params[@"member_service"];
        }
    }
    if (indexPath.section == 1) {
        cell.title = @"个人简介";
        cell.type = ProfileIntroduce ;
        cell.placeHolder = [NSString stringWithFormat:ProfileString];
        if ([self.params objectForKey:@"member_Personal"]) {
            cell.contentTextView.editable = YES ;
            cell.content = self.params[@"member_Personal"];
        }
    }
    cell.textBlock = ^(NSString *key,NSString *value){
        [self.dicParams setObject:value forKey:key];
         self.haveData = YES;
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    };
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       NSString *str  ;
    if (indexPath.section ==  0) {
        str = self.params[@"member_service"];
    }
    else {
        str = self.params[@"member_Personal"];
    }
    return [self getHeightWithData:str];
}


- (CGFloat)getHeightWithData:(NSString *)data {

    if (self.haveData) {
        CGSize size = [data sizeWithBoundingSize:CGSizeMake(self.view.width - 20, 0) font:[UIFont systemFontOfSize:14]];
        if (size.height + 50 < 186) {
            return 186 ;
        }
        return size.height + 60 ;
    }
    return 186 ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0.001 ;
}

#pragma mark-------PersonModelDelegate


- (void)operateFailure:(NSString *)failureReason {
    
    [self alertViewShow:failureReason];
}

- (void)operateSuccess:(NSString *)successTitle {
    
    
    [self alertViewShow:successTitle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)requestDataSuccess:(id)resultValue {
    
    NSLog(@"%@",resultValue);
    if ([resultValue isKindOfClass:[NSDictionary class]]) {
        if (![resultValue[@"member_Personal"] isEqualToString:@""]
            &&![resultValue[@"member_service"]isEqualToString:@""]) {
            self.haveData = YES ;
        }
        if ([resultValue objectForKey:@"member_Personal"]
            && ![[resultValue objectForKey:@"member_Personal"] isEqualToString:@""]) {
            [self.params setObject:resultValue[@"member_Personal"] forKey:@"member_Personal"];//个人简介
            self.dicParams[@"member_Personal"] = resultValue[@"member_Personal"];
        }
        if ([resultValue objectForKey:@"member_service"]
            && ![[resultValue objectForKey:@"member_service"] isEqualToString:@""]) {
            [self.params setObject:resultValue[@"member_service"] forKey:@"member_service"];
            self.dicParams[@"member_service"] = resultValue[@"member_service"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.rightButton setTitle:@"修改"];
        });
    }
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}
@end
