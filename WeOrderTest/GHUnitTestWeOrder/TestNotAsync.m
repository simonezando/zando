//
//  TestCancellami.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <GHUnitIOS/GHUnit.h> 
#import <OCMock/OCMock.h>
#import "RestKit/RestKit.h"
#import "WOUser.h"
#import "WOUserLoginDelegate.h"

@interface  TestNotAsync : GHTestCase {
    
    
    
    id mockService;
    
    WOUser *user;
    
    NSMutableDictionary *obj;
    
    
}
@end

@implementation TestNotAsync



- (void)setUp
{
    [super setUp];
    
    
    mockService = [OCMockObject  mockForProtocol:@protocol(WOUserLoginDelegate)];
    
    user = [[WOUser alloc] initWithDelegate:mockService];
    
    obj = [[NSMutableDictionary alloc] init];
    [obj setValue:@"test" forKey:@"name"];
    [obj setValue:@"user@gmail.com" forKey:@"email"];
    [obj setValue:@"male" forKey:@"gender"];
    [obj setValue:@"data" forKey:@"birthday"];
    [obj setValue:@"123456" forKey:@"password"];
    [obj setValue:@"123456" forKey:@"password2"];
    
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://test.weorder.net:8080/query"] ;
    
    RKClient* client = [RKClient clientWithBaseURL:url];
    
    // Set-up code here.
}




@end
