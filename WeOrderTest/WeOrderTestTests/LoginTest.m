//
//  LoginTest.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>

#import "LoginTest.h"

#import "OCMock.h"

#import "WOUserLoginDelegate.h"
#import "WOUser.h"
#import "RestKit/RestKit.h"

@implementation LoginTest

- (void)setUp
{
    [super setUp];
 
    
    mockService = [OCMockObject mockForProtocol:@protocol(WOUserLoginDelegate)];
    
    user = [[WOUser alloc] initWithDelegate:mockService];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testUserOrPwdNilOrAvoid {
    
    
    
    //User vuoto o nil
    [user login:@"" withPassword:@"pwd"];
    [user login:nil withPassword:@"pwd"];

    //Password vuota o nil
    [user login:@"user" withPassword:@""];
    [user login:@"user" withPassword:nil];

    
    
    STAssertThrows([mockService userDidLogin:[OCMArg any] ],@"Non ha lanciato eccezione->Ha provato a fare il login.. Errore! Fa login ma non deve");
   
    STAssertThrows([mockService userDidFailLoginWithError:[OCMArg any] ],@"Non ha lanciato eccezione->Ha provato a fare il login.. Errore! non devo mandare richiesta perchè fallirebbe");
      
    
}


- (void)testLoginSuccess {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    [user login:@"simone@gmail.com" withPassword:@"123456"];
    
    
    [mockService verify];
    
}

- (void)testLoginFail {
    
    [[mockService expect] userDidFailLoginWithError:[OCMArg any]];
    [user login:@"ciao" withPassword:@"bello"];
    
    [mockService verify];
    
}




@end
