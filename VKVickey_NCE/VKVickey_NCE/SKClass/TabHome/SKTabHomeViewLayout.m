//
//  SKTabHomeViewLayout.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/23.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "SKTabHomeViewLayout.h"

@interface SKTabHomeViewLayout () {
    
    /** 存放元素高宽的键值对 */
    NSMutableArray      *itemSizeArray;
    /** 存放所有item的layout attrubutes属性 */
    NSMutableArray      *itemAttrubutesArray;
    /** 存放所有header的layout attrubutes属性 */
    NSMutableArray      *headerAttrubutesArray;
    
    /** 保存headerView的总高度 */
    CGFloat             collectionHeaderViewHeight;
    /** 保存footerView的总高度 */
    CGFloat             collectionFooterViewHeight;
    /** 总section高度,用于设置内容区域contentSize */
    CGFloat             collectionSizeHeight;
}

@end

@implementation SKTabHomeViewLayout

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        //对默认属性进行设置
        itemSizeArray = [[NSMutableArray alloc] initWithCapacity:0];
        itemAttrubutesArray = [[NSMutableArray alloc] initWithCapacity:0];
        headerAttrubutesArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        _skItemInset = UIEdgeInsetsMake(2, 0, 0, 0);
        _skRowSpacing = 2;
        _skLineSpacing = 2;
        
        _skLeftRightSpacing = 0;
        _skTopBottomSpacing = 0;
        
        collectionHeaderViewHeight = 0;
        collectionFooterViewHeight = 0;
        collectionSizeHeight = 0;
    }
    return self;
}

/**
 *  准备好布局
 */
- (void)prepareLayout {
    
    /** /Users/anakin/Desktop/ios0809/VKVickey_NCE/VKVickey_NCE.xcodeproj获取section个数 */
    NSInteger sectionCount = [self.collectionView numberOfSections];
    /** 计算每个 */
    for (NSInteger i = 0 ; i < sectionCount; i++) {
        
        /** header */
        NSIndexPath *headerIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headerIndexPath];
        [itemAttrubutesArray addObject:headerAttribute];
        
        /** 每个section的row个数 */
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:i];
        
        /** 通过item size大小计算每个section中要布局的所有item的行数（item的size用第一个item的size） */
        CGSize itemSize = CGSizeZero;
        if (self.itemSizeBlock != nil) {
            itemSize = self.itemSizeBlock([NSIndexPath indexPathForRow:0 inSection:i]);
        }else{
            NSAssert(itemSize.width != 0 ,@"未实现block");
        }
        
        //列数 集合视图的宽度 ／ item 的宽度
        NSInteger cellLines = self.collectionView.bounds.size.width/itemSize.width;
        /** 此处记录item的个数上的位置：第一个 第二个 第三个...具体的位置在下面获取Attrubutes时计算 */
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSInteger k = 0; k < cellLines; k++) {
            
            [dict setObject:@(self.skItemInset.top) forKey:[NSString stringWithFormat:@"%ld",(long)k]];
        }
        [itemSizeArray addObject:dict];
        
        /** 计算的到每个item的位置 */
        for (NSInteger j = 0; j < rowCount; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            //调用item计算。
            [itemAttrubutesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
        
        //此时dict已经改变 获取新的item
        NSMutableDictionary *mDict = itemSizeArray[i];
        //计算每个section的高度
        __block NSString *maxHeightline = @"0";
        [mDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
            if ([mDict[maxHeightline] floatValue] < [obj floatValue] ) {
                maxHeightline = key;
            }
        }];
        collectionSizeHeight += [mDict[maxHeightline] floatValue];
                
        /** footer */
        NSIndexPath *footerIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        UICollectionViewLayoutAttributes *footerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:footerIndexPath];
        [itemAttrubutesArray addObject:footerAttribute];
    }
}

