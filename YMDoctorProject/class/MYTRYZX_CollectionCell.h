//
//  MYTYSZYRYZX_CollectionCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTRYZX_CollectionCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *honourTitleLab;

@property (weak, nonatomic) IBOutlet UIImageView *honourImageView;

- (void)addHonourData:(NSDictionary *)dic;


@end

