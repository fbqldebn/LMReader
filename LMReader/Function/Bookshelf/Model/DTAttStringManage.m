//
//  DTAttStringManage.m
//  pageviewController
//
//  Created by 于君 on 16/5/20.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "DTAttStringManage.h"
#import "BookPackIndexItem.h"
#import "Chapter.h"
#import <GDataXML-HTML/GDataXMLNode.h>

@implementation DTAttStringManage

+ (id)sharedManage;
{
    static DTAttStringManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[DTAttStringManage alloc] init];
    });
    return manage;
}
- (NSMutableArray *)pagesOfFrame
{
    if (!_pagesOfFrame) {
        [self resolvePageOfFrameWithAttStr:[self _attributedStringForSnippetUsingiOS6Attributes:YES] rect:CGRectInset([UIScreen mainScreen].bounds, 0, 0)];
    }
    return _pagesOfFrame;
}

- (NSMutableArray *)framesetterOfChapter:(NSInteger)index;
{
//    [self getCurrentFont];
    
    _currentIndex = index;
    if (index>=0&&_lChapters.count>index) {
//        _indexOfChapter = index;;
    }
    
    if (_lChapters.count>index) {
        Chapter *item = [_lChapters objectAtIndex:index];
        //content为获取到的整章的内容
        NSString *content =[self getContentOfChapter:[NSString stringWithFormat:@"%@.nbp",item.chapterId]];
//        NSLog(@"  ^^^^   content  %@",content);
        _nameOfChapter = item.chapterName;
        content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\r"];
        if (!content.length) {
            content = @"章节信息错误，反馈给小编";
        }
        NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"book" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];    //阅读界面页面信息设置
//        NSLog(@"html   ===    %@",html);
        
        _currentString = [FileTool getDataFromUserDefaultWithKey:CURRENTFONT];
        if (_currentString == nil) {
            _currentString = @"17";
            [FileTool saveDataFromUserDefault:_currentString withKey:CURRENTFONT];
        }
        NSInteger nowFont = _currentString.integerValue;
        NSString *newFontString = [NSString stringWithFormat:@"%d",nowFont+2];
        NSLog(@"newFontString     %@",newFontString);
        NSString *newString = [html stringByReplacingOccurrencesOfString:@"17" withString:newFontString];
        
        NSData *data = [[NSString stringWithFormat:newString,content] dataUsingEncoding:NSUTF8StringEncoding];
        return [self resolvePageOfFrameWithAttStr:[[NSAttributedString alloc]initWithHTMLData:data documentAttributes:nil] rect:CGRectInset([UIScreen mainScreen].bounds, 20, 30)];
    }
    return nil;
    
}
- (NSString *)chapterNameOfIndex:(NSInteger)chapterIndex;
{
    NSString *name;
    if (_lChapters.count>chapterIndex) {
        Chapter *item = _lChapters[chapterIndex];
        name = item.chapterName;
    }
  
    return name;
}
- (NSMutableData*)dataOfBinaryBody
{
    self.indexOfChapter = 0;
    NSString *path=[[NSBundle mainBundle] pathForResource:_mBook.b_id ofType:@"body"];
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:path];
    inputStream.delegate = self;
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    return nil;
}
#pragma mark inputStream delegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            
            uint8_t buf[1024*10];
             NSInteger len = 0;
            len = [(NSInputStream *)aStream read:buf maxLength:1024*10];  // 读取数据
            if (len) {                        
                [_data appendBytes:(const void *)buf length:len];
            }
        }
            break;
        case NSStreamEventEndEncountered:
        {
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            aStream = nil;
            [self _parseBookBinary];
        }
            break;
        case NSStreamEventErrorOccurred:
        {
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            aStream = nil;
            
        }
            break;
            default:
            break;
    }
}
-(void)parseBook:(BookEntity *)entity finish:(void(^)(void))finished;
{
    _data = [NSMutableData data];
    _complete = finished;
    _mBook = entity;
    [self dataOfBinaryBody];
    
}


