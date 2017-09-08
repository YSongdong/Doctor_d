//
//  NodataCell.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Authen,
    NoSystemOrder,
    DemandOrder,
} CellType;

typedef void(^LoadCellBlock)();
@interface NodataCell : UITableViewCell

@property (nonatomic,copy)LoadCellBlock block ;
@property (nonatomic,assign)CellType type ;


- (void)juadge ;

@end
