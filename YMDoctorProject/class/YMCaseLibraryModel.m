//
//  YMCaseLibraryModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseLibraryModel.h"

@implementation YMCaseLibraryModel

-(NSString *)case_title{
    if (_case_title) {
        return _case_title;
    }else{
        return @"";
    }
}


-(NSString *)case_time{
    if (_case_time) {
        return _case_time;
    }else{
        return @"";
    }
}
-(NSString *)page_view{
    if (_page_view) {
        return _page_view;
    }else{
        return @"";
    }
}

-(NSString *)case_desc{
    if (_case_desc) {
        return _case_desc;
    }else{
        return @"";
    }
}

@end
