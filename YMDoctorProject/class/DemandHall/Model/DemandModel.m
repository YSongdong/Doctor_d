//
//  DemandModel.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandModel.h"

@implementation DemandModel
- (void)setValue:(id)value
 forUndefinedKey:(NSString *)key{
    
}
- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
      CGSize size = [self.demand_needs sizeWithBoundingSize:CGSizeMake(WIDTH - 10 - 10, 0) font:[UIFont systemFontOfSize:14]];
        _cellHeight =  10 + 20.5 + 10 + size.height+10 + 12 +10 ;

    }
    return _cellHeight ;
}

- (CGFloat)getDemandDetailHeight {
    
       CGSize size = [self.demand_needs sizeWithBoundingSize:CGSizeMake(WIDTH - 15 - 15, 0) font:[UIFont systemFontOfSize:14]];
        CGSize size2 = [self.demand_sketch sizeWithBoundingSize:CGSizeMake(WIDTH - 15-15, 0) font:[UIFont systemFontOfSize:14]];
    return  145 + size.height + 10 + 10 + size2.height;

}


- (CGFloat)contentCellHeight {
    
    
    CGSize size = [self.demand_needs sizeWithBoundingSize:CGSizeMake(WIDTH - 15 - 15, 0) font:[UIFont systemFontOfSize:14]];
    return size.height + 15 + 15 ;
    
}
@end
