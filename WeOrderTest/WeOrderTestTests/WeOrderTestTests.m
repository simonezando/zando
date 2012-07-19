//
//  WeOrderTestTests.m
//  WeOrderTestTests
//
//  Created by Simone Zandonà on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeOrderTestTests.h"
#import <OCMock/OCMock.h>

@implementation WeOrderTestTests

- (void)setUp
{
    [super setUp];

    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in WeOrderTestTests");
}

// simple test to ensure building, linking, 
// and running test case works in the project
- (void)testOCMockPass {
    id mock = [OCMockObject mockForClass:NSString.class];
    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
    
    NSString *returnValue = [mock lowercaseString];
    STAssertEqualObjects(@"mocktest", returnValue, 
                         @"Should have returned the expected string.");
}





@end
