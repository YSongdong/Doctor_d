//
//  HY2tabbarView.m
//  changjiahui
//
//  Created by 张利 on 2017/4/20.
//  Copyright © 2017年 张利. All rights reserved.
//

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#import "HY3TabbarView.h"
#import "HYTabbarCollectionCell.h"

#define HYScreenW [UIScreen mainScreen].bounds.size.width
#define HYScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat const topBarItemMargin = 15; ///标题之间的间距
static CGFloat const topBarHeight = 40; //顶部标签条的高度

@interface HY3TabbarView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,strong) NSMutableArray * buttons;

@property (nonatomic,strong) NSMutableArray * subViewControllers;
@property (nonatomic,weak) UIScrollView * tabbar;
@property (nonatomic,weak) UICollectionView * contentView;
@property (nonatomic,assign) NSInteger  selectedIndex;
@property (nonatomic,assign) NSInteger  preSelectedIndex;
@property (nonatomic,assign) CGFloat  tabbarWidth; //顶部标签条的宽度
@property (nonatomic,strong)UIView *line;

@end

@implementation HY3TabbarView

#pragma mark - ************************* 重写构造方法 *************************
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = 0;
        _preSelectedIndex = 0;
        _tabbarWidth = topBarItemMargin;
        self.backgroundColor = [UIColor magentaColor];
        [self setUpSubview];
    }
    return self;
}
#pragma mark - ************************* 懒加载 *************************

- (NSMutableArray *)titles{
    
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)subViewControllers{
    
    if (!_subViewControllers) {
        _subViewControllers = [NSMutableArray array];
    }
    return _subViewControllers;
}

#pragma mark -   ************************* UI处理 *************************
//添加子控件
- (void)setUpSubview{
    
    UIScrollView * tabbar = [[UIScrollView alloc]init];
    [self addSubview:tabbar];
    self.tabbar = tabbar;
    tabbar.showsHorizontalScrollIndicator = NO;
    tabbar.showsVerticalScrollIndicator = NO;
    _tabbar.backgroundColor = [UIColor whiteColor];
    tabbar.bounces = NO;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置layout 属性
    layout.itemSize = (CGSize){self.bounds.size.width,(self.bounds.size.height - topBarHeight)};
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    UICollectionView * contentView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:contentView];
    
    self.contentView = contentView;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    
    contentView.dataSource = self;
    contentView.delegate = self;
    
    //注册cell
    [contentView registerClass:[HYTabbarCollectionCell class] forCellWithReuseIdentifier:@"HYTabbarCollectionCell"];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,58, SCREEN_WIDTH/3, 2)];
    
    line.backgroundColor = RGB(53, 120, 184, 1);
    [self addSubview:line];
    self.line = line;
}

//布局子控件
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGRect rect = self.bounds;
    self.tabbar.frame = CGRectMake(0, 20, rect.size.width, topBarHeight);
    self.tabbar.contentSize = CGSizeMake(_tabbarWidth, 0);
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.tabbar.frame), rect.size.width,(self.bounds.size.height - topBarHeight));
    CGFloat btnH = topBarHeight;
    CGFloat btnX = topBarItemMargin;
    for (int i = 0 ; i < self.titles.count; i++) {
        
        UIButton * btn = self.titles[i];
        btn.frame = CGRectMake(btnX, 5, btn.frame.size.width, btnH-10);
        btnX += btn.frame.size.width + topBarItemMargin;
    }
    [self itemSelectedIndex:0];//
}

#pragma mark - ************************* 代理方法 *************************
//CollectionViewDataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.subViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYTabbarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYTabbarCollectionCell" forIndexPath:indexPath];
    
    cell.subVc = self.subViewControllers[indexPath.row] ;
    return cell;
}

//UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self endEditing:YES];
    if(self.selectedIndex != (scrollView.contentOffset.x + HYScreenW * 0.5) / HYScreenW){
        self.selectedIndex = (scrollView.contentOffset.x + HYScreenW * 0.5) / HYScreenW;
    }
}

#pragma mark - ************************* Private方法 ************************
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        //设置按钮选中
        [self itemSelectedIndex:self.selectedIndex];
    }
}

-(void)updateLineXWithBtn:(UIButton*)btn{
    self.line.x = btn.x-65/6;
}

- (void)itemSelectedIndex:(NSInteger)index{
    
    UIButton * preSelectedBtn = self.titles[_preSelectedIndex];
    preSelectedBtn.selected = NO;
    _selectedIndex = index;
    _preSelectedIndex = _selectedIndex;
    UIButton * selectedBtn = self.titles[index];
    selectedBtn.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        preSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIButton * btn = self.titles[self.selectedIndex];
        // 计算偏移量
        CGFloat offsetX = btn.center.x - HYScreenW * 0.5;
        if (offsetX < 0) offsetX = 0;
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.tabbar.contentSize.width - HYScreenW;
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        // 滚动标题滚动条
        [self.tabbar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
}

- (void)itemSelected:(UIButton *)btn{
    
    [self updateLineXWithBtn:btn];
    
    NSInteger index = [self.titles indexOfObject:btn];
    [self itemSelectedIndex:index];
    self.selectedIndex = index;
    self.contentView.contentOffset = CGPointMake(index * self.bounds.size.width, 0);
}

#pragma mark - ************************* 对外接口 *************************
//外界传个控制器,添加一个栏目    
- (void)addSubItemWithViewController:(UIViewController *)viewController{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0,0, (SCREEN_WIDTH-65)/3, 40);
    [self.tabbar addSubview:btn];
    
    
    [self.titles addObject:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setupBtn:btn withTitle:viewController.title];
    [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.subViewControllers addObject:viewController];
}

// 设置顶部标签按钮
- (void)setupBtn:(UIButton *)btn withTitle:(NSString *)title{
    
    [btn setTitle:title forState:UIControlStateNormal];
    //    [btn sizeToFit];
    _tabbarWidth += btn.frame.size.width + topBarItemMargin;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:RGB(103, 103, 103, 1) forState:UIControlStateNormal];
    [btn setTitleColor:RGB(53, 120, 184, 1) forState:UIControlStateSelected];
//    [btn setBackgroundImage:[ImageUtil imageWithColor:RGB(255, 255, 255, 1) andSize:CGSizeMake((SCREEN_WIDTH-65)/3, 30)] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[ImageUtil imageWithColor:RGB(233, 132, 1, 1) andSize:CGSizeMake((SCREEN_WIDTH-65)/3, 30)] forState:UIControlStateSelected];
    
//    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
}


@end

