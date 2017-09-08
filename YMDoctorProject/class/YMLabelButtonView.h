//
//  YMLabelButtonView.h
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LabelDefaultViewType,//可点击，可选择，
    LabelShowViewType,//只显示 没有换一换按钮
} LabelViewType;

@class YMLabelButtonView;
@protocol YMLabelButtonViewDelegate <NSObject>

-(void)labelButtonView:(YMLabelButtonView *)labelButtonView replaceClick:(UIButton *)sender;

-(void)labelButtonView:(YMLabelButtonView *)labelButtonView slectLabelArr:(NSMutableArray  *)slectLabelArr;

@end

@interface YMLabelButtonView : UIView

@property(nonatomic,strong)NSArray *labelArry;

@property(nonatomic,strong)NSMutableArray *selectTagArry;

@property(nonatomic,weak)id<YMLabelButtonViewDelegate> delegate;

@property(nonatomic,assign)LabelViewType type;

//+(CGFloat)labelButtonHeight:(NSArray *)labelArry selfWidth:(CGFloat)width;

+(CGFloat)labelButtonHeight:(NSArray *)labelArry selfWidth:(CGFloat)width labelViewType:(LabelViewType)type;

@end
