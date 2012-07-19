//
//  ViewController.h
//  WeOrderTest
//
//  Created by Simone Zandonà on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestKit/RestKit.h"
#import "WOUserLoginDelegate.h"
#import "WOUser.h"
@interface LoginController : UIViewController <WOUserLoginDelegate>{

    WOUser * user;
    UIAlertView* alertView;

}
- (IBAction)login:(id)sender;
- (IBAction)loginWithFacebook:(id)sender; 


@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end
