//
//  PlayingSetGameViewController.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 15/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "PlayingSetGameViewController.h"
#import "SetCardDeck.h"

@implementation PlayingSetGameViewController

-(Deck *) createDeck{
    return [[SetCardDeck alloc] init];
}


@end
