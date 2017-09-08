//
//  MYTHonourTableViewCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTHonourTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *honourImageView;


@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *yinCangBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagHeight;


@end

