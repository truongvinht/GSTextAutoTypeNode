GSTextAutoTypeNode
==============

A SpriteKit iOS class to get auto-typing labels (multiple lines).

Require: Apple SpriteKit Framework for iOS 

#Example

```Objective-C
GSTextAutoTypeNode *autoText = [GSTextAutoTypeNode labelWithFontName:@"Arial"];
self.autoText.fontColor = [SKColor whiteColor];
autoText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)); //text in the center
[self addChild:autoText];
[autoText typeText:@"Some text with linebreaks,\n which looks not so bad" withDelay:0.1f];
```

#License
MIT License (MIT)
Original for Cocos2D: [a link](https://github.com/sceresia/CCAutoType)