- (void)_parseBookBinary
{
    _lChapters = [NSMutableArray array];
    if (_data) {
        int location=4;
        Byte buf0[4];
        NSRange range={4,4};
        [_data getBytes:buf0 range:range];
        _protectedKey=((buf0[3]<<24)&0xFF000000)|((buf0[2]<<16)&0xFF0000)|((buf0[1]<<8)&0xFF00)|(buf0[0]&0xFF);
        location=88;
        Byte  buf[4];
        range.location=location;
        range.length=4;
        
        [_data getBytes:buf range:range];
        
        //文件数量
        int count=((buf[3]<<24)&0xFF000000)|((buf[2]<<16)&0xFF0000)|((buf[1]<<8)&0xFF00)|(buf[0]&0xFF);
//                NSLog(@"count ^^^^^      %d",count);
        
        location+=4;
        _dCatalog=[[NSMutableDictionary alloc]init];
        for (int i=0; i<count; i++)
        {
            BookPackIndexItem * fileIndex=[[BookPackIndexItem alloc]init];
            
            Byte  buf0[40];
            //NSRange range={location,40};
            
            range.location=location;
            range.length=40;
            
            [_data getBytes:buf0 range:range];
            
            NSString *fileName=[[NSString alloc]initWithCString:(char*)buf0 encoding:NSUTF8StringEncoding];
//                                                NSLog(@"name: ^^^^   %@",fileName);
            fileIndex.fileName=fileName;
            
            location+=40;
            
            range.location=location;
            range.length=4;
            //offset
            Byte buf1[4];
            [_data getBytes:buf1 range:range];
            uint fileOffset=((buf1[3]<<24)&0xFF000000)|((buf1[2]<<16)&0xFF0000)|((buf1[1]<<8)&0xFF00)|(buf1[0]&0xFF);
            //            NSLog(@"offset%d",fileOffset);
            fileIndex.offset=fileOffset;
            
            location+=4;
            
            range.location=location;
            range.length=1;
            
            Byte buf2[1];
            [_data getBytes:buf2 range:range];
            uint flag=buf2[0];
            fileIndex.flag=flag;
            //            NSLog(@"%d",fileIndex.flag);
            location+=1;
            
            range.location=location;
            range.length=3;
            Byte buf3[3];
            [_data getBytes:buf3 range:range];
            uint fileLength=((buf3[2]<<16)&0xFF0000)|((buf3[1]<<8)&0xFF00)|(buf3[0]&0xFF);
            //            NSLog(@"fileLength%d",fileLength);
            
            fileIndex.filesize=fileLength;
            location+=3;
            
            [_dCatalog setObject:fileIndex forKey:fileName];
        }
        [self _parseChapter];
    }
}


/**  解析
 * @desc get catalog xml file
 */
- (void)_parseChapter
{
    BookPackIndexItem *fileIndex=[_dCatalog objectForKey:@"index.xml"];
    
    Byte  buf[fileIndex.filesize];
    
    NSRange range={0,0};
    range.location=fileIndex.offset;
    range.length=fileIndex.filesize;
    
    [_data getBytes:buf range:range];
    
    NSData *xmlData=[NSData dataWithBytes:buf length:range.length];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData error:nil];
    NSArray *items = [doc nodesForXPath:@"//item" error:nil];
    for (GDataXMLElement *element in items)
    {
        NSArray *atts = [element attributes];
        Chapter *chapter = [[Chapter alloc]init];
        for (GDataXMLNode *node in atts)
        {
            if ([[node name]isEqualToString:@"id"]) {
                chapter.chapterId = [node stringValue];
            }else if ([[node name]isEqualToString:@"capt"])
            {
                chapter.index = [[node stringValue] integerValue];
            }
        }
        chapter.chapterName = [element stringValue];
        [_lChapters addObject:chapter];
    }
    if (_complete) {
        _complete();
    }
}

