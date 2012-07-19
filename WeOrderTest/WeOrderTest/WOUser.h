//
//  WOUser.h
//  WeOrderTest
//
//  Created by Simone Zandonà on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOUserLoginDelegate.h"
#import "RestKit/RestKit.h"


@interface WOUser : NSObject <RKRequestDelegate>{

    id _user;
  

}



@property (nonatomic,assign) NSObject <WOUserLoginDelegate> *loginServiceDelegate;

- (id) initWithDelegate:(NSObject<WOUserLoginDelegate>*) delegate;

//- (void) loginWithDelegate:(NSObject<WOUserLoginDelegate>*) delegate;

- (void) login:(NSString *)username withPassword:(NSString *)password facebook:(BOOL)fb;
- (void) registerUser:(NSObject *)user;
- (void) loginWithFacebook;



@end
