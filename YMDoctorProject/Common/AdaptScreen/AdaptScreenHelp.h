//
//  AdaptScreenHelp.h
//  屏幕适配
//
//  Created by rimi on 15/10/14.
//  Copyright © 2015年 任佳鑫. All rights reserved.
//

#ifndef AdaptScreenHelp_h
#define AdaptScreenHelp_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LS_INLINE static inline
#define Screen_WIDTH  [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHt  [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

//静态全局变量_在后面

static const CGFloat originWidth_ = 375;
static const CGFloat originHeight_ = 667;

/**
 *  水平方向的比例计算
 *
 *  @param value 当前屏幕的值
 *
 *  @return 等比例是配置后的值
 */

LS_INLINE CGFloat HorizontalRatio(){
    return  Screen_WIDTH / originWidth_ ;
    
}
/**
 *  垂直方向的比例计算
 *
 *  @param value 当前屏幕的值
 *
 *  @return 等比例是配置后的值
 */
LS_INLINE CGFloat VerticalRatio(){
    return Screen_HEIGHt / originHeight_;
}


/**
 *  通过frame计算center
 *
 *  @param frame frame
 *
 *  @return 计算出该frame的center
 */

LS_INLINE CGPoint centerFromFrame(CGRect frame){
    return CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
}
/**
 *  通过center计算frame
 *
 *  @param size   size
 *  @param center center
 *
 *  @return 确定的frame
 */
LS_INLINE CGRect frameWithSizeAndCenter(CGSize size, CGPoint center){
    return CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
}

/**
 *  等比例适配center
 *
 *  @param center center
 *
 *  @return 返回等比例之后的center
 */
LS_INLINE CGPoint flexibleCenter(CGPoint center){
    CGFloat x = center.x * HorizontalRatio();
    CGFloat y = center.y * VerticalRatio();
    return CGPointMake(x, y);
}

/**
 *  等比例适配size
 *
 *  @param size        基准屏幕下的size
 *  @param adjustWidth if adjusWidth is yes, return size.width * VerticalRatio, size.height * VerticalRatio ; if adjusWidth is no, return size.width * HorizontalRatio, size.height * VerticalRatio;
 *
 *  @return 适配后的size
 */
LS_INLINE CGSize flexibleSize(CGSize size,BOOL adjustWidth){
    if (adjustWidth) {
        return  CGSizeMake(size.width * VerticalRatio(), size.height * VerticalRatio());
    }
    return  CGSizeMake(size.width * HorizontalRatio(), size.height * VerticalRatio());
}

/**
 *  等比例适配frame
 *
 *  @param frame       基准屏幕下的frame
 *  @param adjustWidth if adjusWidth is yes, return size.width * VerticalRatio, size.height * VerticalRatio ; if adjusWidth is no, return   size.width * HorizontalRatio, size.height * VerticalRatio;
 *
 *  @return 适配后的frame
 */

LS_INLINE CGRect flexibelFrame(CGRect frame ,BOOL adjustWidth){
    //拿到frame的center,然后对x和y进行缩放
    CGPoint center = centerFromFrame(frame);
    center = flexibleCenter(center);
    
    //对宽高比例缩放
    CGSize size = flexibleSize(frame.size, adjustWidth);
    
    
    //用上面的比例缩放后的center和size组成一个frame
    return frameWithSizeAndCenter(size, center);
}

#endif /* AdaptScreenHelp_h */
