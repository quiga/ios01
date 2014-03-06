//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchOutlet;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
    if(!_game){
        _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] 
                                                usingDeck:[self createDeck] useThreeCard:NO];
    }
    return _game;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)switchAction:(UISegmentedControl *)sender {
    self.game.cardMode = [self.switchOutlet selectedSegmentIndex]==0 ? 2 : 3;
    [self updateUI];
}

-(void)reInitGame:(BOOL)useMode{
    _game=[self.game initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] useThreeCard:useMode];
}

- (IBAction)resetAction:(UIButton *)sender {
    [self.switchOutlet setEnabled:YES];
    [self reInitGame:(BOOL)[self.switchOutlet selectedSegmentIndex]];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [self.switchOutlet setEnabled:NO];
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI{
    for (UIButton *button in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end