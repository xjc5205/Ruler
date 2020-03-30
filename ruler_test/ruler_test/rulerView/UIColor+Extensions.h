//
//  UIColor+Extensions.h

//
//  Created by xjc on 15/12/18.
//  Copyright © 2015年 xjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;
//十六进制颜色值字符串处理
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
