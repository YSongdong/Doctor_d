//
//  EvaluateTableViewCell.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

typedef enum : NSUInteger {
    cellTypeOrder,
    cellTypeComment,
} CellType;
#import <UIKit/UIKit.h>

@interface EvaluateTableViewCell : UITableViewCell

@property (nonatomic,assign)CellType type ;

@property (nonatomic,strong)DemandModel *model ;

@property (nonatomic,strong)NSString *content ;
@property (nonatomic,assign)NSInteger selectedIndex ;



@end
