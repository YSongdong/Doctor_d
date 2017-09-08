//
//  MYTAddCaseViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/19.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTAddCaseTableViewController : UITableViewController

@property (nonatomic, strong)NSString *case_id;

@property (nonatomic, strong)NSMutableDictionary *params;
//默认是新增 NO  编辑 yes
@property (nonatomic,assign)BOOL isEdit;


@property (nonatomic,strong) NSDictionary * pushDict;
@property (nonatomic,strong) NSDictionary *imgDict;

@property (nonatomic,strong) NSMutableArray *fileImgArr;

-(NSString *)getImgName;

@end

