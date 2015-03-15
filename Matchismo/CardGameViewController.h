//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Andreas Papageorgiou on 24/02/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//
// Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected methods for subclasses
- (Deck *) createDeck; // abstract
@end
