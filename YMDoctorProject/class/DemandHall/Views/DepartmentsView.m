//
//  DepartmentsView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DepartmentsView.h"
#import "UIButton+CommonButton.h"
#define Button_Height 45
@interface DepartmentsView ()
@property (nonatomic,strong)NSArray *datalist ;
@property (nonatomic,strong)UIScrollView *leftScro ;
@property (nonatomic,strong)UIScrollView *rightScro;
@property (nonatomic,assign)NSInteger selectedIndex ;
@property (nonatomic,assign)NSInteger detailSelected ;
@property (nonatomic,strong)NSArray *detaiDepart ;



@end

@implementation DepartmentsView

+ (DepartmentsView *)DepartmentsViewWithDic:(NSArray *)dataList {
    
    DepartmentsView *view = [[DepartmentsView alloc]init];
    view.datalist = dataList;
    view.selectedIndex = 0 ;
    return view ;
}

- (void)showOnSuperView:(UIView *)view subViewStartY:(CGFloat)y{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, _start_y, Screen_WIDTH, Screen_HEIGHt - _start_y)];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [backgroundView addGestureRecognizer:gesture];
    [view addSubview:backgroundView];
    [backgroundView addSubview:self];
    [self setViewFrame:y];
}

- (void)setViewFrame:(CGFloat)y {
    
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(WIDTH,y, self.superview.width - _viewOffsetX,self.superview.height - y);
    UIScrollView *leftScrollView = [[UIScrollView alloc]init];
    leftScrollView.frame = CGRectMake(0, 0, self.width/2,
                                 self.height);
    _leftScro = leftScrollView ;
    UIScrollView *rightScroller =[[UIScrollView alloc]initWithFrame:CGRectMake(self.width/2,0, self.width/2, self.height)];
    _leftScro.showsVerticalScrollIndicator = NO ;
    _rightScro = rightScroller ;
    _rightScro.showsVerticalScrollIndicator = NO ;
    [self addSubview:leftScrollView];
    [self addSubview:rightScroller];
    for (int i = 0; i < [self.datalist  count]; i ++) {
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];        
        [btn setTitle:self.datalist[i][@"ename"]
             forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftScrollView addSubview:btn];
        btn.frame = CGRectMake(0,i * Button_Height, leftScrollView.width,Button_Height - 1);
        [btn selected:NO andBackgroundColor:[UIColor colorWithRGBHex:0xf0eff5]];
        [btn setTitle:15];
        btn.tag = i + 1000 ;
        if (i == 0){
            [btn selected:YES andBackgroundColor:[UIColor whiteColor]];
        [self loadDetailDepartmentWithSelctedIndex:_selectedIndex];
            
        }
        [btn addTarget:self action:@selector(didClickShowDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGFloat max_height = CGRectGetMaxY(_leftScro.subviews.lastObject.frame);
        _leftScro.panGestureRecognizer.delaysTouchesBegan = YES;
    _leftScro.contentSize = CGSizeMake(_leftScro.width, max_height + 100);
    [self showAnimation];
}
- (void)pan {
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex ;
    _detaiDepart = self.datalist[selectedIndex][@"child"];
}

- (void)showAnimation {
    
    [UIView animateWithDuration:0.25 animations:^{
         self.transform = CGAffineTransformMakeTranslation(-self.width, 0);
    }];
}

-(void)didClickShowDetail:(UIButton *)sender {
    
    UIButton *btn = [_leftScro viewWithTag:_selectedIndex + 1000];
    if (sender.tag == _selectedIndex + 1000) {
        return ;
    }
    self.selectedIndex = sender.tag - 1000 ;
    [btn selected:NO andBackgroundColor:[UIColor colorWithRGBHex:0xf0eff5]];
    [sender selected:YES andBackgroundColor:[UIColor whiteColor]];
    [self loadDetailDepartmentWithSelctedIndex:_selectedIndex];
}

- (void)loadDetailDepartmentWithSelctedIndex:(NSInteger )selected {
    
    for (UIView *view in _rightScro.subviews) {
        [view removeFromSuperview];
    }
    NSArray *data = self.datalist[_selectedIndex][@"child"];
    for (int i = 0; i < [data count]; i ++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:data[i][@"ename"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:15];
        btn.frame = CGRectMake(0, i * Button_Height, _rightScro.width, Button_Height);
        [_rightScro addSubview:btn];
        [btn addTarget:self action:@selector(didclickChoiceLast:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i ;
    }
    _rightScro.contentSize = CGSizeMake(_rightScro.width, CGRectGetMaxY(_rightScro.subviews.lastObject.frame) + 100);
}

- (void)didclickChoiceLast:(UIButton *)sender {
    if (self.block) {
        self.block(_detaiDepart[sender.tag - 2000],
                   self.datalist[_selectedIndex][@"disorder"]);
    }
    [self hiddenView];
}


- (void)hiddenView {
    UIView *view = self.superview ;
    if ([view.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scr = (UIScrollView *)view.superview ;
        scr.scrollEnabled = YES ;
    }
    
    [self removeFromSuperview];
    [view removeFromSuperview];
    view = nil ;
}


@end
