//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andreas Papageorgiou on 24/02/15.
//  Copyright (c) 2015 SocioLabs. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *lastMatchResultsLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic, strong) NSMutableArray *gameResults;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck {
    return nil;
}

- (NSMutableArray *)gameResults {
    if (!_gameResults) {
        _gameResults = [[NSMutableArray alloc] init];
    }
    return _gameResults;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [self gameModeSegmentedControl].enabled = NO;
    int chosenButtonindex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonindex];
    [self updateUI];
}

- (IBAction)touchShuffleButton:(id)sender {
    self.game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]
                                                  withMode:[self getCardMatchingGameMode]];
    //self.game = nil;
    [self.gameResults removeAllObjects];
    self.historySlider.enabled = NO;
    [self gameModeSegmentedControl].enabled = YES;
    [self updateUI];
}

- (IBAction)touchSegmentedControl:(id)sender {
    self.game.mode = [self getCardMatchingGameMode];
}

- (void)updateUI {
    for(UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    self.lastMatchResultsLabel.text = self.game.resultString;
    
    //add to internal data structure to keep track of history
    [self updateHistorySlider];
}

- (IBAction)slideHistorySlider {
    int element = (int) round(self.historySlider.value);
    if (element < 0) element = 0;//????????
    
    // set text to display history
    NSString *history = [self.gameResults objectAtIndex:element];
    self.lastMatchResultsLabel.text = history;
    
    // change text color when we're looking at the past
    /*
    if (element == self.historySlider.maximumValue) {
        self.gameHistory.textColor = [UIColor blackColor];
    } else {
        self.gameHistory.textColor = [UIColor redColor];
    }*/

}

-(void) updateHistorySlider{
    
    if (![self.game.resultString isEqualToString:@""] && self.game.resultString) {
        [self.gameResults addObject:self.game.resultString];
    }
    if ([self.gameResults count]) {
        [self setSliderRange];
    }
}

- (void)setSliderRange
{
    NSUInteger maxValue = [self.gameResults count] - 1;
    self.historySlider.maximumValue = maxValue;
    self.historySlider.value = self.historySlider.maximumValue;
    self.historySlider.enabled = (maxValue > 0) ? YES : NO;
}

- (void)setResults {
    NSUInteger sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:YES];
    if ([self.gameResults count]) {
        self.lastMatchResultsLabel.alpha = self.historySlider.value = [self.gameResults count] + 1 ? 0.5 : 1;
        self.lastMatchResultsLabel.text = [self.gameResults objectAtIndex:sliderValue];
    }
}

- (NSString *)titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfrontWhite" : @"cardback"];
}

- (NSUInteger)getCardMatchingGameMode {
    switch([self.gameModeSegmentedControl selectedSegmentIndex])
    {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        default:
            return 2;
    }
}

@end