//获取章节内容
- (NSString *)getContentOfChapter:(NSString *)chapterName
{
    BookPackIndexItem *indexItem=[_dCatalog objectForKey:chapterName];
    
    NSRange range={0,0};//{indexItem.offset,indexItem.filesize};
    NSInteger size=indexItem.filesize;
    if (indexItem.flag==1)
    {
        //            int uid = Integer.parseInt(User.getInstance().uid);
//        ConfigDao *dao = [[ConfigDao alloc]init];
//        int uid = [[dao getValueByName:@"uid"] intValue];
//        int x = uid ^self.protectedKey;
        NSInteger x = _protectedKey;
        NSInteger offset =indexItem.offset ^ x;
        size = (x & 0xffffff) ^ indexItem.filesize;
        
        range.location=offset;
        range.length=size;
    }
    else
    {
        range.location=indexItem.offset;
        range.length=indexItem.filesize;
    }
    Byte buf[size];
    [_data getBytes:buf range:range];
    
    NSData *data=[[NSData alloc]initWithBytes:buf length:size];
    if (data) {
        
        return [self getChapterText:data];
    }
    return nil;
}
-(NSString *)getChapterText :(NSData*)nbpData
{
    int location=4;
    
    Byte buf0[4];
    NSRange range={4,4};
    [nbpData getBytes:buf0 range:range];
    int key=((buf0[3]<<24)&0xFF000000)|((buf0[2]<<16)&0xFF0000)|((buf0[1]<<8)&0xFF00)|(buf0[0]&0xFF);
    
    _protectedKey = key;
    location=88;
    Byte  buf[4];
    range.location=location;
    range.length=4;
    [nbpData getBytes:buf range:range];
    
    int count=((buf[3]<<24)&0xFF000000)|((buf[2]<<16)&0xFF0000)|((buf[1]<<8)&0xFF00)|(buf[0]&0xFF);
    
    location+=4;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    for (int i=0; i<count; i++)
    {
        BookPackIndexItem * fileIndex=[[BookPackIndexItem alloc]init];
        
        Byte  buf0[40];
        //NSRange range={location,40};
        
        range.location=location;
        range.length=40;
        
        [nbpData getBytes:buf0 range:range];
        
        NSString *fileName=[[NSString alloc]initWithCString:(char*)buf0 encoding:NSUTF8StringEncoding];
        //        NSLog(@"name:%@",fileName);
        fileIndex.fileName=fileName;
        
        location+=40;
        
        range.location=location;
        range.length=4;
        Byte buf1[4];
        [nbpData getBytes:buf1 range:range];
        uint fileOffset=((buf1[3]<<24)&0xFF000000)|((buf1[2]<<16)&0xFF0000)|((buf1[1]<<8)&0xFF00)|(buf1[0]&0xFF);
        fileIndex.offset=fileOffset;
        
        location+=4;
        
        range.location=location;
        range.length=1;
        
        Byte buf2[1];
        [nbpData getBytes:buf2 range:range];
        int flag=buf2[0];
        fileIndex.flag=flag;
        location+=1;
        
        range.location=location;
        range.length=3;
        Byte buf3[3];
        [nbpData getBytes:buf3 range:range];
        uint fileLength=((buf3[2]<<16)&0xFF0000)|((buf3[1]<<8)&0xFF00)|(buf3[0]&0xFF);
        //NSLog(@"fileLength%d",fileLength);
        
        fileIndex.filesize=fileLength;
        location+=3;
        
        [dict setObject:fileIndex forKey:fileName];
        
    }
    
    //取出content
    
    BookPackIndexItem * fileIndex=[dict objectForKey:@"content.txt"];
    
    NSInteger size = fileIndex.filesize;
    
    if(fileIndex.flag==1)//内容有保护
    {
        
//        ConfigDao *dao = [[ConfigDao alloc]init];
//        int uid = [[dao getValueByName:@"uid"] intValue];
//        int x = uid ^self.protectedKey;
        NSInteger x = _protectedKey;
        NSInteger offset =fileIndex.offset ^ x;
        size = (x & 0xffffff) ^ fileIndex.filesize;
        
        range.location=offset;
        range.length=size;
        
    }
    else
    {
        range.location=fileIndex.offset;
        range.length=size;
    }
    
    void *buffer ;
    Byte buf4[range.length];
    if (range.length>1024*100) {
        buffer = (void *)malloc(range.length+10);
        //        memset(buf4, 0, range.length);
    }else
    {
        buffer = buf4;
    }
    [nbpData getBytes:buffer range:range];
    
    NSString *content=[[NSString alloc]initWithBytes:buffer length:fileIndex.filesize encoding:NSUTF16LittleEndianStringEncoding];
    if (NULL != buffer&&range.length>1024*100) {
        free(buffer);
        buffer = NULL;
    }
    return content;
    
}




