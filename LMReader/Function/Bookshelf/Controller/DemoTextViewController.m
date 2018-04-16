//
//  DemoTextViewController.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 1/9/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import "DemoTextViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>

#import "DTTiledLayerWithoutFade.h"
#import "DTRichTextEditor.h"
#import "DTAttStringManage.h"


@interface DemoTextViewController ()
- (void)_segmentedControlChanged:(id)sender;

- (void)linkPushed:(DTLinkButton *)button;
- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture;
- (void)debugButton:(UIBarButtonItem *)sender;

@property (nonatomic, strong) NSMutableSet *mediaPlayers;
@property (nonatomic, strong) NSArray *contentViews;

@end


@implementation DemoTextViewController
{
	NSString *_fileName;
	
	UISegmentedControl *_segmentedControl;
	UISegmentedControl *_htmlOutputTypeSegment;
	
	DTAttributedLabel *_textView;
    UILabel *_chapterView;
    UILabel *_pageView;
    UILabel *_bookmarkView;
	UITextView *_rangeView;
	UITextView *_charsView;
	UITextView *_htmlView;
	UITextView *_iOS6View;
    UIScrollView *_scrollView;
	NSURL *baseURL;
	
	// private
	NSURL *lastActionLink;
	NSMutableSet *mediaPlayers;
	
	BOOL _needsAdjustInsetsOnLayout;
}


#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self)
	{
        [self addNotificationCenter];
	}
	return self;
}


-(void)addNotificationCenter
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackColor1:) name:CHANGECOLOR_1 object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackColor2:) name:CHANGECOLOR_2 object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackColor3:) name:CHANGECOLOR_3 object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackColor4:) name:CHANGECOLOR_4 object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFontSmall:) name:FONTSMALL object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFontBig:) name:FONTBIG object:nil];

}

-(void)changeFontSmall:(NSNotification *)noti
{
    
    _textView.layoutFrame = self.frameset;
}

-(void)changeFontBig:(NSNotification *)noti
{
    _textView.layoutFrame = self.frameset;
}


-(void)changeBackColor1:(NSNotification *)noti
{
    _textView.backgroundColor =COLOR_1;
}

-(void)changeBackColor2:(NSNotification *)noti
{
    _textView.backgroundColor = COLOR_2;
}

-(void)changeBackColor3:(NSNotification *)noti
{
    _textView.backgroundColor =COLOR_3;
}

-(void)changeBackColor4:(NSNotification *)noti
{
    _textView.backgroundColor = COLOR_4;
}


- (void)dealloc 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark UIViewController
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint newPoint =[[change objectForKey:NSKeyValueChangeNewKey]CGPointValue];
        
        if (newPoint.y>0) {
            _scrollView.contentOffset = CGPointMake(0, 0);
        }else if (newPoint.y<-40)
        {
            _bookmarkView.text = @"释放添加书签";
        }else if (newPoint.y<-50)
        {
            
        }
        else
        {
            _bookmarkView.text = @"下拉添加书签";
        }
    }
}

- (void)loadView {
	[super loadView];
    
    
    
	self.automaticallyAdjustsScrollViewInsets = NO;
	CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    _scrollView = [[UIScrollView alloc]initWithFrame:frame];
    _scrollView.scrollEnabled = NO;
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+10);
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|
    NSKeyValueObservingOptionOld context:nil];
    _bookmarkView = [UILabel new];
    _bookmarkView.font = [UIFont systemFontOfSize:15];
    _bookmarkView.text = @"下拉添加书签";
    [_scrollView addSubview:_bookmarkView];
	// Create text view
	_textView = [[DTAttributedLabel alloc] initWithFrame:frame];
//    _textView.backgroundColor = [UIColor redColor];  //修改阅读颜色
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *colorString = [ud valueForKey:BACKCOLOR];
    if (colorString == nil || [colorString isEqualToString:CHANGECOLOR_1]) {
        _textView.backgroundColor = COLOR_1;
    }if ([colorString isEqualToString:CHANGECOLOR_2]) {
        _textView.backgroundColor = COLOR_2;
    }if ([colorString isEqualToString:CHANGECOLOR_3]) {
        _textView.backgroundColor = COLOR_3;
    }if ([colorString isEqualToString:CHANGECOLOR_4]) {
        _textView.backgroundColor = COLOR_4;
    }
    
	// we draw images and links via subviews provided by delegate methods
	_textView.shouldDrawImages = NO;
	_textView.shouldDrawLinks = NO;
    
//	_textView.textDelegate = self; // delegate for custom sub views
	// gesture for testing cursor positions
//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//	[_textView addGestureRecognizer:tap];
	
	// set an inset. Since the bottom is below a toolbar inset by 44px
//	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
//	_textView.contentInset = UIEdgeInsetsMake(10, 10, 54, 10);

//	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // Display string
    _textView.shouldDrawLinks = NO; // we draw them in DTLinkButton
	[self.view addSubview:_scrollView];
    [_scrollView addSubview:_textView];
	_textView.layoutFrame = self.frameset;
