//
//  SKTabHomeViewLayout.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/23.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKFunction.h"

@interface SKTabHomeViewLayout : UICollectionViewFlowLayout

/** 左右两边距离屏幕宽度 */
@property (nonatomic, assign)CGFloat        skLeftRightSpacing;
/** 左右两边距离屏幕宽度 */
@property (nonatomic, assign)CGFloat        skTopBottomSpacing;
/** 行间距 */
@property (nonatomic, assign)CGFloat        skRowSpacing;
/** 列间距 */
@property (nonatomic, assign)CGFloat        skLineSpacing;
/** 内边距 */
@property (nonatomic, assign)UIEdgeInsets   skItemInset;


/** 保存计算每个item高度的block，必须实现*/
@property (nonatomic, copy)SizeBlock itemSizeBlock;
@property (nonatomic, copy)SizeBlock headerViewSizeBlock;
@property (nonatomic, copy)SizeBlock footerViewSizeBlock;

/**
 *  获取item的Size  Section：headerView的Size和footerView的Size
 *
 *  @param itemBlock   返回item的Size
 *  @param headerBlock 返回headerView的Size
 *  @param footerBlock 返回footerView的Size
 */
- (void)calculateItemSizeWithBlock:(SizeBlock)itemBlock headerViewSizeBlock:(SizeBlock)headerBlock footerViewSizeBlock:(SizeBlock)footerBlock;

@end
