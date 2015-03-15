//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 12/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

-(Deck *) createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end
