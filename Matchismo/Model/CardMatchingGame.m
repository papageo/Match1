//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 03/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //array of Card
@property (nonatomic, strong, readwrite) NSString *resultString;
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)mode {
    if (!_mode) {
        _mode = 2;
    }
    return _mode;
}


-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck {
    self = [super init]; //super's designated initializer
    if(self){
        for(int i=0; i<count; i++) {
            Card *card =[deck drawRandomCard];
            if (card){ //adding nil to NSMutableArray would crash the program so we protect
                [self.cards addObject:card];
            }
            else {
                //we return nil if we cannot initialize properly
                self = nil;
                break;
            }
        }
    }
    return self;
}
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                         withMode:(NSUInteger) mode {
    self = [self initWithCardCount:count usingDeck:deck];
    self.mode = mode;
    return self;
    
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    NSMutableArray *cardsToMatch = [[NSMutableArray alloc] init]; //of Cards

    Card *card = [self cardAtIndex:index];
    self.resultString = [NSString stringWithFormat:@"%@", card.contents];

    int lastMatchScore = 0;
    
    //select only unmatched cards
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO; //chosen represents front/back of card
            self.resultString = @"";
        }
        else {
            // add otherselected cards to match
            for (Card *otherCard in self.cards)
                if(otherCard.isChosen && !otherCard.isMatched){
                    [cardsToMatch addObject:(otherCard)];
                }
            
            if ([cardsToMatch count] == self.mode - 1)
            {
                //match current card
                lastMatchScore += [card match:cardsToMatch] * MATCH_BONUS;
                
                //match other cards within the array with each other
                int iteratorIndex = 1;
                for(Card *selectedOtherCard in cardsToMatch)
                {
                    //no need to compare last item
                    if(iteratorIndex == [cardsToMatch count]) {
                        break;
                    }
                    NSArray *subRange = [cardsToMatch objectsAtIndexes:
                                         [NSIndexSet indexSetWithIndexesInRange:
                                          NSMakeRange(iteratorIndex  , [cardsToMatch count]-1)]];
                    
                    lastMatchScore += [selectedOtherCard match:subRange] * MATCH_BONUS;
                    iteratorIndex++;
                }
                if(lastMatchScore)
                {
                    self.score += lastMatchScore;
                    //mark selected card
                    card.matched = YES;
                    //mark the other two selected cards
                    NSString *cardsToMatchContents = @"";
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.matched = YES;
                        cardsToMatchContents = [cardsToMatchContents stringByAppendingFormat:@"%@", otherCard.contents];
                    }
                    self.resultString = [NSString stringWithFormat:@"Matched %@ %@ for score: %d", card.contents, cardsToMatchContents, lastMatchScore * MATCH_BONUS];
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    // if mismatch unchoose the mismatching card. (flip)
                    for(Card *otherCard in cardsToMatch){
                        //Card *tempy = [self.cards objectAtIndex:[self.cards indexOfObject:otherCard]];
                        otherCard.chosen = NO;
                    }
                    self.resultString = [NSString stringWithFormat:@"Mismatch! Penalty of %d", MISMATCH_PENALTY];
                }
            }
            /*
             //match against other cards.
             for (Card *otherCard in self.cards) {
             if(otherCard.isChosen && !otherCard.isMatched){
             int matchscore = [card match:@[otherCard]];
             if(matchscore) {
             self.score += matchscore * MATCH_BONUS;
             otherCard.matched = YES;
             card.matched = YES;
             }
             else {
             self.score -= MISMATCH_PENALTY;
             otherCard.chosen = NO; // if mismatch unchoose the mismatching card. (flip?)
             }
             break; //we can only choose 2 cards for the moment so break the for loop
             }
             }
             */
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    [self cheatSheeDebugHelper];
}

-(void) cheatSheeDebugHelper {
    NSLog(@"***************************************************************");
    for(Card *dummycard in self.cards) {
        NSLog(@"CardButton index %d, Contents: %@", [self.cards indexOfObject:dummycard] , dummycard.contents);
        NSLog(@"isChosen: %s   -    isMatched: %s", dummycard.isChosen? "True" : "False", dummycard.isMatched? "True" : "False");
    }
    NSLog(@"***************************************************************");
}
@end
