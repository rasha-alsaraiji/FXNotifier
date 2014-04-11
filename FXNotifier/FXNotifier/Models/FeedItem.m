//
//  FeedItem.m
//  FXNotifier
//
//  Created by RashOosh on 2/11/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem
@synthesize KEY_CATEGORY,KEY_CATEGORYID,KEY_DATETIME,KEY_DETAILS,KEY_FEEDID,KEY_FEEDTITLE,KEY_ROWID,KEY_THUMB,KEY_TITLE,KEY_URL;
@synthesize ROWID,CATEGORY,CATEGORYID,DATETIME,DETAILS,FEEDID,FEEDTITLE,THUMB,TITLE,URL;

-(id)initWithKeys
{
    self = [super init];
    if(self)
    {
    self.KEY_ROWID = @"_id";
    self.KEY_TITLE = @"fldTitle";
     self.KEY_URL = @"fldUrl";
    self.KEY_CATEGORYID = @"fldCategoryId";
    self.KEY_CATEGORY = @"fldCategory";
     self.KEY_FEEDID = @"fldFeedId";
     self.KEY_FEEDTITLE = @"fldFeedTitle";
     self.KEY_DETAILS = @"fldDetails";
     self.KEY_THUMB = @"fldThumb";
   self.KEY_DATETIME = @"fldDatetime";
    }
    return self;
}
-(id)initWithvalues :(int)RowID_ title:(NSString *)TITE_ url:(NSString *)URL_ categoryid:(int)CATEGORYID_ category:(NSString *)CATEGORY_ feedid:(int)FEEDID_ feedtitle:(NSString *)FEEDTITLE_  details:(NSString *)DETAILS_ thumb:(NSString *)THUMB_  datetime:(NSString *)DATETIME_
{
  self=  [super init];
    if(self)
    {
    self.ROWID=RowID_ ;
        
         if([TITE_ isKindOfClass:[NSNull class]])
            self.TITLE=@"" ;
        else
    self.TITLE=TITE_;
        
        if([URL_ isKindOfClass:[NSNull class]])
            self.URL=@"" ;
        else
    self.URL=URL_;
        
    self.CATEGORYID=CATEGORYID_ ;
        if([CATEGORY_ isKindOfClass:[NSNull class]])
            self.CATEGORY=@"" ;
        else
    self.CATEGORY=CATEGORY_;
    self.FEEDID=FEEDID_ ;
        
       if([FEEDTITLE_ isKindOfClass:[NSNull class]])
            self.FEEDTITLE=@"" ;
        else
    self.FEEDTITLE=FEEDTITLE_;
        if([DETAILS_ isKindOfClass:[NSNull class]])
            self.DETAILS=@"" ;
        else
    self.DETAILS=DETAILS_;
        
        if([THUMB_ isKindOfClass:[NSNull class]])
            self.THUMB=@"" ;
        else
    self.THUMB=THUMB_;
        
        if([DATETIME_ isKindOfClass:[NSNull class]])
            self.DATETIME=@"" ;
        else
             self.DATETIME=DATETIME_;
    }
    return self;
}
@end
