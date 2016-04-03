//
//  MNCChatMateListViewController.m
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import "MNCChatMateListViewController.h"

@interface MNCChatMateListViewController ()

//@property (strong, nonatomic) NSMutableArray *chatMatesArray;

//@property (strong, nonatomic) MNCDialogViewController *activeDialogViewController;  /* add this line */

@end

@implementation MNCChatMateListViewController


// DONE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = self.myUserId;
    self.chatMatesArray = [[NSMutableArray alloc] init];
}


// TODO: don't do parse right now
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.activeDialogViewController = nil;  /* add this line */
    [self retrieveChatMatesFromParse];
}


// TODO: now hardcode the chatMateId, later change it to something from Parse
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Segue to open a dialog
    if ([segue.identifier isEqualToString:@"OpenDialogSegue"]) {
        self.activeDialogViewController = segue.destinationViewController;
        NSInteger chatMateIndex = [[self.tableView indexPathForCell:(UITableViewCell *)sender] row];
    //    self.activeDialogViewController.chatMateId = self.chatMatesArray[chatMateIndex];
        self.activeDialogViewController.chatMateId = @"Wang"; 
        self.activeDialogViewController.myUserId = self.myUserId;   /* add this line */
        NSLog(@"sin chat mate view controller: my user id: %@", self.myUserId);
        return;
    }
}

- (void)dealloc {
    //Logout current user
   // [PFUser logOut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource protocol methods
// DONE: all three below
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatMatesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatMateListPrototypeCell" forIndexPath:indexPath];
    NSString *chatMateId = [self.chatMatesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = chatMateId;
    
    return cell;
}


// TODO: don't do Parse
- (void)retrieveChatMatesFromParse {
    [self.chatMatesArray removeAllObjects];
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.chatMatesArray addObject:@"a"];
    [weakSelf.chatMatesArray addObject:@"b"];
    [weakSelf.chatMatesArray addObject:@"Wang"];
    [weakSelf.chatMatesArray addObject:@"d"];

//    PFQuery *query = [PFUser query];
//    [query orderByAscending:@"username"];
//    [query whereKey:@"username" notEqualTo:self.myUserId];
//    
//    __weak typeof(self) weakSelf = self;
//    [query findObjectsInBackgroundWithBlock:^(NSArray *chatMateArray, NSError *error) {
//        if (!error) {
//            for (int i = 0; i < [chatMateArray count]; i++) {
//                [weakSelf.chatMatesArray addObject:chatMateArray[i][@"username"]];
//            }
//            [weakSelf.tableView reloadData];
//        } else {
//            NSLog(@"Error: %@", error.description);
//        }
//    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
