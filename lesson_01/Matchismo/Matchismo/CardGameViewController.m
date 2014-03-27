//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *messageOutlet;

- (void)incomingNotification:(NSNotification *)notification;

@end

@implementation CardGameViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:@"messageLog" object:nil];
}
 
- (void) incomingNotification:(NSNotification *)notification{
    self.messageOutlet.text = [notification object];
}

- (CardMatchingGame *)game{
    if(!_game){
        _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] 
                                                usingDeck:[self createDeck]];
        _game.cardMode = 2;
    }
    return _game;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)resetAction:(UIButton *)sender {
    _game=[self.game initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.game.cardMode = 2;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI{
    for (UIButton *button in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [button setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card{
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
