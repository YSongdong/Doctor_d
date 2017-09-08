//
//  OrderHeadView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "OrderHeadView.h"
#import "ListBtn.h"
#import "LineView.h"
@interface OrderHeadView ()

@property (nonatomic,strong)LineView *lineView ;
@property (nonatomic,assign)CGFloat buttonWidth ;
@property (nonatomic,assign)NSInteger totalCount ;
@end
@implementation OrderHeadView
- (void)setTitles:(NSArray *)titles {
    _titles = titles ;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIStackView class]]) {
            for (int index = 0 ;index < [view.subviews count] ;index ++) {
                UIView *subView = view.subviews[index];
                if ([subView isKindOfClass:[ListBtn class]]) {
                    ListBtn *listBtn = (ListBtn *)subView ;
                   [listBtn setTitle:titles[index]];
                    _buttonWidth = listBtn.width ;
                    listBtn.tag = 1000 + index ;
                    [listBtn addTarget:self action:@selector(didclickChoiceIndex:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
            }
        }
    }
}



- (void)didclickChoiceIndex:(ListBtn *)sender {

    
    
    ListBtn *btn = [self.subviews firstObject].subviews[_selectedIndex];
    
    if (sender.tag == 1000 + _selectedIndex) {
        return ;
    }
    
    [sender setSelected:YES andColor:[UIColor bluesColor]];
    [btn setSelected:NO andColor:[UIColor hightBlackClor ]];
    
    _selectedIndex = sender.tag - 1000 ;
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.centerX = sender.centerX;
        
        
    } completion:^(BOOL finished) {
    }];
    
    if (self.delegate) {
        [self.delegate selectedIndexChangeRequest];        
    }
}

- (void)layoutSubviews {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LineView class]]) {
        }
        if ([view isKindOfClass:[UIStackView class]]) {
            _totalCount = [view.subviews count];
            for (int index = 0 ;index < [view.subviews count]
                 ;index ++) {
                UIView *subView = view.subviews[_selectedIndex];
                if ([subView isKindOfClass:[ListBtn class]]) {
                    ListBtn *listBtn = (ListBtn *)subView;
                    [listBtn setSelected:YES andColor:[UIColor bluesColor]];
                    _lineView.width = _buttonWidth * 0.8 ;
                    self.lineView.centerX = listBtn.centerX;
                }
            }
        }
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self addSubview:self.lineView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex;
    
    [self layoutSubviews];
  //  [self layoutIfNeeded];
}

- (LineView *)lineView {
    if (!_lineView) {
        _lineView = [LineView LineViewWithPosition:
                     self.height - 1 andWidth:0];
        _lineView.height = 2 ;
        _lineView.backgroundColor = [UIColor bluesColor];
    }
    return _lineView ;
}
@end
