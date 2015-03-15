//
//  Deck.h
//  Matchismo
//
//  Created by Andreas Papageorgiou on 24/02/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;
@end
