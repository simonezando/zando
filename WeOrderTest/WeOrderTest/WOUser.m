//
//  WOUser.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WOUser.h"
#import "WOUserLoginDelegate.h"
#import "RestKit/RestKit.h"
#import "RestKit/RKRequestSerialization.h"
#import "RestKit/RKJSONParserJSONKit.h"
#import <FBiOSSDK/FacebookSDK.h>




@implementation WOUser

@synthesize loginServiceDelegate;

#pragma #mark
#pragma #mark Costruttore con delegate (viewController che implementa WOUserLoginDelegate
- (id) initWithDelegate:(NSObject<WOUserLoginDelegate>*) delegate{


    self = [super init];
    if (self) {
        
        [self setLoginServiceDelegate:delegate];
        
    }
    return self;
    
}




#pragma #mark
#pragma #mark Metodi Login

/*######################-------login------################################*/
#pragma #mark login username password

- (void) login:(NSString *)username withPassword:(NSString *)password facebook:(BOOL)fb{

  if( username!=nil && ![username isEqualToString:@""] &&
        password !=nil &&  ![password isEqualToString:@""]){
            
      NSNumber *facebookBool = [[NSNumber alloc] initWithBool:fb];

      
      
      NSDictionary* par = [NSDictionary dictionaryWithKeysAndObjects:@"username",username,@"password",password,@"client",@"iphone",@"facebook", facebookBool,nil];
      // create a JSON string from your NSDictionary 
      id<RKParser> parser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeJSON];
      NSError *error = nil;
      NSString *json = [parser stringFromObject:par error:&error];
      
      NSLog(@"qui arrivo");
      // send data
      if (!error){
          
          RKRequest *request = [[RKClient sharedClient]  post:@"/login" params:[RKRequestSerialization serializationWithData:[json dataUsingEncoding:NSUTF8StringEncoding] MIMEType:RKMIMETypeJSON] delegate:self];
          [request setUserData:@"Login"];
          
          
      }
      
  }else{
  
      NSLog(@"Nessuna risposta");
  
  }
    
}

#pragma #mark loginFacebook
- (void) loginWithFacebook{
    
    NSLog(@"errore ");
    
    [FBSession sessionOpenWithPermissions:nil 
                        completionHandler:^(FBSession *session, 
                                            FBSessionState status, 
                                            NSError *error) {
                            if (session.isOpen) {
                                FBRequest *me = [FBRequest requestForMe];
                                [me startWithCompletionHandler: ^(FBRequestConnection *connection, 
                                                                  NSDictionary<FBGraphUser> *my,
                                                                  NSError *error) {
                                    
                                    [self login:my.id withPassword:session.accessToken facebook:YES ];
                                    
                                   
                                }];
                            }else{
                                NSLog(@"Questo è un grande errore");
                            
                            }
                            
                        }];
    
    
    
}


