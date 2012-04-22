//
//  View.m
//  Etch
//
//  Created by Rudy Pospisil on 22/04/12.
//  Copyright (c) 2012 rudypospisil@gmail.com. All rights reserved.
//

#import "View.h"

#define RED(color)	(((color) >> 2*8 & 0xFF) / 255.0)
#define GREEN(color)	(((color) >> 1*8 & 0xFF) / 255.0)
#define BLUE(color)	(((color) >> 0*8 & 0xFF) / 255.0)

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        path = CGPathCreateMutable();
        
        UIImage *buttonImage = [UIImage imageNamed: @"eraser_sm.png"];
        
        button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        CGRect viewSize = self.bounds;
        CGSize buttonSize = CGSizeMake(100, 60);
        
        button.frame = CGRectMake(
                                  (viewSize.origin.x + viewSize.size.width) - 140,
                                  (viewSize.origin.y + 43),
                                  buttonSize.width,
                                  buttonSize.height
                                  );
        
        [button setTitleColor: [UIColor purpleColor] forState: UIControlStateNormal];
        [button setBackgroundImage: buttonImage forState: UIControlStateNormal];
        //[button setTitle: @"RESET" forState: UIControlStateNormal];
        
        [button addTarget: [UIApplication sharedApplication].delegate
                action: @selector(touchUpInside:)
                forControlEvents:UIControlEventTouchUpInside
         ];
        [self addSubview: button];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint startPoint = [[touches anyObject] locationInView: self];
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint startPoint = [[touches anyObject] locationInView: self];
    CGPathAddLineToPoint(path, NULL, startPoint.x, startPoint.y);
    [self setNeedsDisplay];
}

- (void) clearPath {
    CGPathRelease(path);
    path = CGPathCreateMutable();
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *logo = [UIImage imageNamed: @"logo_etchASketch.png"];
    CGPoint point = CGPointMake(30,20);
    [logo drawAtPoint: point];
    
    unsigned color = 0x0f267a;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextBeginPath(c);
    CGContextAddPath(c, path);
    CGContextSetRGBFillColor(c, RED(color), GREEN(color), BLUE(color), 0.9);
    CGContextStrokePath(c);
}


@end
