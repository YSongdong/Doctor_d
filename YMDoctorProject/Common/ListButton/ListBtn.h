//
//  ListBtn.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ListBtn : UIButton
@property (nonatomic,strong)NSString *title ;
@property (nonatomic,assign)BOOL haveListFlag ; //是否有下拉标志
- (void)setSelected:(BOOL)selected
           andColor:(UIColor *)color;

- (NSAttributedString *)attributeStringWithTitle:(NSString *)title ;

@end
