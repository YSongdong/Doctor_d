//
//  HomeManageTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/7/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeManageTableViewCell.h"

@interface HomeManageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *homePageLabel;
- (IBAction)homePageAction:(UIButton *)sender;  //个人主页

@property (weak, nonatomic) IBOutlet UILabel *serveLabel;
- (IBAction)mineServeAction:(UIButton *)sender; //我的服务

@property (weak, nonatomic) IBOutlet UILabel *caseListLabel;
- (IBAction)caseListAction:(UIButton *)sender; //案例管理

@property (weak, nonatomic) IBOutlet UILabel *honourLabel;
- (IBAction)honourListAction:(UIButton *)sender; //荣誉管理

@end



@implementation HomeManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
     _homePageLabel.textColor = [UIColor btnTextColor];
     _serveLabel.textColor = [UIColor btnTextColor];
     _caseListLabel.textColor = [UIColor btnTextColor];
     _honourLabel.textColor = [UIColor btnTextColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//个人主页
- (IBAction)homePageAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector( selectdManageBtnIndex:)]) {
        [self.delegate selectdManageBtnIndex:0];
    }
}
//我的服务
- (IBAction)mineServeAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector( selectdManageBtnIndex:)]) {
        [self.delegate selectdManageBtnIndex:1];
    }
}
//案例管理
- (IBAction)caseListAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector( selectdManageBtnIndex:)]) {
        [self.delegate selectdManageBtnIndex:2];
    }
}
//荣誉管理
- (IBAction)honourListAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector( selectdManageBtnIndex:)]) {
        [self.delegate selectdManageBtnIndex:3];
    }
}
@end
