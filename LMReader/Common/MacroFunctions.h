//
//  MacroFunctions.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//
#ifndef MacroFunctions_h
#define MacroFunctions_h

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NAVIBUTTON_WIDTH 44
#define NAVIBUTTON_HEIGHT 44

#define isIOS8Later SystemVersion_floatValue >= 8.0
#define isIOS7Later SystemVersion_floatValue >= 7.0

#define COMMENURL @"http://follow.soutuw.com:8080/reader/"

#define Ifont @"FZLTHJW--GB1-0"


#define CHANGECOLOR_1 @"changecolor1"
#define CHANGECOLOR_2 @"changecolor2"
#define CHANGECOLOR_3 @"changecolor3"
#define CHANGECOLOR_4 @"changecolor4"

#define CURRENTFONT @"currentFont"

#define FONTSMALL @"fontSmall"
#define FONTBIG @"fontBig"

#define JUMPCHAPTER @"jumpChapter"

#define COLOR_1 UIColorFromRGB(0xf6ecdd)
#define COLOR_2 UIColorFromRGB(0xf0ce9c)
#define COLOR_3 UIColorFromRGB(0x88c4b0)
#define COLOR_4 [DTColor blackColor]

#define BACKCOLOR @"backColor"

#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]


#define ISiPad ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad? YES:NO)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define WEAK_SELF __weak typeof(self) weakSelf = self;

#pragma mark - file path
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

#pragma mark - debug

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s %s [Line %d] " fmt), __FILE__,__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#endif /* MacroFunctions_h */
