/*
 
 GSTextViewNode.m
 
 Copyright (c) 2013 Truong Vinh Tran
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "GSTextViewNode.h"

@implementation GSTextViewNode


#pragma mark - init methods

- (GSTextViewNode*)initNodeWithFontNamed:(NSString *)fontName{
    
    UIColor* color = UIColor.clearColor;
    
    self = [super initWithColor:color size:CGSizeZero];
    
    if (self) {
        //set up default values
        self.fontSize = 14;
        self.fontColor = [SKColor blackColor];
        self.fontName = fontName;
        self.spaceHeight = 14;
        self.verticalMargin = 5;
    }
    return self;
}

- (void)setText:(NSString *)text{

    //remove all childrens
    if ([self.children count]>0) {
        [self removeAllChildren];
    }
    
    //set text attribute
    _text = text;
    
    //split up the text into several rows
    NSArray* strings = [text componentsSeparatedByString:@"\n"];
    
    //variables to store the size
    CGFloat totalheight = 0;
    CGFloat maxwidth = 0;
    
    //get every row
    NSMutableArray *labels = [NSMutableArray new];
    for (int i=0; i < strings.count; i++) {
        
        //get substring
        NSString *substring = [strings objectAtIndex:i];
        
        //substring is not empty
        if (![substring isEqualToString:@""]) {
            SKLabelNode *rowText = [SKLabelNode labelNodeWithFontNamed:_fontName];
            rowText.text = substring;
            rowText.fontColor = _fontColor;
            rowText.fontSize = _fontSize;
            
            const CGSize LABEL_SIZE = [rowText calculateAccumulatedFrame].size;
            
            if (LABEL_SIZE.width > maxwidth) {
                maxwidth = LABEL_SIZE.width;
            }
            
            //increase the row height
            totalheight +=LABEL_SIZE.height;
            
            //add new label
            [labels addObject:rowText];
        }else{
            //empty string
            totalheight += _spaceHeight;
            [labels addObject:[NSNull null]];
        }
        if (i + 1 < strings.count)
            totalheight += _verticalMargin;
    }
    
    self.size = CGSizeMake(maxwidth, totalheight);
    
    CGFloat y = totalheight * 0.5;
    
    //add every row to the scene
    for (NSUInteger i = 0; i < strings.count; i++) {
        id obj = [labels objectAtIndex:i];
        if ([obj isKindOfClass:SKLabelNode.class]) {
            SKLabelNode* label = obj;
            label.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
            label.position = CGPointMake(0, y);
            [self addChild:label];
            const CGSize SIZEOFLABEL = [label calculateAccumulatedFrame].size;
            y -= SIZEOFLABEL.height;
        }
        else {
            y -= _spaceHeight;
        }
        if (i + 1 < labels.count)
            y -= _verticalMargin;
    }
}
@end
