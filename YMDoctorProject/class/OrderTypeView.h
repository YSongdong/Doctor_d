//
//  OrderTypeView.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTypeViewDelegate <NSObject>

-(void)selectdOrderTypeNSIntager:(NSInteger) type;

@end


@interface OrderTypeView : UIView

@property(nonatomic,weak) id <OrderTypeViewDelegate> delegate;

@end