//    NSLog(@"self.frameset  ===  %@",self.frameset);
    if (!_chapterView) {
        _chapterView = [[UILabel alloc]init];
        [_textView addSubview:_chapterView];
        [_chapterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_textView.mas_left).with.offset(15);
            make.top.equalTo(_textView.mas_top).with.offset(10);
        }];
        
    }
    if (!_pageView) {
        _pageView = [[UILabel alloc]init];
        [_textView addSubview:_pageView];
        [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_textView.mas_right).with.offset(-15);
            make.bottom.equalTo(_textView.mas_bottom).with.offset(-15);
        }];
        
    }
    [_bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_textView.mas_right).with.offset(-15);
        make.bottom.equalTo(_textView.mas_top).with.offset(-5);
    }];
    _pageView.attributedText = _pageText;
    _chapterView.attributedText = _chapterText;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// now the bar is up so we can autoresize again
//	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)viewWillDisappear:(BOOL)animated;
{
    // stop all playing media
	for (MPMoviePlayerController *player in self.mediaPlayers)
	{
		[player stop];
	}
	
	[super viewWillDisappear:animated];
}

- (BOOL)prefersStatusBarHidden
{
	// prevent hiding of status bar in landscape because this messes up the layout guide calc
	return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	_needsAdjustInsetsOnLayout = YES;
}

// this is only called on >= iOS 5
- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	if (![self respondsToSelector:@selector(topLayoutGuide)] || !_needsAdjustInsetsOnLayout)
	{ 
		return;
	}
	
	// this also compiles with iOS 6 SDK, but will work with later SDKs too
	CGFloat topInset = [[self valueForKeyPath:@"topLayoutGuide.length"] floatValue];
	CGFloat bottomInset = [[self valueForKeyPath:@"bottomLayoutGuide.length"] floatValue];
	
	NSLog(@"%f top", topInset);
	
	UIEdgeInsets outerInsets = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
	UIEdgeInsets innerInsets = outerInsets;
	innerInsets.left += 10;
	innerInsets.right += 10;
	innerInsets.top += 10;
	innerInsets.bottom += 10;
	
//	CGPoint innerScrollOffset = CGPointMake(-innerInsets.left, -innerInsets.top);
//	CGPoint outerScrollOffset = CGPointMake(-outerInsets.left, -outerInsets.top);
	
//	_textView.contentInset = innerInsets;
//	_textView.contentOffset = innerScrollOffset;
//	_textView.scrollIndicatorInsets = outerInsets;
	
	_needsAdjustInsetsOnLayout = NO;
}

#pragma mark Private Methods



#pragma mark Custom Views on Text

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
	NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
	
	NSURL *URL = [attributes objectForKey:DTLinkAttribute];
	NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
	
	
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = URL;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
	
	// get image with normal link text
	UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
	[button setImage:normalImage forState:UIControlStateNormal];
	
	// get image for highlighted link text
	UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
	[button setImage:highlightImage forState:UIControlStateHighlighted];
	
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
	
	// demonstrate combination with long press
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
	[button addGestureRecognizer:longPress];
	
	return button;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
	if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
	{
		NSURL *url = (id)attachment.contentURL;
		
		// we could customize the view that shows before playback starts
		UIView *grayView = [[UIView alloc] initWithFrame:frame];
		grayView.backgroundColor = [DTColor blackColor];
		
		// find a player for this URL if we already got one
		MPMoviePlayerController *player = nil;
		for (player in self.mediaPlayers)
		{
			if ([player.contentURL isEqual:url])
			{
				break;
			}
		}
		
		if (!player)
		{
			player = [[MPMoviePlayerController alloc] initWithContentURL:url];
			[self.mediaPlayers addObject:player];
		}
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_4_2
		NSString *airplayAttr = [attachment.attributes objectForKey:@"x-webkit-airplay"];
		if ([airplayAttr isEqualToString:@"allow"])
		{
			if ([player respondsToSelector:@selector(setAllowsAirPlay:)])
			{
				player.allowsAirPlay = YES;
			}
		}
#endif
		
		NSString *controlsAttr = [attachment.attributes objectForKey:@"controls"];
		if (controlsAttr)
		{
			player.controlStyle = MPMovieControlStyleEmbedded;
		}
		else
		{
			player.controlStyle = MPMovieControlStyleNone;
		}
		
		NSString *loopAttr = [attachment.attributes objectForKey:@"loop"];
		if (loopAttr)
		{
			player.repeatMode = MPMovieRepeatModeOne;
		}
		else
		{
			player.repeatMode = MPMovieRepeatModeNone;
		}
		
		NSString *autoplayAttr = [attachment.attributes objectForKey:@"autoplay"];
		if (autoplayAttr)
		{
			player.shouldAutoplay = YES;
		}
		else
		{
			player.shouldAutoplay = NO;
		}
		
		[player prepareToPlay];
		
		player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		player.view.frame = grayView.bounds;
		[grayView addSubview:player.view];
		
		return grayView;
	}
	else if ([attachment isKindOfClass:[DTImageTextAttachment class]])
	{
		// if the attachment has a hyperlinkURL then this is currently ignored
		DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
		imageView.delegate = self;
		
		// sets the image if there is one
		imageView.image = [(DTImageTextAttachment *)attachment image];
		
		// url for deferred loading
		imageView.url = attachment.contentURL;
		
		// if there is a hyperlink then add a link button on top of this image
		if (attachment.hyperLinkURL)
		{
			// NOTE: this is a hack, you probably want to use your own image view and touch handling
			// also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
			imageView.userInteractionEnabled = YES;
			
			DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
			button.URL = attachment.hyperLinkURL;
			button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
			button.GUID = attachment.hyperLinkGUID;
			
			// use normal push action for opening URL
			[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
			
			// demonstrate combination with long press
			UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
			[button addGestureRecognizer:longPress];
			
			[imageView addSubview:button];
		}
		
		return imageView;
	}
	else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
	{
		DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
		videoView.attachment = attachment;
		
		return videoView;
	}
	else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
	{
		// somecolorparameter has a HTML color
		NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
		UIColor *someColor = DTColorCreateWithHTMLName(colorName);
		
		UIView *someView = [[UIView alloc] initWithFrame:frame];
		someView.backgroundColor = someColor;
		someView.layer.borderWidth = 1;
		someView.layer.borderColor = [UIColor blackColor].CGColor;
		
		someView.accessibilityLabel = colorName;
		someView.isAccessibilityElement = YES;
		
		return someView;
	}
	
	return nil;
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];

	CGColorRef color = [textBlock.backgroundColor CGColor];
	if (color)
	{
		CGContextSetFillColorWithColor(context, color);
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextFillPath(context);
		
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		CGContextStrokePath(context);
		return NO;
	}
	
	return YES; // draw standard background
}


