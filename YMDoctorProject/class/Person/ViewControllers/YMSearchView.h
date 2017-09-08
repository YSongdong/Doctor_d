//
//  KTRUserHeadSearchBar.h
//  kartor3
//
//  Created by jun huang on 16/8/16.
//  Copyright © 2016年 CST. All rights reserved.
//  搜索控件，点击用户后，将头像添加到搜索栏上

#import <UIKit/UIKit.h>

@class YMSearchView;

@protocol YMSearchViewDelegate <NSObject>

@optional
//搜索栏中头像点击的代理
-(void)SearchView:(YMSearchView *)SearchView headerSearchButton:(UIButton *)headerSearchButton;

-(void)searchView:(YMSearchView *)SearchView begingEdit:(BOOL)begingEdit;

@end

@interface YMSearchView : UIView


@property(nonatomic, copy)NSString *placeholderStr;//搜索框中显示的字符

@property(nonatomic,assign)BOOL showRightSerarch;

@property(nonatomic,assign)BOOL showSearchButton;

@property(nonatomic,weak)id<YMSearchViewDelegate> delegate;

@property(nonatomic,strong)UITextField *searchTextField;

//-(void)showOrHiddenMagnifierAndSearchStr;//在输入文字的时候调用

//-(void)showMagnifieAndSearchStr;//通过代码的方式将TextField中字段赋值为空（@"")时候调用
//-(NSString *)textFieldStr;

@end
