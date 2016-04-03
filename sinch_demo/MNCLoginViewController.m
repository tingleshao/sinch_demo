//
//  MNCLoginViewController.m
//  sinch_demo
//
//  Created by Chong Shao on 3/31/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import "MNCLoginViewController.h"

@interface MNCLoginViewController ()


@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation MNCLoginViewController

#pragma mark Boilerplate methods

// OK except for "Login with default user"
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ios-sinch-messaging-tutorial";
    self.promptLabel.hidden = YES;
    
    // Tab the view to dismiss keyboard
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
}

// TODO: ChatMateListViewController has to have a "myUserId"
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginSegue"]) {
        MNCChatMateListViewController *destViewController = segue.destinationViewController;
        //      destViewController.myUserId = self.usernameField.text;
        destViewController.myUserId = @"chong";
    }
}

// OK, tap view to dismiss keyboard
- (void)didTapOnView {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark User interface behavioral methods

// Tab the view to dismiss keyboard

#pragma mark Functional methods

// TODO: do this later
//- (IBAction)signup:(id)sender {
//    PFUser *pfUser = [PFUser user];
//    pfUser.username = self.usernameField.text;
//    pfUser.password = self.passwordField.text;
//    
//    __weak typeof(self) weakSelf = self;
//    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            weakSelf.promptLabel.textColor = [UIColor greenColor];
//            weakSelf.promptLabel.text = @"Signup successful!";
//            weakSelf.promptLabel.hidden = NO;
//        } else {
//            weakSelf.promptLabel.textColor = [UIColor redColor];
//            weakSelf.promptLabel.text = [error userInfo][@"error"];
//            weakSelf.promptLabel.hidden = NO;
//        }
//    }];
//}


// TODO: we dont do Login right now
- (IBAction)login:(id)sender {
    __weak typeof(self) weakSelf = self;
 ////   [PFUser logInWithUsernameInBackground:self.usernameField.text
 //                                password:self.passwordField.text
 //                                   block:^(PFUser *pfUser, NSError *error)
  //   {
      //   if (pfUser && !error) {
        
         // Proceed to next screen after successful login.
             weakSelf.promptLabel.hidden = YES;
             [weakSelf performSegueWithIdentifier:@"LoginSegue" sender:self];
        // } else {
             // The login failed. Show error.
      //       weakSelf.promptLabel.textColor = [UIColor redColor];
       //      weakSelf.promptLabel.text = [error userInfo][@"error"];
       //      weakSelf.promptLabel.hidden = NO;
        // }
    // }];
}


@end
