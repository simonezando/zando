//
//  WOUserLoginProtocol.h
//  WeOrderTest
//
//  Created by Simone Zandonà on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WOUser;

@protocol WOUserLoginDelegate <NSObject>

- (void)userDidLogin:(NSString*)msg;
- (void)userDidFailLoginWithError:(NSString*)msg;
- (void)userDidLogout:(NSString*)msg;

@end