#pragma mark Actions

- (void)linkPushed:(DTLinkButton *)button
{
	NSURL *URL = button.URL;
	
	if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
	{
		[[UIApplication sharedApplication] openURL:[URL absoluteURL]];
	}
	else 
	{
		if (![URL host] && ![URL path])
		{
		
			// possibly a local anchor link
			NSString *fragment = [URL fragment];
			
			if (fragment)
			{
//				[_textView scrollToAnchorNamed:fragment animated:NO];
			}
		}
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
//		[[UIApplication sharedApplication] openURL:[self.lastActionLink absoluteURL]];
	}
}

- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		DTLinkButton *button = (id)[gesture view];
		button.highlighted = NO;
//		self.lastActionLink = button.URL;
		
		if ([[UIApplication sharedApplication] canOpenURL:[button.URL absoluteURL]])
		{
			UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[[button.URL absoluteURL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
			[action showFromRect:button.frame inView:button.superview animated:YES];
		}
	}
}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateRecognized)
	{
		CGPoint location = [gesture locationInView:_textView];
		NSUInteger tappedIndex = [_textView closestCursorIndexToPoint:location];
		
		NSString *plainText = [_textView.attributedString string];
		NSString *tappedChar = [plainText substringWithRange:NSMakeRange(tappedIndex, 1)];
		
		__block NSRange wordRange = NSMakeRange(0, 0);
		
		[plainText enumerateSubstringsInRange:NSMakeRange(0, [plainText length]) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
			if (NSLocationInRange(tappedIndex, enclosingRange))
			{
				*stop = YES;
				wordRange = substringRange;
			}
		}];
		
		NSString *word = [plainText substringWithRange:wordRange];
		NSLog(@"%lu: '%@' word: '%@'", (unsigned long)tappedIndex, tappedChar, word);
	}
}

- (void)debugButton:(UIBarButtonItem *)sender
{
	[DTCoreTextLayoutFrame setShouldDrawDebugFrames:![DTCoreTextLayoutFrame shouldDrawDebugFrames]];
	[_textView setNeedsDisplay];
}

- (void)screenshot:(UIBarButtonItem *)sender
{
	UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	
	CGRect rect = [keyWindow bounds];
	UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[keyWindow.layer renderInContext:context];
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[[UIPasteboard generalPasteboard] setImage:image];
}

#pragma mark - DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
	NSURL *url = lazyImageView.url;
	CGSize imageSize = size;
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	BOOL didUpdate = NO;
	
	// update all attachments that matchin this URL (possibly multiple images with same size)
	for (DTTextAttachment *oneAttachment in [_textView.layoutFrame textAttachmentsWithPredicate:pred])
	{
		// update attachments that have no original size, that also sets the display size
		if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
		{
			oneAttachment.originalSize = imageSize;
			
			didUpdate = YES;
		}
	}
	
	if (didUpdate)
	{
		// layout might have changed due to image sizes
		[_textView relayoutText];
	}
}

#pragma mark Properties

- (NSMutableSet *)mediaPlayers
{
	if (!mediaPlayers)
	{
		mediaPlayers = [[NSMutableSet alloc] init];
	}
	
	return mediaPlayers;
}



@end
