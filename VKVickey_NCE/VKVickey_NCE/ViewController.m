//
//  ViewController.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/3.
//  Copyright © 2016年 Leou. All rights reserved.
//


/**
 *  就是一个测试文件
 *
 *
 */

#import "ViewController.h"

#import "AFNetworking.h"

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    
    UITableView *skTableVie;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    https://napi.vickeynce.com /nce4cast/list
    
//    NSDictionary * parameters=[[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"cate_id", @"1", @"p", nil];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager GET:@"https://napi.vickeynce.com/nce4cast/list" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        NSURL *urls = [NSURL URLWithString:@"https://napi.vickeynce.com/nce4cast/list"];
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSURL *urls = [NSURL URLWithString:@"https://napi.vickeynce.com/nce4cast/list"];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSURL *urls = [NSURL URLWithString:@"https://napi.vickeynce.com/nce4cast/list"];
//        
//    }];
    
    skTableVie = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    skTableVie.delegate = self;
    skTableVie.dataSource = self;
    [self.view addSubview:skTableVie];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //用于去除导航栏的底线，也就是周围的边线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self skSetupNaviBarStatus:YES willHiddenHeight:100 overlayViewColor:[UIColor blackColor]];
    [self scrollViewDidScroll:skTableVie];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    //重置:之所以在viewDidDisappear里面重置，是因为如果重置之后跳转页面的时候导航会直接蹦出来
    [self skResetNaviBarAllStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"bilibilibilibilibili...";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self skNavigationBarAlphaChangedWithContentOffsetY:scrollView.contentOffset.y completed:^(BOOL skSucc) {
        
        if (skSucc) {
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }];
}

@end
