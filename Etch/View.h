//
//  View.h
//  Etch
//
//  Created by Rudy Pospisil on 22/04/12.
//  Copyright (c) 2012 rudypospisil@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView {
    CGMutablePathRef path;
    UIButton *button;
    //UIImage *logo;
}

- (void) clearPath;

@end
