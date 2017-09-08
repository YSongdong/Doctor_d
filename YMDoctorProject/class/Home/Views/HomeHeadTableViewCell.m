//
//  HomeHeadTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeHeadTableViewCell.h"
#import "MyTimer.h"
#import "SDCycleScrollView.h"
#import "CustomCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define BUTTON_COUNT 3

@interface HomeHeadTableViewCell ()<UIScrollViewDelegate,MyTimerDelegate,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *butotns ;

@property (nonatomic,assign)NSInteger imageCount ;

@property (nonatomic,assign)NSInteger currentIndex ;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;

@property (weak, nonatomic) IBOutlet UILabel *FirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIView *paggbackView;
@property (nonatomic,strong)MyTimer *timer ;

@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;

@property (nonatomic,strong) NSMutableArray *dataPicts;

@end

@implementation HomeHeadTableViewCell{
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
}
-(NSMutableArray *)dataPicts
{

    if (!_dataPicts) {
        _dataPicts = [NSMutableArray array];
        
    }
    return _dataPicts;

}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self loadButtonView];
//        _scrollView.delegate = self ;
//        self.paggbackView.backgroundColor = [UIColor clearColor];
//        _timer =  [MyTimer myTimer];
//        [_timer setTimeInterval:5];
//        _timer.delegate = self ;
       // [self initScrollView];
    }
    return self;
}
- (NSMutableArray *)butotns {
    
    if (!_butotns) {
        _butotns  = [NSMutableArray array];
    }
    return _butotns ;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self loadButtonView];
    
//    _scrollView.delegate = self ;
//    self.paggbackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
//    _timer =  [MyTimer myTimer];
//    [_timer setTimeInterval:5];
//    _timer.delegate = self ;
}

-(void)initScrollView
{

    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, h) imageURLStringsGroup:[_dataPicts copy]];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; 
    cycleScrollView.pageDotColor = [UIColor lightGrayColor];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self addSubview:cycleScrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.width * BUTTON_COUNT, self.scrollView.height) ;
}

- (void)setPictures:(NSArray *)pictures {
    
     _pictures = pictures ;
    
    [self.dataPicts removeAllObjects];
    
    for (int i = 0; i < pictures.count; i ++) {
        NSInteger index = (i - 1 + _currentIndex +  _pictures.count) % _pictures.count;
        [self.dataPicts addObject:_pictures[index][@"pic"] ];
    }

    [self initScrollView];
 
}

- (void)loadButtonView {
    
    for (int i = 0; i < BUTTON_COUNT; i ++) {
        
        UIButton *buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scrollView addSubview:buttonView];
        buttonView.contentMode = UIViewContentModeScaleAspectFill ;
        buttonView.contentScaleFactor = [UIScreen mainScreen].scale;
        buttonView.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
        buttonView.clipsToBounds = YES ;
        [buttonView addTarget:self action:@selector(clickSHowInfoWithImageView:) forControlEvents:UIControlEventTouchUpInside];
        [self.butotns addObject:buttonView];
    }
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    self.pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];

}


- (void)loadImageWithImageName {
    
    for (int i = 0; i < BUTTON_COUNT; i++)
    {
        NSInteger index = (i - 1 + _currentIndex +
                           self.pictures.count)
        % self.pictures.count;
        UIButton *button = self.butotns[i];
        button.frame = CGRectMake(WIDTH * i, 0, WIDTH,self.scrollView.height);
        [button sd_setImageWithURL:[NSURL URLWithString:self.pictures[index][@"pic"]] forState:UIControlStateNormal];
    }
    self.scrollView.contentOffset = CGPointMake( WIDTH, 0);
    self.pageControll.currentPage = _currentIndex ;
    [self.scrollView addSubview:self.pageControll];
    self.title1.text = self.pictures[_currentIndex][@"titles"];
    self.title2.text = self.pictures[_currentIndex][@"jianj"];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [_timer startTimer];
}

-(void)pageLeft
{
    _currentIndex = (--_currentIndex + self.pictures.count) %
    self.pictures.count;
    [self loadImageWithImageName];
}
- (void)pageRight
{
    _currentIndex = (++_currentIndex + self.pictures.count) %
    self.pictures.count;
    [self loadImageWithImageName];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.scrollView.contentOffset.x <= 0) {
        [self pageLeft];
    }
    else if(self.scrollView.contentOffset.x >=CGRectGetWidth(scrollView.bounds) * (BUTTON_COUNT - 1))
    {
        [self pageRight];
    }

}

- (void)changePageWhentimerStart {
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.block ){
        self.block(self.pictures[_currentIndex][@"pic_url"]);
    }

}
- (void)clickSHowInfoWithImageView:(UIButton *)sender {
    if(self.block ){
        self.block(self.pictures[_currentIndex][@"pic_url"]);
    }
}

@end