/**
 *  计算indexPath下item的属性的方法
 *
 *  @return item的属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建item的属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize itemSize = CGSizeZero;
    /** 得到item size 在外部初始化layout的时候传入 */
    if (self.itemSizeBlock != nil) {
        
        itemSize = self.itemSizeBlock(indexPath);
    }else{
        NSAssert(itemSize.width != 0 ,@"未实现block");
    }
    CGRect layoutFrame = CGRectZero;
    layoutFrame.size = itemSize;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[itemSizeArray objectAtIndex:indexPath.section]];
    
    //循环遍历找出长度最短的行（高度长短的行是因为），然后根据高度长短的行计算item的位置
    __block NSString *lineMinHeight = @"0";
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        if ([dict[lineMinHeight] floatValue] > [obj floatValue]) {
            lineMinHeight = key;
        }
    }];
    int itemLine = [lineMinHeight intValue];
    
    //找出最短行后，计算item位置
    layoutFrame.origin = CGPointMake(_skLeftRightSpacing + itemLine * (itemSize.width + self.skLineSpacing), _skTopBottomSpacing + collectionHeaderViewHeight + collectionSizeHeight + collectionFooterViewHeight);
    attributes.frame = layoutFrame;
    
    //存储高度,创建上一个item之后，替换新的高度
    dict[lineMinHeight] = @(layoutFrame.size.height + _skTopBottomSpacing);
    [itemSizeArray replaceObjectAtIndex:indexPath.section withObject:dict];
    
    return attributes;
}

/**
 *  返回视图框内headerView的属性，可以直接返回所有headerView属性
 */
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    //创建headerView的属性
    UICollectionViewLayoutAttributes *headerAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        
        CGSize headerViewSize = CGSizeZero;
        /** 得到headerView size 在外部初始化layout的时候传入 */
        if (self.headerViewSizeBlock != nil) {
            
            headerViewSize = self.headerViewSizeBlock(indexPath);
        }else{
            NSAssert(headerViewSize.width != 0, @"未实现block");
        }
        
        CGFloat headerViewOriginY = ((headerViewSize.height > 0 ? (_skTopBottomSpacing + collectionHeaderViewHeight + collectionSizeHeight + collectionFooterViewHeight) : 0));
        headerAttribute.frame = CGRectMake(_skLeftRightSpacing, headerViewOriginY, headerViewSize.width, headerViewSize.height);
        
        collectionHeaderViewHeight += ((headerViewSize.height > 0 ? (_skTopBottomSpacing + headerViewSize.height) : 0));
        
    }else if (elementKind == UICollectionElementKindSectionFooter) {
        
        CGSize footerViewSize = CGSizeZero;
        /** 得到footerView size 在外部初始化layout的时候传入 */
        if (self.footerViewSizeBlock != nil) {
            
            footerViewSize = self.footerViewSizeBlock(indexPath);
        }else{
            NSAssert(footerViewSize.width != 0, @"未实现block");
        }
        
        CGFloat headerViewOriginY = ((footerViewSize.height > 0 ? (_skTopBottomSpacing + collectionHeaderViewHeight + collectionSizeHeight + collectionFooterViewHeight) : 0));
        headerAttribute.frame = CGRectMake(_skLeftRightSpacing, headerViewOriginY, footerViewSize.width, footerViewSize.height);
        
        collectionFooterViewHeight += ((footerViewSize.height > 0 ? (_skTopBottomSpacing + footerViewSize.height) : 0));
    }
    
    return headerAttribute;
}

/**
 *  返回视图框内item的属性，可以直接返回所有item属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return itemAttrubutesArray;
}


/**
 *  设置可滚动区域范围
 */
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.collectionView.bounds.size.width, collectionSizeHeight + collectionHeaderViewHeight + collectionHeaderViewHeight);
}

#pragma mark - DataSource
/**
 *  设置计算高度block方法
 *
 *  @param block 计算item高度的block
 */
- (void)calculateItemSizeWithBlock:(CGSize (^)(NSIndexPath *indexPath))itemBlock headerViewSizeBlock:(CGSize (^)(NSIndexPath *indexPath))headerBlock footerViewSizeBlock:(CGSize (^)(NSIndexPath *indexPath))footerBlock {
    
    if (itemBlock && _itemSizeBlock != itemBlock) {
        
        _itemSizeBlock = itemBlock;
    }
    if (headerBlock && _headerViewSizeBlock != headerBlock) {
        
        _headerViewSizeBlock = headerBlock;
    }
    if (footerBlock && _footerViewSizeBlock != footerBlock) {
        
        _footerViewSizeBlock = footerBlock;
    }
}


@end
