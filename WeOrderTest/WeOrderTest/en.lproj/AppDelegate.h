//
//  AppDelegate.h
//  WeOrderTest
//
//  Created by Simone Zandonà on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    WOUser* user; 
    
}


@property (strong, nonatomic) UIWindow *window;


@end
