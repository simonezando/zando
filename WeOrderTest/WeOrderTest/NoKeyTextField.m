//
//  NoKeyTextField.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoKeyTextField.h"

@implementation NoKeyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL) becomeFirstResponder{
    
    NSLog(@"sdsd");

    [super becomeFirstResponder];
    [self resignFirstResponder];
    return YES;

}

@end
