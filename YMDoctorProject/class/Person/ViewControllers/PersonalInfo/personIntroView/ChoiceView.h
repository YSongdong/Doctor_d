//
//  ListView.h
//  FenYouShopping
//
//  Created by fenyounet on 16/9/6.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BUTTON_WIDTH 80*HorizontalRatio()
typedef enum : NSUInteger {
    genderType,
    homeOperate,
    searchOperate,
    collectOperate,
    centerOperate
} OperateWays;


typedef void(^clickWithType)(OperateWays type,id dic);

@protocol ListViewDelegate <NSObject>

- (void)didClickWithDifferentWays:(OperateWays)ways ;

@end

@interface ChoiceView : UIView
@property (nonatomic,assign)BOOL isShow ;
@property (nonatomic,weak)id <ListViewDelegate>delegate ;

@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,copy)clickWithType block ;

- (void)showWithPoint:(CGPoint)point ;
- (void)hidenSelfWithEndPoint;
@end
