//
//  SignUpControllerViewController.h
//  WeOrderTest
//
//  Created by Simone Zandonà on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOUserLoginDelegate.h"
@class TPKeyboardAvoidingScrollView;

@interface SignUpController : UIViewController<WOUserLoginDelegate>{

    WOUser* user;
    UIAlertView* alert;

}

- (IBAction)registerDone:(id)sender;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scroll;


@property (weak, nonatomic) IBOutlet UIView *birthday;


@end
