//
//  YMCaseLibraryModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMCaseLibraryModel : NSObject
@property(nonatomic,copy)NSString *case_id;//案例ID
@property(nonatomic,copy)NSString *case_title;//案例标题
@property(nonatomic,copy)NSString *case_time;//时间
@property(nonatomic,copy)NSString *case_desc;//描述
@property(nonatomic,copy)NSString *case_thumb;//图片
@property(nonatomic,copy)NSString *page_view;//浏览量

@end
