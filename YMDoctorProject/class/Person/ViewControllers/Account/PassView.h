//
//  PassView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^usePhoneBlock)();

typedef BOOL (^SetPayPassBlock)(id value);


typedef void(^payPassPayBlock)(id value);


@interface PassView : UIView

@property (nonatomic,assign)NSInteger type ;

@property (weak, nonatomic) IBOutlet UITextField *PassTextField;

+(PassView *)passViewFromXIBWithTitle:(NSString *)title
                              andType:(NSInteger )type;

@property (nonatomic,copy)usePhoneBlock block ;

@property (nonatomic,copy)SetPayPassBlock payBlock ;

@property (nonatomic,copy)payPassPayBlock usepayPassBlock  ;  //支付





- (void)showView  ;
@end
