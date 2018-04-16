//
//  UIDefine.h
//  worde
//
//  Created by dida on 15/11/11.
//  Copyright © 2015年 wordemotion. All rights reserved.
//

#ifndef UIDefine_h
#define UIDefine_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define ColorMain               UIColorFromRGB(0xF22B3E)
#define ColorBg_Default         UIColorFromRGB(0xF1F1F1)

#define Color_Red               ColorMain
#define Color_Green             UIColorFromRGB(0x2DB052)
#define Color_Blue              UIColorFromRGB(0x404BC7)
#define Color_Orange            UIColorFromRGB(0xF8AA00)
#define Color_Black             [UIColor blackColor]
#define Color_Gray              UIColorFromRGB(0x9C9C9C)
#define Color_Clear             [UIColor clearColor]

#define UIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)


#endif /* UIDefine_h */
