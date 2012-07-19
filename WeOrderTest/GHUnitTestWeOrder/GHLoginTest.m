//
//  GHLoginTest.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <GHUnitIOS/GHUnit.h> 
#import <OCMock/OCMock.h>
#import "RestKit/RestKit.h"
#import "WOUser.h"
#import "WOUserLoginDelegate.h"

@interface  GHLoginTest : GHAsyncTestCase {

    
    
    id mockService;
    
    WOUser *user;
    

}
@end

@implementation GHLoginTest



- (void)setUp
{
    [super setUp];
    
    mockService = [OCMockObject  niceMockForProtocol:@protocol(WOUserLoginDelegate)];
    
    user = [[WOUser alloc] initWithDelegate:mockService];
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://test.weorder.net:8080/query"] ;
    
    RKClient* client = [RKClient clientWithBaseURL:url];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void) setUserAndPwdWithAvoidValue{
    
    //User vuoto o nil
    [user login:@"" withPassword:@"pwd" facebook:NO];
    [user login:nil withPassword:@"pwd" facebook:NO];
    
    //Password vuota o nil
    [user login:@"user" withPassword:@"" facebook:NO];
    [user login:@"user" withPassword:nil facebook:NO];

}

- (void)testFailCallDidLogin {
    
    
    [self prepare];
    
    [[mockService expect] userDidLogin:[OCMArg any]];
     
    [self setUserAndPwdWithAvoidValue];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];
  
    
    
    
    [mockService verify];
    
    //GHAssertThrows([mockService verify],@"Non ha lanciato eccezione->Ha provato a fare il login.. Errore! Fa login ma non deve");
     
}



- (void)testFailCallDidFailLoginWithError {
    
    [self prepare];
    
    [[mockService expect] userDidFailLoginWithError:[OCMArg any]];
    
    
    [self setUserAndPwdWithAvoidValue];
    
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];
    
 
    [mockService verify];
    //GHAssertThrows([mockService verify],@"mi aspetto che lanci eccezione");
    
    
}



- (void)testOKLoginSuccess {
    
    
    [self prepare];
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    
    
    [user login:@"user@gmail.com" withPassword:@"123456" facebook:NO];
    

    // The `waitfForStatus:timeout` method will block this thread.
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];

   [mockService verify];
    
}


- (void) testOKCallFailLogin {
    
    [self prepare];
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    
    
    [user login:@"user@gmail.com" withPassword:@"123456" facebook:NO];
    
    
    // The `waitfForStatus:timeout` method will block this thread.
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];
    
    [mockService verify];
    
    
}

- (void)testLoginWithFacebook {
    
    [self prepare];
  
    [[mockService expect] userDidLogin:[OCMArg any]];
    
    [user loginWithFacebook];
    
    // The `waitfForStatus:timeout` method will block this thread.
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:25.0];
    
    
    [mockService verify];
    
    
    
    
}
//testa la mancanza di rete e si aspetta un fallimento anche in caso di credenziali corrette
- (void)testFailConnection {
    
    
    [self prepare];
    
    [[mockService expect] userDidFailLoginWithError:[OCMArg any]];
    
    
    [user login:@"user@gmail.com" withPassword:@"123456" facebook:NO];
    
    
    // The `waitfForStatus:timeout` method will block this thread.
    [self waitForStatus:kGHUnitWaitStatusFailure timeout:1.0];
    
    [mockService verify];
    
}

- (void)didFinishAsyncOperation
{
    
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLoginSuccess)];
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLoginFail)];
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testNotCallDidFailLoginWithError)];
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testNotCallDidLogin)];
    
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testNoConnection)];
}







// Override any exceptions; By default exceptions are raised, causing a test failure
- (void)failWithException:(NSException *)exception { }


@end