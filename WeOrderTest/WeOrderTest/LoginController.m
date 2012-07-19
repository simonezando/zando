//
//  ViewController.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "RestKit/RestKit.h"
#import "RestKit/RKRequestSerialization.h"
#import "RestKit/RKJSONParserJSONKit.h"
#import "RestKit/JSONKit.h"

#import <FBiOSSDK/FacebookSDK.h>
#import "WOUser.h"


@interface LoginController ()

@end

@implementation LoginController
@synthesize scroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //NSLog(@"I am your RKClient singleton : %@", [RKClient sharedClient]); 
     
    [scroll setContentSize:CGSizeMake(([scroll bounds].size.width),420) ];
    self.navigationItem.hidesBackButton = YES;
      
}

- (void)viewDidUnload
{
    [self setScroll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma #mark codice

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}








- (void) userDidLogin:(NSString *)msg{

   NSLog(@"Login OK");
    [self performSegueWithIdentifier:@"LoginOk" sender:nil];
    
}

-(void) userDidFailLoginWithError:(NSString *)msg{
    
    
    alertView = [[UIAlertView alloc] initWithTitle:@"Login" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];

    NSLog(@"Login Fallito");

}

-(void) userDidLogout:(NSString *)msg{

    NSLog(@"Logout");

}

- (IBAction)loginWithFacebook:(id)sender {  
 
    user = [[WOUser alloc] initWithDelegate:self];
    //                                   
    [user loginWithFacebook];
    
}


- (IBAction)login:(id)sender {  
    
     user = [[WOUser alloc] initWithDelegate:self];
    //                              
    @try {
    //    [user login:[(UITextField*)[self.view viewWithTag:1] text]   withPassword:[(UITextField*)[self.view viewWithTag:2] text] facebook:NO];
        [user login:@"simone@gmail.com"   withPassword:@"123456" facebook:NO];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Valori non inseriti");
    }
  
    
    
}




@end
