//
//  GHRegisterTest.m
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

@interface  GHRegisterTest : GHTestCase {
    
    
    
    id mockService;
    
    WOUser *user;
    
    NSMutableDictionary *obj;
    
    
}
@end

@implementation GHRegisterTest



- (void)setUp
{
    [super setUp];
    
    
    mockService = [OCMockObject  niceMockForProtocol:@protocol(WOUserLoginDelegate)];
    
    user = [[WOUser alloc] initWithDelegate:mockService];
    
    obj = [[NSMutableDictionary alloc] init];
    [obj setValue:@"test" forKey:@"name"];
    [obj setValue:@"simone@gmail.com" forKey:@"username"];
    [obj setValue:@"M" forKey:@"gender"];
    [obj setValue:[[NSNumber alloc] initWithLong:12032000] forKey:@"birthday"];
    [obj setValue:@"123456" forKey:@"password"];
    [obj setValue:@"123456" forKey:@"password2"];
    
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://test.weorder.net:8080/query"] ;
    
    RKClient* client = [RKClient clientWithBaseURL:url];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

//rivedere email------
- (void)testFailValidEmail {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
     //view http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses
    
    [obj setValue:nil forKey:@"email"];
    [user registerUser:obj];
    //Invalid email address
    NSArray* emailArray = [[NSArray alloc] initWithObjects:@"",
                                                        @"ciaobelli",
                                                        @"ciaobelli.c",
                                                        @"@gmail.c",
                                                        @"#@%^%#$@#$@#.com",
                                                        @"@example.com",
                                                        @"Joe Smith <email@example.com>",
                                                        @"email.example.com",
                                                        @"email@example@example.com",
                                                        @".email@example.com",
                                                        @"email.@example.com",
                                                        @"email..email@example.com",
                                                        @"あいうえお@example.com",
                                                        @"Jemail@example.com (Joe Smith)",
                                                        @"email@example",
                                                        @"email@-example.com",
                                                        @"email@111.222.333.44444",  
                                                        @"email@example..com",
                                                        @"Abc..123@example.com",
                           //strange invalid email address
                           /*
                            "(),:;<>[\]@example.com
                            just"not"right@example.com
                            this\ is"really"not\allowed@example.com
                            */
                                                        @"\"(),:;<>[\\]@example.com",
                                                        @"just\"not\"right@example.com",
                                                @"this\\ is\"really\"not\\allowed@example.com",nil ];
    
    
    for (NSString* email in emailArray) {
        [obj setValue:email forKey:@"email"];
        [user registerUser:obj];
    }
    
    
    
    [mockService  verify];
    
     //test passa se  manda eccezioni
  
    
}

- (void)testOKValidEmail {
    
    
    [[mockService expect] userDidLogin:[OCMArg any]];
     
    //view http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses
    
    //Invalid email address
  
    NSArray* emailArray = [[NSArray alloc] initWithObjects:
                           @"email@example.com",
                           @"simone.zandona@example.com",
                           @"email@subdomain.example.com",
                           @"firstname+lastname@example.com",
                           @"email@123.123.123.123",
                           //@"email@[123.123.123.123]",
                           @"\"email\"@example.com",
                           @"1234567890@example.com",
                           @"email@example-one.com",
                           @"_______@example.com",
                           @"email@example.name",
                           @"email@example.museum",
                           @"email@example.co.jp",
                           @"firstname-lastname@example.com",
           /*inusual email correct
            
           much.”more\ unusual”@example.com
           very.unusual.”@”.unusual.com@example.com
           very.”(),:;<>[]”.VERY.”very@\\ "very”.unusual@strange.example.com*/
                           
                           @"very.unusual.\"@\".unusual.com@example.com",
                           
                           
                           nil];
    
    
    for (NSString* email in emailArray) {
        [obj setValue:email forKey:@"email"];
        [user registerUser:obj];
    }
  
    //test passa se  manda eccezioni
    [mockService  verify];
 
    
}

//--------------------

- (void) testFailWithGenderNilOrNotNumber {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    [obj setValue:nil forKey:@"gender"];
    [user registerUser:obj];
    [obj setValue:@"" forKey:@"gender"];
    [user registerUser:obj];
    
    //test deve andare a buon fine
    [mockService  verify];

}

- (void) testFailWithNameNilOrAvoid {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    [obj setValue:nil forKey:@"name"];
    [user registerUser:obj];
    [obj setValue:@"" forKey:@"name"];
    [user registerUser:obj];
    
    //test deve andare a buon fine
    [mockService  verify];
    
}

- (void) testFailWithBirthdayNilOrAvoid {
    
    
    [[mockService expect] userDidLogin:[OCMArg any]];    
    [obj setValue:nil forKey:@"birthday"];
    [user registerUser:obj];
    [obj setValue:@"121212" forKey:@"birthday"];
    [user registerUser:obj];
    
    //test deve andare a buon fine
    [mockService  verify];
    
}

- (void) testFailWithPasswordNilOrShort {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    [obj setValue:nil forKey:@"password"];
    [user registerUser:obj];
    
    NSArray* pwdArray = [[NSArray alloc] initWithObjects:
                         @"",
                         @"1",
                         @"ff",
                         @"123",
                         @"sdss",
                         nil];
    
    for (id pws in pwdArray) {
        [obj setValue:pws forKey:@"password"];
        [user registerUser:obj];
    }
    
    
    //test deve andare a buon fine
    [mockService  verify];
    
}
- (void) testOKEqualPassword {
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    [obj setValue:@"12345" forKey:@"password"];
    [obj setValue:@"12345" forKey:@"password2"];
    [user registerUser:obj];
    //test passa se chiamo metodo
    [mockService  verify];
    
}
- (void) testOKNotEqualPassword {
    
    
    [[mockService expect] userDidLogin:[OCMArg any]];
    
    [obj setValue:@"123454" forKey:@"password"];
    [obj setValue:@"12345" forKey:@"password2"];
    [user registerUser:obj];
    
    //test passa se non chiamo metodo
    GHAssertThrows([mockService  verify],@"errore");
    
    //test anche se password2 è nil o meno
    [obj setValue:nil forKey:@"password2"];
    
    GHAssertThrows([mockService  verify],@"errore");
    
    
}


- (void) testOKRegister{
    
    
    //[[mockService expect] userDidLogin:[OCMArg any]];
    [user registerUser:obj];
    
   // [obj setValue:nil forKey:@"password2"];
    // [user registerUser:obj];
    
//    //test passa se non chiamo metodo
//    GHAssertThrows([mockService  verify],@"errore");
//    
//    //test anche se password2 è nil o meno
//    [obj setValue:nil forKey:@"password2"];
//    
//    GHAssertThrows([mockService  verify],@"errore");
    
    
}




@end