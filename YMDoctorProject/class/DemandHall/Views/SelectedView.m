//
//  SelectedView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//


#define LINE_WIDTH 1
#define LIST_COUNT 4
#define Button_TAG 1000
#import "SelectedView.h"
#import "ListBtn.h"

@interface SelectedView ()

@property (nonatomic,assign)NSMutableArray *btnLists ;


@end

@implementation SelectedView



- (void)awakeFromNib{
    
    [super awakeFromNib];
  //  NSLog(@"----");
    [self addSubView];
}



- (void)layoutSubviews {
    

    int index  = 0 ;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[ListBtn class]]) {
            ListBtn *listBtn = (ListBtn *)view;
            listBtn.width = (WIDTH - (LIST_COUNT - LINE_WIDTH))/ LIST_COUNT ;
            listBtn.height = self.height ;
            listBtn.x = index * (listBtn.width + LINE_WIDTH);
            [listBtn layoutSubviews];
            index ++ ;
        }
    }
}

- (void)addSubView {
    
//    NSArray *titles =@[@"综合 ",@"科室 ",@"职称 ",@"区域  "];
    NSArray *titles =@[@"科室 ",@"金额 ",@"结束时间 ",@"职称  "];

    for (int i = 0; i < 4; i ++) {
        ListBtn *listBtn = [[ListBtn alloc]init];
        [listBtn attributeStringWithTitle:titles[i]];
        listBtn.tag = Button_TAG + i ;
        [listBtn addTarget:self action:@selector(clickShowListView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:listBtn];

    }
}
- (void)setDefaultTitle{
    
    ListBtn *btn1 = self.subviews[1];
    ListBtn *btn2 = self.subviews[2];
    ListBtn *btn3 = self.subviews[3];
    [btn1 attributeStringWithTitle:@"科室 "];
    [btn2 attributeStringWithTitle:@"职称 "];
    [btn3 attributeStringWithTitle:@"区域 "];
}


- (void)setTitle:(NSString *)title {
    
    UIView *view = self.subviews[_selectedIndex];
    ListBtn *btn = (ListBtn *)view ;
    [btn attributeStringWithTitle: [NSString stringWithFormat:@"%@  ",title]];
}
//lick event
- (void)clickShowListView:(UIButton *)sender {
    
    _selectedIndex = sender.tag - Button_TAG ;
    self.block(_selectedIndex);
}

@end