- (NSArray <DTCoreTextLayoutFrame*>*)resolvePageOfFrameWithAttStr:(NSAttributedString *)str rect:(CGRect)rect;
{
    NSMutableArray *results = [NSMutableArray array];
    if (str) {
        
        DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc]initWithAttributedString:str];
        layouter.shouldCacheLayoutFrames = YES;
        NSRange range = NSMakeRange(0, str.length);

        DTCoreTextLayoutFrame *frame;
        do {
            frame = [layouter layoutFrameWithRect:rect range:range];
            range = [frame visibleStringRange];
            if (frame) {
                range.location += range.length;
                range.length = 0;
                [results addObject:frame];
            }
            
        }while (frame);
       
    }
    _pagesOfFrame = results;
    return results;
}



- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes
{
    // Load HTML data
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:_bookName ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:readmePath encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"readme html   ===   %@",html);
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20.0, [UIScreen mainScreen].bounds.size.height - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }
    
    [options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    return string;
}



-(NSMutableArray *)changeTextFontSmall:(BOOL)isSmall
{
    
    
    Chapter *item = [_lChapters objectAtIndex:_currentIndex];
    //content为获取到的整章的内容
    NSString *content =[self getContentOfChapter:[NSString stringWithFormat:@"%@.nbp",item.chapterId]];
    _nameOfChapter = item.chapterName;
    content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\r"];
    if (!content.length) {
        content = @"章节信息错误，反馈给小编";
    }

   
    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"book" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];    //阅读界面页面信息设置
   
     _currentString = [FileTool getDataFromUserDefaultWithKey:CURRENTFONT];
     NSLog(@"修改字号……………………………… %@",html );
    NSLog(@"_currentString   %@",_currentString);
    NSInteger nowFont = _currentString.integerValue;
    NSString *newFontString;
    if (isSmall) {
        newFontString = [NSString stringWithFormat:@"%d",nowFont-2];
    }else
    {
        newFontString = [NSString stringWithFormat:@"%d",nowFont+2];
    }
    
    NSLog(@"newFontString     %@",newFontString);
    NSString *newString = [html stringByReplacingOccurrencesOfString:@"17" withString:newFontString];
     NSLog(@"html   ===    %@",newString);
    [FileTool saveDataFromUserDefault:newFontString withKey:CURRENTFONT];
    
    NSData *data = [[NSString stringWithFormat:newString,content] dataUsingEncoding:NSUTF8StringEncoding];
    
    _currentString = newFontString;
    return [self resolvePageOfFrameWithAttStr:[[NSAttributedString alloc]initWithHTMLData:data documentAttributes:nil] rect:CGRectInset([UIScreen mainScreen].bounds, 20, 30)];

}




-(void)changeTextColorWithNumber:(CGFloat)number
{
    NSLog(@"修改字的颜色……………………………………………………");
}




@end
