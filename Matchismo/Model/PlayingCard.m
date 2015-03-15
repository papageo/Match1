//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 24/02/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;
-(void) setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}
-(NSString *) suit {
    return _suit ? _suit : @"?";
}

/*
-(int)match:(NSArray *)otherCards {
    int score = 0;
    if([otherCards count] == 1) { //only matching 1 card vs another
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank) {
            score = 4;
        } else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    return score;
}
*/
-(int)match:(NSArray *)otherCards {
    int score = 0;
    int rankMatches = 0;
    int suitMatches = 0;
    
    for(PlayingCard *otherCard in otherCards)
    {
        if(otherCard.rank == self.rank){
            rankMatches++;
            score = 4 * rankMatches;
        } else if([otherCard.suit isEqualToString:self.suit]){
            suitMatches++;
            score = 1 * suitMatches;
        }
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}
- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

//class methods
+ (NSArray *) validSuits {
    return @[@"♣", @"♠", @"♦", @"♥"];
    
    //return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}
+ (NSArray *) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+ (NSUInteger) maxRank {
    //here we could use [PlayingCard rankStrings]
    return [[self rankStrings] count] -1;
}

@end
