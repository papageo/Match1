//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 15/03/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if(self){
        for(NSString *symbol in [SetCard validSymbols]) {
            for(NSString *shading in [SetCard validShading]) {
                for( NSString *color in [SetCard validColor]) {
                    for(NSNumber *number in [SetCard validNumber]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
