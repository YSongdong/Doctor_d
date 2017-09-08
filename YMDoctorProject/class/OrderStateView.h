//
//  OrderStateView.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderStateViewDelegate <NSObject>

-(void)selectdOrderStateNSString:(NSString *)stateStr;

@end



@interface OrderStateView : UIView

@property(nonatomic,weak) id <OrderStateViewDelegate> delegate;

@end
