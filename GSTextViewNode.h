/*
 
 GSTextViewNode.h
 
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

#ifndef GSTEXTVIEW_NODE_H
#define GSTEXTVIEW_NODE_H

#import <SpriteKit/SpriteKit.h>

/** Class for displaying text labels with line breaks */
@interface GSTextViewNode : SKSpriteNode

///text content of the textview
@property(nonatomic,copy,setter = setText:) NSString *text;

///font size of the text
@property(nonatomic) CGFloat fontSize;

///font color of the displaying text
@property(SK_NONATOMIC_IOSONLY, strong) SKColor *fontColor;

///font name of the displaying text
@property(nonatomic,copy) NSString *fontName;

///empty space row height
@property(nonatomic) CGFloat spaceHeight;

///vertical margin between the rows
@property(nonatomic) CGFloat verticalMargin;

/** Method to generate a new text view
 *  @param fontName is the font of the text
 *  @return new object of the Text View
 */
- (GSTextViewNode*)initNodeWithFontNamed:(NSString*)fontName;

@end

#endif
