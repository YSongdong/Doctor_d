//
//  YMSearchView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/20.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMSearchView.h"
#import "NSString+BitusStringUtils.h"
#import "Masonry.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface YMSearchView ()<UITextFieldDelegate>

@property (nonatomic,strong)UILabel *placeholderText;//搜索字体

@property (nonatomic,strong)UIImageView *magnifierImageView;//放大镜图标

@property (nonatomic,assign)CGFloat iconWidth;  //搜索栏头像宽度

@property (nonatomic,assign)CGFloat iconHeight; //搜索栏头像高度

@property(nonatomic,strong)UILabel *searchdefaultTitle;

@property(nonatomic,strong)UIView *verticalLineView;

@property(nonatomic,strong) UIImage *magnifierImage;

@property(nonatomic,strong)UIButton *searchButton;

@end

@implementation YMSearchView

#pragma  mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self _initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initView];
}

#pragma mark - initView

-(void)_initView{
    
    self.userInteractionEnabled = YES;
    UIView * searcView = [[UIView alloc]init];
    searcView.backgroundColor = [UIColor clearColor];
    [self addSubview:searcView];
    [searcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _magnifierImage = [UIImage imageNamed:@"搜索"];
    
    //放大镜
    _magnifierImageView = [[UIImageView alloc]init];
    _magnifierImageView.image = _magnifierImage;
    [searcView addSubview:_magnifierImageView];
    [_magnifierImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.mas_equalTo(_magnifierImage.size.width);
        make.height.mas_equalTo(_magnifierImage.size.height);
        make.centerY.mas_equalTo(@0);
    }];
    
    _placeholderText = [[UILabel alloc]init];
    _placeholderText.text = [NSString isEmpty:_placeholderStr] ? @"请输入您要显示的内容":_placeholderStr;
    _placeholderText.textColor = RGBCOLOR(153, 153, 153);
   
    _placeholderText.font = [UIFont systemFontOfSize:13];
    [searcView addSubview:_placeholderText];
    
    [_placeholderText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_magnifierImageView.mas_right);
        make.centerY.equalTo(_magnifierImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    _searchdefaultTitle = [[UILabel alloc]init];
    _searchdefaultTitle.font = [UIFont systemFontOfSize:13];
    _searchdefaultTitle.textAlignment = NSTextAlignmentCenter;
    _searchdefaultTitle.textColor = RGBCOLOR(153, 153, 153);
    _searchdefaultTitle.text = @"搜索";
    [searcView addSubview:_searchdefaultTitle];
    [_searchdefaultTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searcView.mas_right).offset(-10);
        make.top.bottom.equalTo(searcView);
        make.width.mas_offset([_searchdefaultTitle intrinsicContentSize].width);
    }];
    
    _verticalLineView = [[UIView alloc]init];
    _verticalLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [searcView addSubview:_verticalLineView];
    [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_searchdefaultTitle.mas_left).offset(-5);
        make.top.equalTo(searcView.mas_top).offset(5);
        make.bottom.equalTo(searcView.mas_bottom).offset(-5);
        make.width.mas_offset(1);
    }];
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.delegate = self;
    _searchTextField.textColor = RGBCOLOR(51 , 51, 51);
    _searchTextField.font = [UIFont systemFontOfSize:16];
     _searchTextField.tintColor = [UIColor blackColor];
    _searchTextField.backgroundColor = [UIColor clearColor];
    [_searchTextField addTarget:self
                         action:@selector(textChanged:)
               forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    _searchButton = [[UIButton alloc]init];
    _searchButton.backgroundColor = [UIColor clearColor];
    _searchButton.hidden = YES;
    [_searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchButton];
    [_searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.showRightSerarch = NO;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_magnifierImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];
    [_placeholderText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_magnifierImageView.mas_right).offset(10);
    }];
    _magnifierImageView.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(searchView:begingEdit:)]) {
        [self.delegate searchView:self begingEdit:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([NSString isEmpty:self.searchTextField.text]) {
        _magnifierImageView.hidden = NO;
        
    }
    [_magnifierImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    [_placeholderText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_magnifierImageView.mas_right).offset(0);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    return YES;
}



#pragma mark - 显示或者隐藏放大镜和搜索文字
-(void)showOrHiddenMagnifierAndSearchStr{
    
    if ([NSString isEmpty:self.searchTextField.text]) {
        _placeholderText.hidden = NO;
    }else{
        _placeholderText.hidden = YES;
    }
}

#pragma mark - 显示放大镜和搜索文字
-(void)showMagnifieAndSearchStr{
    if ([NSString isEmpty:self.searchTextField.text]) {
        _placeholderText.hidden = NO;
        _magnifierImageView.hidden = NO;
    }
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}

-(void)textChanged:(UITextField *)textField{
    if (textField.text.length >0) {
        [self showOrHiddenMagnifierAndSearchStr];
    }else{
        [self showMagnifieAndSearchStr];
    }
}

-(void)searchClick:(UIButton *)sender{
    
    NSLog(@"搜索框点击");
    if ([self.delegate respondsToSelector:@selector(SearchView:headerSearchButton:)]) {
        [self.delegate SearchView:self headerSearchButton:sender];
    }
}

#pragma mark - setter

-(void)setShowRightSerarch:(BOOL)showRightSerarch{
    if (showRightSerarch) {
        _searchdefaultTitle.hidden = NO;
        _verticalLineView.hidden = NO;
    }else{
        _searchdefaultTitle.hidden = YES;
        _verticalLineView.hidden = YES;
    }
}
-(void)setShowSearchButton:(BOOL)showSearchButton{
    _searchButton.hidden = !showSearchButton;
}

-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _placeholderText.text = placeholderStr;
}

-(NSString *)textFieldStr{
    return _searchTextField.text;
}


@end
