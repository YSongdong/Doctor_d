//
//  OrderHeadView.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol OrderHeadViewDelegate <NSObject>


- (void)selectedIndexChangeRequest ;


@end

@interface OrderHeadView : UIView

@property (nonatomic,assign)NSInteger selectedIndex ;
@property (nonatomic,strong)NSArray *titles ;

@property (nonatomic,weak)id <OrderHeadViewDelegate>delegate ;


@end
