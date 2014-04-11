//
//  SettingsViewController.h
//  FXNotifier
//
//  Created by RashOosh on 2/7/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
     NSMutableDictionary * dicKeys;
    NSArray *AllKeys;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)GoBack:(id)sender;

@end
