//
//  MYAddClassTableCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/20.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTAddCaseTableViewController.h"

@interface MYAddClassTableCell : UITableViewCell<UITextViewDelegate>

//案例标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

//封面
@property (weak, nonatomic) IBOutlet UIButton *fengMianBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fengMianImageView;

//案例详情
@property (weak, nonatomic) IBOutlet UIButton *detailTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianHaoBtn;


@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLab;


@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@property (weak, nonatomic) IBOutlet UIButton *detailImgBtn;


//编辑的时候刷新表 重写set方法
@property (nonatomic,strong) NSArray * d_imgs;

@property (nonatomic,weak) NSMutableDictionary * modelDict;

@property (nonatomic,weak) MYTAddCaseTableViewController * vc;


@end
