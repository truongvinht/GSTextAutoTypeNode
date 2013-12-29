/*
 
 GSTextAutoTypeNode.m
 
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

#import "GSTextAutoTypeNode.h"

@interface GSTextAutoTypeNode ()

/// array with all characters which are already typed
@property (nonatomic, retain) NSMutableArray *arrayOfCharacters;

/// string which will be typed
@property (nonatomic, retain) NSString *autoTypeString;

/// timer for checking typing is finished
@property (nonatomic, strong) NSTimer *checker;

@end

@implementation GSTextAutoTypeNode

+(GSTextAutoTypeNode*)labelWithFont:(UIFont *)font{
    //init empty label for parent
    
    GSTextAutoTypeNode *node = [[GSTextAutoTypeNode alloc] initNodeWithFontNamed:font.fontName];
    node.fontSize = font.pointSize;
    return node;
}

+(GSTextAutoTypeNode*)labelWithFontName:(NSString*)fontName{
    //init empty label for parent
    return [[GSTextAutoTypeNode alloc] initNodeWithFontNamed:fontName];
}

+(GSTextAutoTypeNode*)labelWithFont:(UIFont*)font target:(NSObject<GSTextAutoTypeDelegate>*)target{
    GSTextAutoTypeNode *instance = [GSTextAutoTypeNode labelWithFont:font];
    instance.fontSize = font.pointSize;
    instance.delegate = target;
    return instance;
}

+(GSTextAutoTypeNode*)labelWithFontName:(NSString*)fontName target:(NSObject<GSTextAutoTypeDelegate>*)target{
    GSTextAutoTypeNode *instance = [GSTextAutoTypeNode labelWithFontName:fontName];
    instance.delegate = target;
    return instance;
}

- (void) typeText:(NSString*)text withDelay:(float) delay {
    
    //check wether label is already typing
    if ([self hasActions]) {
        
        //notify target object
        if ([self.delegate respondsToSelector:@selector(errorLabelStillTyping:)]) {
            [self.delegate errorLabelStillTyping:self];
        }
        return;
    }
    
    //init new array for the characters of the typing string
    self.arrayOfCharacters = [NSMutableArray new];
    
    //init new string
    self.autoTypeString = [text copy];
    
    //add every character to the typing list
    for (int j=1; j < [_autoTypeString length]+1; ++j) {
        NSString *substring = [text substringToIndex:j];
        [_arrayOfCharacters addObject:substring];
    }
    
    //schedule the typing
    for (int i=0; i < [_autoTypeString length]; ++i) {
        NSString *string = [_arrayOfCharacters objectAtIndex:i];
        
        //run action
        [self runAction:[SKAction sequence:@[[SKAction waitForDuration:i*delay],[SKAction runBlock:^{
            //type current characters
            [self performSelector:@selector(type:data:) withObject:self withObject:string];
        }]]]];
    }
    
    //check every second wether it is finished
    self.checker = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(finishCheck:) userInfo:nil repeats:YES];
}

/** Method for typing/updating the label
 *
 *  @param sender is the target which called this method
 *  @param string is the new string
 */
- (void)type:(id) sender data:(NSString*)string {
    [self setText:string];
}

/** Helping method to check wether the string is fully typed
 *
 *  @param timer is the current timer
 */
- (void)finishCheck:(NSTimer*)timer{
    
    //check wether actions are still running
    if (![self hasActions]) {
        
        //no actions running, stop calling the timer
        [timer invalidate];
        //notify target object
        if ([self.delegate respondsToSelector:@selector(typingFinished:)]) {
            [self.delegate typingFinished:self];
        }
    }
}

- (void)dealloc{
    if (self.checker) {
        [self.checker invalidate];
    }
}

@end
