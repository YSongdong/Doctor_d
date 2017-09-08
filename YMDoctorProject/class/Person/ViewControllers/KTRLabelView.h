//
//  KTRLabelView.h
//  kartor3
//
//  Created by huangjun on 16/5/11.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTRLabelView;

@protocol KTRLabelViewDelegate <NSObject>

-(void)labeView:(KTRLabelView *)labeView clickNumber:(NSInteger)clickNumber;

@end

@interface KTRLabelView : UIView

/**
 *  需要设置标签属性，需要先传属性，不然无法识别
 *
 * @[
 @{
 @"image_n":image,
 @"image_p":image,
 @"labelBackcolor_n":[uicolor red],
 @"labelBackcolor_p":[uicolor red],
 @"text":@"dsjfkdsjfkl"
 },
 
 @{
 @"image_n":[NSNull null],
 @"image_p":[NSNull null],
 @"backImage_n":[NSNull null],
 @"backImage_p":[NSNull null],
 @"text":@"dsjfkdsjfkl"
 },
 ];
 */

@property (nonatomic, copy)NSArray *labelData;//数据源
@property (nonatomic ,weak)id<KTRLabelViewDelegate> delegate;
@property (nonatomic ,assign)CGFloat borderalpha;//边框的透明度
@property (nonatomic ,assign)CGFloat borderWidth;//button的边框宽度
@property (nonatomic ,strong)UIColor* labelClock;//字体颜色
@property (nonatomic ,strong)UIColor *borderClock;//边框颜色
@property (nonatomic ,strong)UIColor *labelBackClock;//label背景颜色

@property (nonatomic ,assign)BOOL roundAngle;//圆角
@property (nonatomic, assign)CGFloat roundNumber;

@property(nonatomic,assign)BOOL showCancelImage;

/*
 
 @{
 @"labelFontSize":@(14.0),
 @"labelHeight":@(29),
 @"labelViewWidth":@(250),
 @"buttonEnable":@(0),//0 不能点击，1可以点
 @"btuuonTop":@(10),//上边距
 @"buttonBottom" :@(10),//下边距
 @"buttonRight"   :@(5),右边距
 @"spacedFontWidth":@(5)，字体到标签的宽度
 @"borderWidth":@1,//button的宽度
 }
 */
@property (nonatomic,copy)NSDictionary *labelProperty;//标签属性

/*
 
 
 @param  labelProperty
 
 @{
 @"labelFontSize":@(14.0),
 @"labelHeight":@(29),
 @"labelViewWidth":@(250),
 @"buttonEnable":@(0),//0 不能点击，1可以点
 @"btuuonTop":@(10),//上边距
 @"buttonBottom" :@(10),//下边距
 @"buttonRight"   :@(5),右边距
 @"spacedFontWidth":@(5)，字体到标签的宽度
 @"borderWidth":@1,//button的宽度
 }
 
 
 @param  labelData
 
 @[
 @{@"image_n":image,
 @"image_p":image,
 @"labelBackcolor_n":[uicolor red],
 @"labelBackcolor_p":[uicolor red],
 @"text":@"dsjfkdsjfkl"
 },
 
 @{@"image_n":[NSNull null],
 @"image_p":[NSNull null],
 @"backImage_n":[NSNull null],
 @"backImage_p":[NSNull null],
 @"text":@"dsjfkdsjfkl"
 },
 ];
 */

+(CGFloat)labelViewHeight :(NSDictionary *)labelProperty labelData:(NSArray *)labelData;


@end


@interface   KTRLabeViewButton :UIButton

@property(nonatomic,strong)UIColor *NormalColor;
@property(nonatomic,strong)UIColor *hlightedColor;


@end
