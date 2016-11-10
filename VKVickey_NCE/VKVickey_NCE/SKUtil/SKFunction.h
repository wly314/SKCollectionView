//
//  SKFunction.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/11.
//  Copyright © 2016年 Leou. All rights reserved.
//

#ifndef SKFunction_h
#define SKFunction_h

/** 数据请求或者下载等处理完成的block回调 */
typedef void (^SKComplete)(BOOL skSucc);

/** Block返回每个indexPath的Size */
typedef CGSize(^SizeBlock)(NSIndexPath *indexPath);

#endif /* SKFunction_h */
