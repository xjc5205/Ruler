//
//  HXBuyScrollView.h
//
//  Created by xjc on 16/9/30.
//  Copyright © 2016年 xjc. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface HXBuyScrollView : UIScrollView
@property(nonatomic,strong)UICollectionView * hxCollectionView;

- (void)createScorll:(NSString *)minString andMax:(NSString *)maxString defaultOffset:(NSString *)offset;

@end

