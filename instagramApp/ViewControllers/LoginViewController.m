//
//  LoginViewController.m
//  instagramApp
//
//  Created by Mariana Martinez on 06/07/20.
//  Copyright © 2020 Mariana Martinez. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSignUp:(id)sender {
    
    if ([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Username and Password Fields Required"
               message:@"Please enter your username and password"
        preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
        }];
        
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
    } else {
    
    // initialize a user object
       PFUser *newUser = [PFUser user];
       
       // set user properties
       newUser.username = self.usernameTextField.text;
       newUser.password = self.passwordTextField.text;
       
       // call sign up function on the object
       [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
           if (error != nil) {
               
               NSLog(@"Error: %@", error.localizedDescription);
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                      message:error.localizedDescription
               preferredStyle:(UIAlertControllerStyleAlert)];
               
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        
               [alert addAction:okAction];
               
               [self presentViewController:alert animated:YES completion:^{}];
               
           } else {
               NSLog(@"User registered successfully");
               
             //  [self performSegueWithIdentifier:@"loginSegue" sender:nil];

           }
       }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
