//
//  SignUpControllerViewController.m
//  WeOrderTest
//
//  Created by Simone Zandonà on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUpController.h"
#import "WOUser.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SignUpController ()

@end

@implementation SignUpController
@synthesize scroll;

@synthesize birthday;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [scroll setContentSize:CGSizeMake(([scroll bounds].size.width),450) ];
}

- (void)viewDidUnload
{
    [self setScroll:nil];
    [self setBirthday:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) userDidLogin:(NSString *)msg{
    
    NSLog(@"Login OK");
}

-(void) userDidFailLoginWithError:(NSString *)msg{
    
    NSLog(@"Login Fallito %@",msg);
    alert = [[UIAlertView alloc] initWithTitle:@"SignUp" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

-(void) userDidLogout:(NSString *)msg{
    
    
    
    NSLog(@"Logout");
    
}

#pragma #mark
#pragma #mark Register Done Function


- (IBAction)registerDone:(id)sender {
    
    
    
    user = [[WOUser alloc] initWithDelegate:self];
    
    NSTimeInterval t =[[(UIDatePicker*)[self.view viewWithTag:11] date] timeIntervalSince1970];
    NSNumber* time = [[NSNumber alloc] initWithFloat:(float)t]; 
    
   
    NSDictionary* registerData = [[NSDictionary alloc] initWithObjectsAndKeys:
    [(UITextField*)[self.view viewWithTag:1] text ],@"name",[(UITextField*)[self.view viewWithTag:2] text],@"username",
    [[(UITextField*)[self.view viewWithTag:3] text] substringWithRange:NSMakeRange(0, 1)],@"gender",
     time,@"birthday",
    [(UITextField*)[self.view viewWithTag:5] text],@"password",[(UITextField*)[self.view viewWithTag:6] text],@"password2",nil ];
    [user registerUser:registerData];
    
    
}


#pragma #mark
#pragma #mark DatePicker and PickerView Function

- (void) genderOrBirthdayViewWithUpOrDownMove:(BOOL)type move:(float)move{

    CGRect birthdayFrame = birthday.frame;
    float control = move;
    
    if(move>0){ //devo abbassarla
        control =   self.view.frame.size.height;
        
    }else{ //devo alzarla
        [[birthday.subviews objectAtIndex:0] setHidden:(type)];
        [[birthday.subviews objectAtIndex:1] setHidden:(!type)];
     
        control =  self.view.frame.size.height - birthdayFrame.size.height;
        move += birthdayFrame.origin.y ;
    }
    if(birthdayFrame.origin.y != control ){
        birthdayFrame.origin.y = move;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             birthday.frame = birthdayFrame;
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    }

}


#pragma #mark PickerView Function
- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
    
    if(row == 0){
	return @"Male";
    }else{
    return @"Female";
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(row == 0){
        [  (UITextView*)[self.view viewWithTag:3] setText:@"Male"];
    }else {
        [  (UITextView*)[self.view viewWithTag:3] setText:@"Female"];    
    
    }
}


#pragma #mark DateChange Function

-(IBAction)dateChanged:(UIDatePicker*)sender
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [  (UITextView*)[self.view viewWithTag:4] setText:[formatter stringFromDate:[sender date]]];
    NSLog(@"dimmi la data se te  la se %@",[sender date]);
     

}

#pragma #mark

#pragma #mark TextFieldDelegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    //nascondo
    [self genderOrBirthdayViewWithUpOrDownMove:YES move:self.view.frame.size.height]; 
    if(textField.tag==3 || textField.tag==4 ){
        CGRect birthdayFrame = birthday.frame; 
        BOOL genderOrBirth = YES;
        if(textField.tag==4){
            genderOrBirth = NO;
        }
        //mostro
        [self genderOrBirthdayViewWithUpOrDownMove:genderOrBirth move:(-birthdayFrame.size.height)]; 
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
   
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        NSLog(@"vediamo il tag %d",nextTag);
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //nascondo
    [self genderOrBirthdayViewWithUpOrDownMove:YES move:self.view.frame.size.height]; 
    [scroll adjustOffsetToIdealIfNeeded];    
}



@end
