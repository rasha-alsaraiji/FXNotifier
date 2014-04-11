//
//  FeedItem.h
//  FXNotifier
//
//  Created by RashOosh on 2/11/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property (nonatomic,strong) NSString * KEY_ROWID;
@property (nonatomic,strong) NSString *  KEY_TITLE ;
@property (nonatomic,strong) NSString *  KEY_URL ;
@property (nonatomic,strong) NSString *  KEY_CATEGORYID;
@property (nonatomic,strong) NSString * KEY_CATEGORY ;
@property (nonatomic,strong) NSString *  KEY_FEEDID ;
@property (nonatomic,strong) NSString *  KEY_FEEDTITLE ;
@property (nonatomic,strong) NSString *  KEY_DETAILS ;
@property (nonatomic,strong) NSString *  KEY_THUMB ;
@property (nonatomic,strong) NSString *  KEY_DATETIME ;


@property (nonatomic) int  ROWID;
@property (nonatomic,strong) NSString * TITLE ;
@property (nonatomic,strong) NSString * URL ;
@property (nonatomic) int CATEGORYID;
@property (nonatomic,strong) NSString *  CATEGORY ;
@property (nonatomic) int  FEEDID ;
@property (nonatomic,strong) NSString *  FEEDTITLE ;
@property (nonatomic,strong) NSString *  DETAILS ;
@property (nonatomic,strong) NSString *  THUMB ;
@property (nonatomic,strong) NSString *  DATETIME ;


-(id)initWithKeys;
-(id)initWithvalues :(int)RowID_ title:(NSString *)TITE_ url:(NSString *)URL_ categoryid:(int)CATEGORYID_ category:(NSString *)CATEGORY_ feedid:(int)FEEDID_ feedtitle:(NSString *)FEEDTITLE_  details:(NSString *)DETAILS_ thumb:(NSString *)THUMB_  datetime:(NSString *)DATETIME_ ;
@end
