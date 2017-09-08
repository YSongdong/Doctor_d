//
//  YMSelectedListView.h
//  doctor_user
//
//  Created by kupurui on 2017/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ListTypeNormal,
    ListTypeMoney,
    ListTypeHospital,
} ListType ;

@interface YMSelectedListView : UIView

@property (nonatomic,assign)CGFloat viewWidth ;
@property (nonatomic,assign)CGFloat start_X ;
@property (nonatomic,assign)CGFloat start_Y ;

@property (nonatomic,assign)ListType type ;

+ (YMSelectedListView *)viewWithDataList:(NSArray *)dataList
                                    type:(ListType)type
                            andViewWidth:(CGFloat)width
                                 start_Y:(CGFloat)start_y
                              andStart_X:(CGFloat)start_x
                       andCommpleteBlock:(void(^)(id value,ListType type))commplete;

@end