#pragma #mark
/*######################-------registrazione------################################*/
#pragma #mark Metodi Registrazione
#pragma #mark checkField
- (BOOL) checkFieldRegister:(id)user withMessage:(NSString**)message{

    NSString* name =   [user valueForKey:@"name"];
    NSString* email =   [user valueForKey:@"username"];
    NSString* gender =   [user valueForKey:@"gender"];
    NSNumber* birthday =   [user valueForKey:@"birthday"];
    NSString* password =   [user valueForKey:@"password"];
    NSString* password2 =   [user valueForKey:@"password2"];
    
    
    
    /*#####################-----email----------###################*/
    
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
  // emailRegEx = @"[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?";
       
     NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailRegEx options:0 error:NULL];
     
    @try {
        
        NSTextCheckingResult *match = [regex firstMatchInString:email options:0 range:NSMakeRange(0, [email length])];
        if(!match){
            
            *message = @"Email not valid";
            NSLog(@"email onn corretta");
            return NO;
            //[self.loginServiceDelegate userDidFailLoginWithError:@"Email not valid"];
            
        }else{
            
            NSLog(@"dai che veniamo %@",[email substringWithRange:[match rangeAtIndex:0]]); //gives the range of the group in parentheses
        }

    }
    @catch (NSException *exception) {
        
        *message = @"Email not valid";
        NSLog(@"il valore della stringa è nullo");
        return NO;
    }
        
    
  /*#####################-----password----------###################*/
    
    if(password.length <5 || password == nil){
        
        *message = @"Password too short";
        NSLog(@"Password corta");
        
        return NO;
        
    }   
    else { //password > 4 
        
        if(password2 == nil || ![password isEqualToString:password2]){ 
            
            *message = @"Passwords don't match";
            NSLog(@"il valore della stringa è nullo");
            return NO;
        }
    }
    
 /*#####################-----name----------###################*/
    
    if( name == nil || [name isEqualToString:@""] ){
        
        *message = @"Name is empty";
        NSLog(@"name is empty");
        return NO;
        
    }     
    
    
 /*#####################-----gender----------###################*/
 
    if( gender == nil || [gender isEqualToString:@""]  ){
        
        *message = @"Gender is empty";
        NSLog(@"gender is empty");
        return NO;
   
    }   

    /*#####################-----birthday----------###################*/
    
    if( birthday == nil || ![birthday isKindOfClass:[NSNumber class]] ){
        
        *message = @"Birthday is empty";
        NSLog(@"Birthday is empty");
        return NO;
        
    } 

    
    
    return YES;
}
#pragma #mark registrazione utente
- (void) registerUser:(NSObject *)user{
    
    NSString* message = nil;
    
   
    
    if( [self checkFieldRegister:user withMessage:&message ] == NO   ){
        
        [self.loginServiceDelegate userDidFailLoginWithError:message];
    
    }else {
        //salvo in un field che mi serve nella gestione della richiesta asicncrona
         
        
        // create a JSON string from your NSDictionary 
        id<RKParser> parser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeJSON];
        NSError *error = nil;
        NSString *json = [parser stringFromObject:user error:&error];
        
        // send data
        if (!error){
            
            _user = user;
            
            RKRequest *request = [[RKClient sharedClient]  post:@"/register" params:[RKRequestSerialization serializationWithData:[json dataUsingEncoding:NSUTF8StringEncoding] MIMEType:RKMIMETypeJSON] delegate:self];
            

            
            [request setUserData:@"Register"];
           
            
        }

    }
        
      
   
}



#pragma #mark
/*############-------gestione asincrona delle risposte del server------##########################*/
#pragma #mark Metodi per la gestione asincrona delle risposte del server
- (void) request:(RKRequest*)request didLoadResponse:(RKResponse*)response {    

    
    //gestione del login
    if([request.userData isEqualToString:@"Login"]){ 
        
        if ([request isPOST]) {  
            
            // Handling POST           
            if ([response isJSON]) { 
                
                RKJSONParserJSONKit* parser = [RKJSONParserJSONKit new];
                    
                NSError* error;
                id obj = [parser objectFromString:[response bodyAsString] error:&error];
                
                if ([obj valueForKey:@"randomKey"]) {
                    
                    NSUserDefaults* userinfo = [NSUserDefaults standardUserDefaults];
                    [userinfo setValue:[obj valueForKey:@"randomKey"] forKey:@"token"];
                    [userinfo synchronize];
                    
                    [self.loginServiceDelegate userDidLogin:@"Login successfully"];
                
                }else {
                    [self.loginServiceDelegate userDidFailLoginWithError:@"Failed to authenticate"];
                }
            }  

        
        }  
    }else if([request.userData isEqualToString:@"Register"]){ 
        NSLog(@"print response register %@",[response bodyAsString]);

        if ([request isPOST]) {  
            
            // Handling POST           
            if ([response isJSON]) { 
                
                RKJSONParserJSONKit* parser = [RKJSONParserJSONKit new];
                NSError* error;
                
                //ricevo la risposta dal server e la mappo in un obj
                id obj = [parser objectFromString:[response bodyAsString] error:&error];
                
                
                if ([(NSNumber*)[obj valueForKey:@"code"] intValue]  == 500) {
                    
                    NSString* message = [[NSString alloc] initWithFormat:@"Registration error - %@", [obj valueForKey:@"message"],nil];
                    
                       
                    NSLog(@"mostra il messaggio di registrazione non a buon fine %@ ",message);
                    [self.loginServiceDelegate userDidFailLoginWithError:message];
                    
                    
                }else { //se la registrazione va a buon fine effettuo il login
                    
                    NSLog(@"mostra il messaggio di avvenuta registrazione %@ ",[obj valueForKey:@"message"]);
                    
                    
                    
                    [self login:[_user valueForKey:@"username"] withPassword:[_user valueForKey:@"password"] facebook:NO];
                    
                    
                }        
            }
        }
    }
}

- (void) request:(RKRequest *)request didFailLoadWithError:(NSError *)error{
    
    NSLog(@"Mancanza di rete");    
    [self.loginServiceDelegate userDidFailLoginWithError:@"Connection problem"];
}
@end
