//
//  SKTabHomeViewController.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/22.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "SKTabHomeViewController.h"

//collection 布局
#import "SKTabHomeViewLayout.h"

/** 轮播图 */
#import "SKAdScrollView.h"

@interface SKTabHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UICollectionView  *skCollectionView;
}

/** collectionView布局 */
@property (strong, nonatomic)SKTabHomeViewLayout *skLayout;

@end

@implementation SKTabHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, -64, UISCREEN_WEIGHT, UISCREEN_HEIGHT + 64);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 100);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(12, 10, 10, 10);
    
    CGRect skCollectionViewFrame = CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.height);
    skCollectionView = [[UICollectionView alloc] initWithFrame:skCollectionViewFrame collectionViewLayout:self.skLayout];
    skCollectionView.dataSource = self;
    skCollectionView.delegate = self;
    skCollectionView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [skCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:skCollectionView];
//    [skCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        UIEdgeInsets padding = UIEdgeInsetsMake(-64, 0, 0, 0);
//        make.edges.mas_equalTo(padding);
//    }];
    
    
    [skCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [skCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    /** 增加下拉刷新事件 */
    skCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData:)];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //用于去除导航栏的底线，也就是周围的边线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self skSetupNaviBarStatus:YES willHiddenHeight:64 overlayViewColor:[UIColor blackColor]];
    [self scrollViewDidScroll:skCollectionView];
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

#pragma mark - 数据刷新加载
/** 下拉刷新 */
- (void)refreshNewData:(id)sender {
    
    [skCollectionView.mj_header endRefreshing];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1) {
        
        return 2;
    }else if (section == 2) {
        
        return 4;
    }else {
        
        return 4;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor clearColor];
        
        reusableview = headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor clearColor];
        
        reusableview = footerView;
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    if (indexPath.section == 0) {
        
        SKAdScrollView *adScrollView = [cell.contentView viewWithTag:1000];
        if (!adScrollView) {
            
            adScrollView = [[SKAdScrollView alloc] initWithFrame:cell.bounds];
            adScrollView.tag = 1000;
            [cell.contentView addSubview:adScrollView];
            
            adScrollView.skImagesUrlArray = [NSArray arrayWithObjects:@"http://pic36.nipic.com/20131128/11748057_141932278338_2.jpg", @"http://img05.tooopen.com/images/20140604/sy_62331342149.jpg", @"http://pic44.nipic.com/20140721/11624852_001107119409_2.jpg", @"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg", nil];
            
            adScrollView.skAdTitleArray = [NSArray arrayWithObjects:@"你好", @"你好好", @"你好好好", @"你好好好好", nil];
        }
    }else if (indexPath.section == 1) {
        
        UIImageView *everydayImageView = [cell.contentView viewWithTag:(2000 + indexPath.row)];
        if (!everydayImageView) {
            
            UIImage *everydayImage;
            if (indexPath.row == 0) {
                
                everydayImage = [UIImage imageNamed:@"home_everyday_reading"];
            }else {
                everydayImage = [UIImage imageNamed:@"home_everyday_word_pk"];
            }
            everydayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width/2-10), everydayImage.size.height * ((self.view.bounds.size.width/2-10) / everydayImage.size.width))];
            everydayImageView.center = cell.contentView.center;
            everydayImageView.tag = (2000 + indexPath.row);
            [cell.contentView addSubview:everydayImageView];
            
            everydayImageView.image = everydayImage;
        }
        
    }
    return cell;
}

#pragma mark UICollectionViewDelegate
/** UICollectionView被选中时调用的方法 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

/** 返回这个UICollectionView是否可以被选择 */
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark - SKTabHomeViewLayout init
/** Layout 设置item的大小 */
- (SKTabHomeViewLayout *)skLayout {
    
    __weak typeof(self) weakSelf = self;
    /** item的宽度 ＝ 屏幕宽度 - 两个屏幕边距 - 总的row间距／row个数 */
    if (!_skLayout) {
        
        _skLayout = [[SKTabHomeViewLayout alloc] init];
        
        //设置边距
        _skLayout.skLeftRightSpacing = 1;
        
        [_skLayout calculateItemSizeWithBlock:^CGSize(NSIndexPath *indexPath) {
            
            CGFloat width = skCollectionView.frame.size.width;
            switch (indexPath.section) {
                    
                case 0:
                {
                    return CGSizeMake(width - weakSelf.skLayout.skLeftRightSpacing * 2, 140);
                }
                    break;
                    
                case 1:
                {
                    return CGSizeMake(width / 2 - weakSelf.skLayout.skLeftRightSpacing * 2 / 2 - _skLayout.skRowSpacing * 1 / 2, 60);
                }
                    break;
                    
                case 2:
                {
                    return CGSizeMake(width / 4 - weakSelf.skLayout.skLeftRightSpacing * 2 / 4 - _skLayout.skRowSpacing * (4 - 1) / 4, (width / 4 - weakSelf.skLayout.skLeftRightSpacing * 2 / 4 - _skLayout.skRowSpacing * (4 - 1) / 4));
                }
                    break;
                    
                default:
                {
                    return CGSizeMake(width / 2 - weakSelf.skLayout.skLeftRightSpacing * 2 / 2 - _skLayout.skRowSpacing * 1 / 2, 120);
                }
                    break;
            }
            
        } headerViewSizeBlock:^CGSize(NSIndexPath *indexPath) {
            
            if (indexPath.section == 0) {
                
                return CGSizeZero;
            }else if (indexPath.section == 1 || indexPath.section == 2) {
                
                return CGSizeMake(skCollectionView.bounds.size.width - weakSelf.skLayout.skLeftRightSpacing * 2, 5);
            }
            return CGSizeMake(skCollectionView.bounds.size.width - weakSelf.skLayout.skLeftRightSpacing * 2, 40);
            
        } footerViewSizeBlock:^CGSize(NSIndexPath *indexPath) {
            
            if (indexPath.section == 0) {
                
                return CGSizeZero;
                
            }else if (indexPath.section == 1 || indexPath.section == 2) {
                
                return CGSizeMake(skCollectionView.bounds.size.width - weakSelf.skLayout.skLeftRightSpacing * 2, 5);
            }
            return CGSizeMake(skCollectionView.bounds.size.width - weakSelf.skLayout.skLeftRightSpacing * 2, 40);
        }];
    }
    return _skLayout;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == skCollectionView) {
        
        [self skNavigationBarAlphaChangedWithContentOffsetY:scrollView.contentOffset.y completed:^(BOOL skSucc) {
            
            /** 用于改变状态栏颜色，但是效果不太好 */
        }];
    }
}



@end
