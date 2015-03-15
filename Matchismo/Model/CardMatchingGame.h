//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andreas Papageorgiou on 03/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                         withMode:(NSUInteger) mode;


- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSUInteger mode;
@property (nonatomic, strong, readonly) NSString *resultString;
@end
