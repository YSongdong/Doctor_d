//
//  MYTWDZY_RView.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTWDZY_RView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *zg_View;

@property (nonatomic,copy) void (^BtnClickBack) (NSInteger index);

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *follow_numLab;


@property (weak, nonatomic) IBOutlet UILabel *aptitudeLab;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;


@property (weak, nonatomic) IBOutlet UILabel *store_salesLab;
@property (weak, nonatomic) IBOutlet UILabel *stoer_browseLab;
@property (weak, nonatomic) IBOutlet UILabel *avg_scoreLab;

@property (weak, nonatomic) IBOutlet UILabel *serviceLab;
@property (weak, nonatomic) IBOutlet UILabel *personalLab;


-(void)setSelectedBtnWithIndex:(NSInteger)index;

@end

