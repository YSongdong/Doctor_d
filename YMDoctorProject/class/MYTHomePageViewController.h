//
//  MYTHomePageViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTWDZY_RView.h"

@interface MYTHomePageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) MYTWDZY_RView *wdzy_RView;

@property (nonatomic,strong) NSMutableDictionary *dictionary;

@property (nonatomic,strong) NSString *store_id;//店铺ID
- (void)requestListDataWithView:(UIView *)view;

@end
