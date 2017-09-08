//
//  DemandOrderViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "DemandOrderModel.h"

typedef enum : NSUInteger {
    
    requestTypeDemandOrderUrl,
    requestTypeEmployerOrderUrl,
    requestTypeIncurableUrl,
    
} RequestTypeUrl;

@interface DemandOrderViewController  : BaseViewController

@property (nonatomic,assign)RequestTypeUrl requestUrlType ;
@property (nonatomic,strong)DemandOrderModel *orderModel ;
@property (nonatomic,assign)NSInteger page ;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,strong)NSArray *dataList ;

@property (nonatomic,weak) UIViewController * fartherVC;

- (void)setUp ;

- (void)requestDataWithUrl;

- (void)refreshData ;

//加载
- (void)loadMoreData ;
//- (void)requestDataWithUrl:(NSString *)url ;
-(void)pushNextPageWithIndexPath:(NSIndexPath*)indexPath;


@end
