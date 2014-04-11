//
//  EventItem.h
//  FXNotifier
//
//  Created by RashOosh on 2/11/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventItem : NSObject

@property (nonatomic,strong) NSString * KEY_id;
@property (nonatomic,strong) NSString *  KEY_IdEcoCalendarType ;
@property (nonatomic,strong) NSString *  KEY_EcoCalendarType ;
@property (nonatomic,strong) NSString *  KEY_IdEcoCalendar;
@property (nonatomic,strong) NSString * KEY_IdEcoCalendarDate ;

@property (nonatomic,strong) NSString *  KEY_DateTime ;
@property (nonatomic,strong) NSString *  KEY_InternationalCode ;
@property (nonatomic,strong) NSString *  KEY_Country ;
@property (nonatomic,strong) NSString *  KEY_IdCountry ;
@property (nonatomic,strong) NSString *  KEY_Currency ;

@property (nonatomic,strong) NSString *  KEY_Name  ;
@property (nonatomic,strong) NSString *  KEY_HTMLDescription  ;
@property (nonatomic,strong) NSString *  KEY_Preliminar ;
@property (nonatomic,strong) NSString *  KEY_ForType  ;
@property (nonatomic,strong) NSString *  KEY_For  ;
@property (nonatomic,strong) NSString *  KEY_Volatility  ;
@property (nonatomic,strong) NSString *  KEY_Unit  ;
@property (nonatomic,strong) NSString *  KEY_Actual  ;
@property (nonatomic,strong) NSString *  KEY_PotActual  ;
@property (nonatomic,strong) NSString *  KEY_Consensus  ;
@property (nonatomic,strong) NSString *  KEY_PotConsensus ;

@property (nonatomic,strong) NSString *  KEY_Relation ;

@property (nonatomic,strong) NSString *  KEY_Previous ;
@property (nonatomic,strong) NSString *  KEY_PotPrevious ;

@property (nonatomic,strong) NSString *  KEY_Revised ;
@property (nonatomic,strong) NSString *  KEY_DisplayActual ;
@property (nonatomic,strong) NSString *  KEY_DisplayPrevious ;
@property (nonatomic,strong) NSString *  KEY_DisplayConsensus ;
@property (nonatomic,strong) NSString *  KEY_DisplayRevised ;
@property (nonatomic,strong) NSString *  KEY_Precision ;
@property (nonatomic,strong) NSString *  KEY_EcoCalendarTypeAr;
@property (nonatomic,strong) NSString *  KEY_CountryAr;
@property (nonatomic,strong) NSString *  KEY_NameAr;
@property (nonatomic,strong) NSString *  KEY_HTMLDescriptionAr;

//---
@property (nonatomic) int  _id;
@property (nonatomic,strong) NSString *  IdEcoCalendarType ;
@property (nonatomic,strong) NSString * EcoCalendarType ;
@property (nonatomic,strong) NSString * IdEcoCalendar;
@property (nonatomic,strong) NSString * IdEcoCalendarDate ;

@property (nonatomic,strong) NSString *  DateTime ;
@property (nonatomic,strong) NSString *  InternationalCode ;
@property (nonatomic,strong) NSString *  Country ;
@property (nonatomic,strong) NSString *  IdCountry ;
@property (nonatomic,strong) NSString *  Currency ;

@property (nonatomic,strong) NSString *  Name  ;
@property (nonatomic,strong) NSString *  HTMLDescription  ;
@property (nonatomic) int  Preliminar ;
@property (nonatomic,strong) NSString *  ForType  ;
@property (nonatomic,strong) NSString * For  ;
@property (nonatomic) int Volatility  ;
@property (nonatomic,strong) NSString *  Unit  ;
@property (nonatomic,strong) NSString *  Actual  ;
@property (nonatomic,strong) NSString * PotActual  ;
@property (nonatomic,strong) NSString *  Consensus  ;
@property (nonatomic,strong) NSString *  PotConsensus ;
@property (nonatomic,strong) NSString * Previous;
@property (nonatomic) int Relation ;
//@property (nonatomic,strong) NSString *  KEY_Relation ;
@property (nonatomic,strong) NSString *  PotPrevious ;
@property (nonatomic,strong) NSString *  Revised ;
@property (nonatomic,strong) NSString *  DisplayActual ;
@property (nonatomic,strong) NSString *  DisplayPrevious ;
@property (nonatomic,strong) NSString *  DisplayConsensus ;
@property (nonatomic,strong) NSString * DisplayRevised ;
@property (nonatomic) int  Precision ;
@property (nonatomic,strong) NSString * EcoCalendarTypeAr;
@property (nonatomic,strong) NSString * CountryAr;
@property (nonatomic,strong) NSString *  NameAr;
@property (nonatomic,strong) NSString * HTMLDescriptionAr;


-(id)initWithvalues :(int)ID Volatility:(int )Volatility_ Relation :(int)_Relation Revised:(NSString*)_Revised PotActual:(NSString *)PotActual_ PotConsensus:(NSString *)PotConsensus_ PotPrevious:(NSString *)PotPrevious_ Precision:(int )Precision_ Preliminar:(int)Preliminar_ Actual:(NSString *)Actual_ Consensus :(NSString *)Consensus_ Country:(NSString *)Country_ CountryAr:(NSString *)CountryAr_ Currency:(NSString *)Currency_ DateTime:(NSString *)DateTime_ DisplayActual:(NSString *)DisplayActual_ DisplayConsensus:(NSString *)DisplayConsensus_ DisplayPrevious:(NSString *)DisplayPrevious_ DisplayRevised:(NSString *)DisplayRevised_ EcoCalendarType:(NSString *)EcoCalendarType_  EcoCalendarTypeAr:(NSString *)EcoCalendarTypeAr_  For:(NSString *)For_ ForType:(NSString *)ForType_ HTMLDescription:(NSString *)HTMLDescription_ HTMLDescriptionAr:(NSString *) HTMLDescriptionAr_ IdCountry:(NSString *)IdCountry_ IdEcoCalendar:(NSString *)IdEcoCalendar_  IdEcoCalendarDate:(NSString *)IdEcoCalendarDate_ IdEcoCalendarType:(NSString *)IdEcoCalendarType_  InternationalCode:(NSString *)InternationalCode_ Name:(NSString *)Name_ NameAr:(NSString *)NameAr_ Unit :(NSString *)Unit_  Previous:(NSString *)previous_   ;

-(id)initWithKeys;
@end
