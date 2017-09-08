//
//  AllNavigationViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/9.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "AllNavigationViewController.h"

@interface AllNavigationViewController ()

@end

@implementation AllNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (void)initialize
{
    if (self == [AllNavigationViewController class]) {
        UINavigationBar *bar = [UINavigationBar appearance];
        [bar setTintColor:[UIColor whiteColor]];
        [bar setBarTintColor:[UIColor colorWithHexString:@"#3d85cc"]];
       // [bar setBarTintColor:[UIColor colorWithRed:60.0/255 green:134.0/255 blue:206.0/255 alpha:1]];
        [bar setBarStyle:UIBarStyleBlack];
        
    }//4BA6FF
}

@end
