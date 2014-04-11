//
//  SubMainViewController.h
//  FXNotifier
//
//  Created by RashOosh on 2/1/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
@interface SubMainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    int pageNumber;
    //This is the index of the cell which will be expanded
    NSInteger selectedIndex;
   

}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *ListEvents;
@property (nonatomic, strong) NSMutableArray *ListDates;
@property (nonatomic) int CurrentIndex;
@property(nonatomic,strong)Manager *manager;
@property(nonatomic,strong) id delegate;
- (id)initWithPageNumber:(int)page;
-(void)DidFinishLoadEvents;
@end
