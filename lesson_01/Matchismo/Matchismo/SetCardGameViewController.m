//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by PPKE-IMAC-4 on 2014.03.27..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCardGameViewController.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *setGame;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *messageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void) incomingNotification:(NSNotification *)notification{
    self.messageOutlet.text = [notification object];
/*
    NSArray *s = [[notification object] componentsSeparatedByString: @":"];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    NSString *symbol = @"?";
    
    symbol = [[SetCard validShapeSymbols] objectForKey:[s objectAtIndex: 0] ];
    
    symbol = [symbol stringByPaddingToLength:(NSUInteger)[s objectAtIndex: 3]
                                  withString:symbol
                             startingAtIndex:0];
    
    [attributes setObject:[[SetCard validColorObjects] objectForKey:[s objectAtIndex: 1]] forKey:NSForegroundColorAttributeName];
    
    if ([[s objectAtIndex:2] isEqualToString: @"solid"])
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    
    if ([[s objectAtIndex:2] isEqualToString: @"striped"])
        [attributes addEntriesFromDictionary:@{
                                               NSStrokeWidthAttributeName : @-5,
                                               NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                               NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                               }];
    
    if ([[s objectAtIndex:2] isEqualToString: @"open"])
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    
   // self.messageOutlet.attributedText = [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
 */
    
}

- (CardMatchingGame *)setGame{
    if(!_setGame){
        _setGame=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                usingDeck:[self createDeck]];
        _setGame.cardMode = 3;
    }
    return _setGame;
}

- (IBAction)reDealButtonAction:(UIButton *)sender {
    _setGame=[self.setGame initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.setGame.cardMode = 3;
    [self updateUI];
}

- (IBAction)touchAction:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.setGame chooseCardAtIndex:chosenButtonIndex];

    [self updateUI];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        
        SetCard *setCard = (SetCard *)card;
        
        symbol = [[SetCard validShapeSymbols] objectForKey:setCard.shape];
        
        symbol = [symbol stringByPaddingToLength:setCard.number
                                      withString:symbol
                                 startingAtIndex:0];
        
        [attributes setObject:[[SetCard validColorObjects] objectForKey:setCard.color] forKey:NSForegroundColorAttributeName];
        
        if ([setCard.shading isEqualToString:@"solid"])
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        
        if ([setCard.shading isEqualToString:@"striped"])
        [attributes addEntriesFromDictionary:@{
                                               NSStrokeWidthAttributeName : @-5,
                                               NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                               NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                               }];
        if ([setCard.shading isEqualToString:@"open"])
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    }

    
    return [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:[card isChosen] ? @"selectedCard" : @"setCard"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

@end
