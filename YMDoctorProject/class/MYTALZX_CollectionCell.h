//
//  MYTYSZYAL_CollectionCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTALZX_CollectionCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *caseImageView;

@property (weak, nonatomic) IBOutlet UILabel *caseTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *caseTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *caseCountLab;


- (void)addCaseData:(NSDictionary *)dic;

@end
