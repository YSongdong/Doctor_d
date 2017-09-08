//
//  MYTCaseTableViewCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTCaseTableViewCell : UITableViewCell

///图片
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

///阅读数
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;

///日期
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;


@end

