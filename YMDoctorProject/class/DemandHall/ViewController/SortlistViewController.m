//
//  SortlistViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SortlistViewController.h"

@interface SortlistViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableview ;


@end
@implementation SortlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height) style:UITableViewStyleGrouped];
    _tableview.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    _tableview.showsVerticalScrollIndicator = NO ;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableview];
    _tableview.delegate = self ;
    _tableview.dataSource =self;
    _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    _tableview.scrollEnabled = NO ;
    
}
+ (CGFloat)getContentHeightWithDataList:(NSArray *)dataList {
    return 45 * [dataList count];
}

- (void)setDatList:(NSArray *)datList{
    _datList = datList;
    if ([_datList count] == 0) {
        return ;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableview reloadData];
    });
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex ;
    
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.accessoryType = UITableViewCellAccessoryNone ;
    if ([_datList[indexPath.row]
         isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = _datList[indexPath.row][@"ename"];
        cell.textLabel.adjustsFontSizeToFitWidth=  YES ;        
    }else{
        cell.textLabel.text = _datList[indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES ;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter ;
    cell.textLabel.textColor = [UIColor colorWithRed:61/255 green:61/255 blue:61/255 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:13 *VerticalRatio()];
    [cell.textLabel adjustsFontSizeToFitWidth];
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    NSNumber *number ;
    if (indexPath.row == 0) {
        number = nil ;
    }
    else {
        number =  @(indexPath.row) ;
    }
    if (self.block) {
        if ([_datList[indexPath.row]isKindOfClass:[NSDictionary class]]) {
             number = _datList[indexPath.row][@"disorder"];
            self.block(_datList[indexPath.row][@"ename"],number,1);
        }else {
           //0 1 2
            self.block(_datList[indexPath.row],number,0);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

