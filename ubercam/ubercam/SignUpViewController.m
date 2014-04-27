//
//  SignUpViewController.m
//  ubercam
//
//  Created by FangYiXiong on 14-4-25.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signup:(id)sender {
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (username.length != 0 && password.length != 0) {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } else {
                // Show the errorString somewhere and let the user try again.
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"注册失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
            }
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码为空" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
