//
//  WOAppDelegate.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WOAppDelegate.h"
#import <FBiOSSDK/FacebookSDK.h>

@implementation WOAppDelegate


- (BOOL)application:(UIApplication *)application 
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication 
         annotation:(id)annotation 
{
    return [FBSession.activeSession handleOpenURL:url]; 
}


@end
