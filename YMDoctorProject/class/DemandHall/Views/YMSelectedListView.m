//
//  YMSelectedListView.m
//  doctor_user
//
//  Created by kupurui on 2017/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSelectedListView.h"

#define Butotn_Height 40

typedef void(^ClickBlock)(id value,ListType type);
@interface YMSelectedListView ()
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,strong)UIScrollView *scrollView ;
@property (nonatomic,copy)ClickBlock block ;
@end

CGFloat max_height  ;
@implementation YMSelectedListView
+  (YMSelectedListView *)viewWithDataList:(NSArray *)dataList
                                     type:(ListType)type
                             andViewWidth:(CGFloat)width
                                  start_Y:(CGFloat)start_y
                               andStart_X:(CGFloat)start_x
                        andCommpleteBlock:(void(^)(id value,ListType type))commplete{

    YMSelectedListView *view = [[YMSelectedListView alloc]init];
    view.start_X = start_x ;
    view.start_Y = start_y ;
    view.type = type ;
    view.viewWidth = width ;
    view.block = commplete ;
    [view configUI];
    view.dataList = dataList ;
    return view ;
}

- (void)configUI {
    _scrollView = [UIScrollView new];
    _scrollView.frame = self.bounds ;
    [self addSubview:_scrollView];
    self.backgroundColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1];
    self.layer.borderColor = self.backgroundColor.CGColor ;
    self.layer.borderWidth = 1 ;
    self.frame = CGRectMake(_start_X, _start_Y, _viewWidth, 0);
}

- (void)setDataList:(NSArray *)dataList {
    
    _dataList = dataList;
    NSInteger count = [dataList count];
     CGFloat maxHeight =( 5 * Butotn_Height +1) + 1;
    for (int i = 0; i < count; i ++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:dataList[i][@"ename"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_scrollView addSubview:btn];
        btn.frame = CGRectMake(0, 1 +( Butotn_Height+1) * i,_viewWidth,Butotn_Height);
        btn.tag = 1000 + i ;
        [btn addTarget:self action:@selector(didclick_btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn ];
    }
    UIView *view  = [_scrollView.subviews lastObject] ;
    if (CGRectGetMaxY(view.frame) > maxHeight) {
        max_height = maxHeight ;
        self.scrollView.scrollEnabled = YES ;
    }else {
        max_height = CGRectGetMaxY(view.frame);
        self.scrollView.scrollEnabled = NO ;
    }
    self.frame = CGRectMake(_start_X, _start_Y, _viewWidth, max_height);
    self.scrollView.frame = self.bounds ;
    self.scrollView.contentSize = CGSizeMake(_viewWidth, CGRectGetMaxY(view.frame) + 1);
}

- (void)didclick_btnEvent:(UIButton *)sender {
    
    if (self.block) {
        self.block(self.dataList[sender.tag - 1000],self.type);
    }
    [self removeFromSuperview];
}

@end
