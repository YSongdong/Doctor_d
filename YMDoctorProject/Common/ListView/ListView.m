//
//  ListView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ListView.h"

@interface ListView ()

@property (nonatomic,strong)NSDictionary *data;
@end
@implementation ListView


+ (ListView *)listWithDataList:(NSDictionary *)dataList
                    andWidth:(CGFloat)width
                   andHeight:(CGFloat)height{
    ListView *list = [[ListView alloc]initWithWidth:width andHeight:height];
    list.data = dataList ;
    return list;
}
- (instancetype)initWithWidth:(CGFloat)width
                    andHeight:(CGFloat)height {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    
    
    
    
}
@end
