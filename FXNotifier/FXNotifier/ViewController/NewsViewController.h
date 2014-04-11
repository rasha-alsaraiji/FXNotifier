//
//  NewsViewController.h
//  FXNotifier
//
//  Created by RashOosh on 2/4/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "FeedItem.h"

@interface NewsViewController :UIViewController  {
    UILabel *lblTitle;
    UILabel *lblsubtitle;
    UILabel *lblDate;
    
}
@property (nonatomic,strong)IBOutlet UILabel *lblTitle;
@property (nonatomic,strong)IBOutlet UILabel *lblsubtitle;
@property (nonatomic,strong)IBOutlet UILabel *lblDate;
@property (nonatomic,strong) FeedItem *feeditem;

-(IBAction)GoBack:(id)sender;


@end
