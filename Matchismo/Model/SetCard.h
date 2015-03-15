//
//  SetCard.h
//  Matchismo
//
//  Created by Andreas Papageorgiou on 15/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber *number;     // 1,2, or 3
@property (strong, nonatomic) NSString *symbol;     // diamond, squiggle, oval
@property (strong, nonatomic) NSString *shading;    // solid, striped, or open
@property (strong, nonatomic) NSString *color;      //red, green, or purple


+ (NSArray *) validSymbols;
+ (NSArray *) validShading;
+ (NSArray *) validColor;
+ (NSArray *) validNumber;

@end
