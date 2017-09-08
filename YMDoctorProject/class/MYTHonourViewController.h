//
//  MYTHonourViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};


@interface MYTHonourViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSString *honor_idStr;

@property (nonatomic,assign)eRefreshType type;
//请求列表数据
- (void)requestListDataWithView:(UIView *)view;

@end

