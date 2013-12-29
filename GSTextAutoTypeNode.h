/*
 
 GSTextAutoTypeNode.h
 
 Copyright (c) 2012 EXC_BAD_ACCESS. All rights reserved.
 Original: https://github.com/sceresia/CCAutoType
 Modified by Truong Vinh Tran
 
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

#ifndef GSTEXTAUTOTYPENODE_H
#define GSTEXTAUTOTYPENODE_H

#import "GSTextViewNode.h"

@class GSTextAutoTypeNode;

/** Protocol for handling event after finished typing.*/
@protocol GSTextAutoTypeDelegate <NSObject>

@optional
/** Method which is called after typing is finished
 *
 *  @param sender is the label which calls this method
 */
- (void)typingFinished:(GSTextAutoTypeNode*) sender;

/** Method to detect error while retry type during typing is in progress
 *
 *  @param sender is the label which calls this method
 */
- (void)errorLabelStillTyping:(GSTextAutoTypeNode*)sender;

@end

/** Class for creating auto typing text.*/
@interface GSTextAutoTypeNode : GSTextViewNode

//link target for handling event after finished autotyping
@property (nonatomic, weak) NSObject <GSTextAutoTypeDelegate> *delegate;

///@name Public Methods

/** Class Method for init new label
 *
 *  @param font is the font of the displayed text
 *  @return new allocated GSTextAutoTypeNode object
 */
+(GSTextAutoTypeNode*)labelWithFont:(UIFont*)font;


/** Class Method for init new label using font name
 *
 *  @param fontName is the font name of the displayed text
 *  @return new allocated GSTextAutoTypeNode object
 */
+(GSTextAutoTypeNode*)labelWithFontName:(NSString*)fontName;

/** Class Method for init new label with target font and also init the delegate target
 *
 *  @param font is the font of the displayed text
 *  @param target is the class which handles the typing events
 *  @return new allocated GSTextAutoTypeNode object
 */
+(GSTextAutoTypeNode*)labelWithFont:(UIFont*)font target:(NSObject<GSTextAutoTypeDelegate>*)target;

/** Class Method for init new label using font name and target as callback
 *
 *  @param fontName is the font name of the displayed text
 *  @param target is the class which handles the typing events
 *  @return new allocated GSTextAutoTypeNode object
 */
+(GSTextAutoTypeNode*)labelWithFontName:(NSString*)fontName target:(NSObject<GSTextAutoTypeDelegate>*)target;

/** Method to start typing the text with delay
 *
 *  @param text is the string which will typed
 *  @param delay is the duration (in seconds) of typing
 */
- (void)typeText:(NSString*)text withDelay:(float) delay;

@end

#endif