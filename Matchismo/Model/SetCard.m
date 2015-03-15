//
//  SetCard.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 15/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// Properties
@synthesize symbol = _symbol;
-(void) setSymbol:(NSString *)symbol {
    if([[SetCard validSymbols] containsObject:symbol])
    {
        _symbol = symbol;
    }
}
-(NSString *) symbol {
    return _symbol ? _symbol : @"?";
}

@synthesize shading = _shading;
-(void) setShading:(NSString *)shading {
    if([[SetCard validShading] containsObject:shading])
    {
        _shading = shading;
    }
}
-(NSString *) shading {
    return _shading ? _shading : @"?";
}

@synthesize color = _color;
-(void) setColor:(NSString *)color {
    if([[SetCard validColor] containsObject:color])
    {
        _color = color;
    }
}
-(NSString *) color {
    return _color ? _color : @"?";
}

@synthesize number = _number;
-(void) setNumber:(NSNumber *)number {
    
    if([[SetCard validNumber] containsObject:number])
    {
        _number = number;
    }
}
-(NSNumber *) number {
    return _number ? _number : @-1;
}

//
-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    // only 3 set cards can match
    if([otherCards count] != 2)
    {
        return score;
    }
    else
    {
        if([self allSameOrDifferentNumber:otherCards] &&
        [self allSameOrDifferentSymbol:otherCards] &&
        [self allSameOrDifferentShading:otherCards] &&
        [self allSameOrDifferentColor:otherCards])
            score = 4;
        else
            score = 0;
    }
    return score;
}

-(BOOL)allSameOrDifferentNumber:(NSArray *) otherSetcards{
    BOOL ret = NO;
    if([otherSetcards count]==2)
    {
        if([self.number isEqualToNumber: ((SetCard *)otherSetcards[0]).number] &&
           [self.number isEqualToNumber: ((SetCard *)otherSetcards[1]).number] &&
           [((SetCard *)otherSetcards[0]).number isEqualToNumber: ((SetCard *)otherSetcards[1]).number])

        {
            ret = YES;
        }
        else if(![self.number isEqualToNumber: ((SetCard *)otherSetcards[0]).number] &&
                ![self.number isEqualToNumber: ((SetCard *)otherSetcards[1]).number] &&
                ![((SetCard *)otherSetcards[0]).number isEqualToNumber: ((SetCard *)otherSetcards[1]).number]){
            ret = YES;
        }
    }
    return ret;
}
-(BOOL)allSameOrDifferentSymbol:(NSArray *) otherSetcards{
    BOOL ret = NO;
    if([otherSetcards count]==2)
    {
        if([self.symbol isEqualToString: ((SetCard *)otherSetcards[0]).symbol]&&
           [self.symbol isEqualToString: ((SetCard *)otherSetcards[1]).symbol]&&
           [((SetCard *)otherSetcards[0]).symbol isEqualToString: ((SetCard *)otherSetcards[1]).symbol])

        {
            ret = YES;
        }
        else if(![self.symbol isEqualToString: ((SetCard *)otherSetcards[0]).symbol] &&
                ![self.symbol isEqualToString: ((SetCard *)otherSetcards[1]).symbol ]&&
                ![((SetCard *)otherSetcards[0]).symbol isEqualToString: ((SetCard *)otherSetcards[1]).symbol]) {
            ret = YES;
        }
    }
    return ret;
}
-(BOOL)allSameOrDifferentShading:(NSArray *) otherSetcards{
    BOOL ret = NO;
    if([otherSetcards count]==2)
    {
        if([self.shading isEqualToString: ((SetCard *)otherSetcards[0]).shading] &&
           [self.shading isEqualToString: ((SetCard *)otherSetcards[1]).shading] &&
           [((SetCard *)otherSetcards[0]).shading isEqualToString: ((SetCard *)otherSetcards[1]).shading])
        {
            ret = YES;
        }
        else if(![self.shading isEqualToString: ((SetCard *)otherSetcards[0]).shading] &&
                ![self.shading isEqualToString: ((SetCard *)otherSetcards[1]).shading] &&
                ![((SetCard *)otherSetcards[0]).shading isEqualToString: ((SetCard *)otherSetcards[1]).shading]) {
            ret = YES;
        }
    }
    return ret;
}
-(BOOL)allSameOrDifferentColor:(NSArray *) otherSetcards{
    BOOL ret = NO;
    if([otherSetcards count]==2)
    {
        if([self.color isEqualToString: ((SetCard *)otherSetcards[0]).color] &&
           [self.color isEqualToString: ((SetCard *)otherSetcards[1]).color] &&
           [((SetCard *)otherSetcards[0]).color isEqualToString: ((SetCard *)otherSetcards[1]).color])
        {
            ret = YES;
        }
        else if(![self.color isEqualToString: ((SetCard *)otherSetcards[0]).color] &&
                ![self.color isEqualToString: ((SetCard *)otherSetcards[1]).color] &&
                ![((SetCard *)otherSetcards[0]).color isEqualToString: ((SetCard *)otherSetcards[1]).color]) {
            ret = YES;
        }
    }
    return ret;
}

// Class Methods
+ (NSArray *) validSymbols {
     return @[@"▲", @"●", @"■" ];
}
+ (NSArray *) validShading {
    return @[@"solid", @"striped", @"open"];
}
+ (NSArray *) validColor {
    return @[@"red", @"green", @"purple"];
}
+ (NSArray *) validNumber {
    return @[@1, @2, @3];
}


@end
