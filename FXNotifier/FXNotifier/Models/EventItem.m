//
//  EventItem.m
//  FXNotifier
//
//  Created by RashOosh on 2/11/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "EventItem.h"

@implementation EventItem
@synthesize KEY_Actual,KEY_Consensus,KEY_Country,KEY_CountryAr,KEY_Currency,KEY_DateTime,KEY_DisplayActual,KEY_DisplayConsensus,KEY_DisplayPrevious,KEY_DisplayRevised,KEY_EcoCalendarType,KEY_EcoCalendarTypeAr,KEY_For,KEY_ForType,KEY_HTMLDescription,KEY_HTMLDescriptionAr,KEY_id,KEY_IdCountry,KEY_IdEcoCalendar,KEY_IdEcoCalendarDate,KEY_IdEcoCalendarType,KEY_InternationalCode,KEY_Name,KEY_NameAr,KEY_PotActual,KEY_PotConsensus,KEY_PotPrevious,KEY_Precision,KEY_Preliminar,KEY_Relation,KEY_Revised,KEY_Unit,KEY_Volatility,KEY_Previous;

@synthesize _id,Relation,Revised,PotActual,PotConsensus,PotPrevious,Precision,Preliminar,Actual,Consensus,Country,CountryAr,Currency,DateTime,DisplayActual,DisplayConsensus,DisplayPrevious,DisplayRevised,EcoCalendarType,EcoCalendarTypeAr,For,ForType,HTMLDescription,HTMLDescriptionAr,IdCountry,IdEcoCalendar,IdEcoCalendarDate,IdEcoCalendarType,InternationalCode,Name,NameAr,Unit,Volatility,Previous;
-(id)initWithKeys
{
    self = [super init];
    if(self)
    {
       self.KEY_Volatility=@"Volatility";
        self.KEY_Unit=@"Unit";
        self.KEY_Revised=@"Revised";
        self.KEY_Relation=@"Relation";
        self.KEY_Preliminar=@"Preliminar";
        self.KEY_Precision=@"Precision";
        self.KEY_PotPrevious=@"PotPrevious";
        self.KEY_PotConsensus=@"PotConsensus";
        self.KEY_PotActual=@"PotActual";
        self.KEY_NameAr=@"NameAr";
        self.KEY_Name=@"Name";
        self.KEY_InternationalCode=@"InternationalCode";
        self.KEY_IdEcoCalendarType=@"IdEcoCalendarType";
        self.KEY_IdEcoCalendarDate=@"IdEcoCalendarDate";
        self.KEY_IdEcoCalendar=@"IdEcoCalendar";
        self.KEY_IdCountry=@"IdCountry";
        self.KEY_id=@"_id";
        self.KEY_HTMLDescriptionAr=@"HTMLDescriptionAr";
        self.KEY_HTMLDescription=@"HTMLDescription";
        self.KEY_ForType=@"ForType";
        self.KEY_For=@"For";
        self.KEY_EcoCalendarTypeAr=@"EcoCalendarTypeAr";
        self.KEY_EcoCalendarType=@"EcoCalendarType";
        self.KEY_DisplayRevised=@"DisplayRevised";
        self.KEY_DisplayPrevious=@"DisplayPrevious";
        self.KEY_DisplayConsensus=@"DisplayConsensus";
        self.KEY_DisplayActual=@"DisplayActual";
        self.KEY_DateTime=@"DateTime";
        self.KEY_Currency=@"Currency";
        self.KEY_CountryAr=@"CountryAr";
        self.KEY_Country=@"Country";
        self.KEY_Consensus=@"Consensus";
        self.KEY_Actual=@"Actual";
        self.KEY_Previous=@"Previous";
       
        
    }
    return self;
}
-(id)initWithvalues :(int)ID Volatility:(int )Volatility_ Relation :(int)_Relation Revised:(NSString*)_Revised PotActual:(NSString *)PotActual_ PotConsensus:(NSString *)PotConsensus_ PotPrevious:(NSString *)PotPrevious_ Precision:(int)Precision_ Preliminar:(int)Preliminar_ Actual:(NSString *)Actual_ Consensus :(NSString *)Consensus_ Country:(NSString *)Country_ CountryAr:(NSString *)CountryAr_ Currency:(NSString *)Currency_ DateTime:(NSString *)DateTime_ DisplayActual:(NSString *)DisplayActual_ DisplayConsensus:(NSString *)DisplayConsensus_ DisplayPrevious:(NSString *)DisplayPrevious_ DisplayRevised:(NSString *)DisplayRevised_ EcoCalendarType:(NSString *)EcoCalendarType_  EcoCalendarTypeAr:(NSString *)EcoCalendarTypeAr_  For:(NSString *)For_ ForType:(NSString *)ForType_ HTMLDescription:(NSString *)HTMLDescription_ HTMLDescriptionAr:(NSString *) HTMLDescriptionAr_ IdCountry:(NSString *)IdCountry_ IdEcoCalendar:(NSString *)IdEcoCalendar_  IdEcoCalendarDate:(NSString *)IdEcoCalendarDate_ IdEcoCalendarType:(NSString *)IdEcoCalendarType_  InternationalCode:(NSString *)InternationalCode_ Name:(NSString *)Name_ NameAr:(NSString *)NameAr_ Unit :(NSString *)Unit_  Previous:(NSString *)previous_  

