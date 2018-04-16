//
//  DemoTextViewController.h
//  DTCoreText
//
//  Created by Oliver Drobnik on 1/9/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DTAttributedTextView.h"
#import "DTLazyImageView.h"
#import "DTCoreText.h"
#import <DTCoreText/DTAttributedLabel.h>
#import <Masonry/Masonry.h>


@interface DemoTextViewController : UIViewController <UIActionSheetDelegate, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) DTCoreTextLayoutFrame *frameset;
@property (strong, nonatomic) NSAttributedString *chapterText;
@property (strong, nonatomic) NSAttributedString *pageText;
@end
