//
//  AccountCollectionViewCell.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountCollectionViewCell ;
typedef void(^deleteCellBlock)(AccountCollectionViewCell * cell);

@interface AccountCollectionViewCell : UICollectionViewCell



@property (nonatomic,strong)DemandModel *model ;

@property (nonatomic,copy)deleteCellBlock block ;



- (void)deleteCellBlock:(deleteCellBlock)block ;


@end