{
    self = [super init];
    if(self)
    {
        self._id=ID;
        
        self.Volatility=Volatility_ ;
        
      

        self.Relation=_Relation ;
         if([_Revised isKindOfClass:[NSNull class]])
             _Revised=@"";
        self.Revised=_Revised;
        if([PotPrevious_ isKindOfClass:[NSNull class]])
            PotPrevious_=@"";
        self.PotPrevious=PotPrevious_;
        
        if([previous_ isKindOfClass:[NSNull class]])
            previous_=@"";
        self.Previous=previous_;
        
        
        if([PotConsensus_ isKindOfClass:[NSNull class]])
            PotConsensus_=@"";
        self.PotConsensus=PotConsensus_;
        
        if([PotActual_ isKindOfClass:[NSNull class]])
            PotActual_=@"";
        self.PotActual=PotActual_;
        
                self.Precision= Precision_ ;
        
        
        self.Preliminar=Preliminar_ ;
        
        if([Actual_ isKindOfClass:[NSNull class]])
            Actual_=@"";
        self.Actual=Actual_;
        
        if([Consensus_ isKindOfClass:[NSNull class]])
            Consensus_=@"";
        self.Consensus=Consensus_;
        
        if([Country_ isKindOfClass:[NSNull class]])
            Country_=@"";
        self.Country=Country_;
        
        if([CountryAr_ isKindOfClass:[NSNull class]])
            CountryAr_=@"";
        self.CountryAr=CountryAr_;
        
        if([Currency_ isKindOfClass:[NSNull class]])
            Currency_=@"";
        self.Currency=Currency_;
        
        if([DateTime_ isKindOfClass:[NSNull class]])
            DateTime_=@"";
        self.DateTime=DateTime_;
        
        if([DisplayRevised_ isKindOfClass:[NSNull class]])
            DisplayRevised_=@"";
        self.DisplayRevised=DisplayRevised_;
        
        if([DisplayPrevious_ isKindOfClass:[NSNull class]])
            DisplayPrevious_=@"";
        self.DisplayPrevious=DisplayPrevious_;
        
        if([DisplayConsensus_ isKindOfClass:[NSNull class]])
           DisplayConsensus_=@"";
        self.DisplayConsensus=DisplayConsensus_;
        
        if([DisplayActual_ isKindOfClass:[NSNull class]])
            DisplayActual_=@"";
        self.DisplayActual=DisplayActual_;
        
        if([EcoCalendarTypeAr_ isKindOfClass:[NSNull class]])
            EcoCalendarTypeAr_=@"";
        self.EcoCalendarTypeAr=EcoCalendarTypeAr_;
        
        if([EcoCalendarType_ isKindOfClass:[NSNull class]])
            EcoCalendarType_=@"";
        self.EcoCalendarType=EcoCalendarType_;
        
        if([IdEcoCalendarType_ isKindOfClass:[NSNull class]])
           IdEcoCalendarType_=@"";
        self.IdEcoCalendarType=IdEcoCalendarType_;
        
        if([IdEcoCalendarDate_ isKindOfClass:[NSNull class]])
            IdEcoCalendarDate_=@"";
        self.IdEcoCalendarDate=IdEcoCalendarDate_;
        
        if([IdEcoCalendar_ isKindOfClass:[NSNull class]])
            IdEcoCalendar_=@"";
        self.IdEcoCalendar=IdEcoCalendar_;
        
        if([IdCountry_ isKindOfClass:[NSNull class]])
            IdCountry_=@"";
        self.IdCountry=IdCountry_;
        
        if([Unit_ isKindOfClass:[NSNull class]])
            Unit_=@"";
        self.Unit=Unit_;
        
        if([InternationalCode_ isKindOfClass:[NSNull class]])
            InternationalCode_=@"";
        self.InternationalCode=InternationalCode_;

        
        if([Name_ isKindOfClass:[NSNull class]])
           Name_=@"";
        self.Name=Name_;
        
        if([NameAr_ isKindOfClass:[NSNull class]])
           NameAr_=@"";
        self.NameAr=NameAr_;
        
        if([For_ isKindOfClass:[NSNull class]])
            For_=@"";
        self.For=For_;
        
        if([ForType_ isKindOfClass:[NSNull class]])
            ForType_=@"";
        self.ForType=ForType_;
        
        if([HTMLDescription_ isKindOfClass:[NSNull class]])
            HTMLDescription_=@"";
        self.HTMLDescription=HTMLDescription_;
        
        if([HTMLDescriptionAr_ isKindOfClass:[NSNull class]])
            HTMLDescriptionAr_=@"";
        self.HTMLDescriptionAr=HTMLDescriptionAr_;
        
        
        
    }
    return self;
}
@end
