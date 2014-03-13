//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

- (void)matchWithModeTwo:(Card *)card;
- (void)matchWithModeThree:(Card *)card;
- (void)sendMessageLog:(NSString *)msg;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSEN = 1;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        self.score = 0;
        [self.cards removeAllObjects];
        
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) [self.cards addObject:card];
            else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void)matchWithModeTwo:(Card *)card{
    for (Card *otherCard in self.cards)
    {
        if(otherCard != card && otherCard.isChosen && !otherCard.isMatched)
        {
            int matchScore = [card match:@[otherCard]];
            if(matchScore)
            {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                card.matched = YES;
                
                [self sendMessageLog:[NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS]];
            }
            else
            {
                self.score -= MISMATCH_PENALTY;
                otherCard.flip = YES;
                card.flip = YES;
                
                [self sendMessageLog:[NSString stringWithFormat:@"%@ %@  don’t match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY]];
            }
            break;
        }
    }
}

- (void)matchWithModeThree:(Card *)card{
    for (Card *otherCard in self.cards)
    {
        for (Card *card3 in self.cards) {
            if(otherCard != card && card3 != card && otherCard != card3){
                if(otherCard.isChosen && !otherCard.isMatched && card3.isChosen && !card3.isMatched )
                {
                    int matchScore = [card match:@[otherCard, card3]];
                    if(matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        NSLog(@"%d", matchScore);
                        otherCard.matched = YES;
                        card3.matched = YES;
                        card.matched = YES;
                        [self sendMessageLog:[NSString stringWithFormat:@"Matched %@ %@ %@ for %d points.", card.contents, otherCard.contents, card3.contents, matchScore * MATCH_BONUS]];
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.flip = YES;
                        card3.flip = YES;
                        card.flip = YES;
                        [self sendMessageLog:[NSString stringWithFormat:@"%@ %@ %@  don’t match! %d point penalty!", card.contents, otherCard.contents, card3.contents, MISMATCH_PENALTY]];
                    }
                    break;
                }
            }
        }
    }
}

- (void)sendMessageLog:(NSString *)msg{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"messageLog" object: msg];
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        [self sendMessageLog:card.contents];
        if(card.isChosen)        {
            card.chosen = NO;
            [self sendMessageLog:@""];
        }
        else
        {
            for (Card *c in self.cards) {
                if (c.isFliped) {
                    c.flip = NO;
                    c.chosen = NO;
                }
            }
            
            self.score -= COST_TO_CHOOSEN;
            card.chosen = YES;
            
            if(self.cardMode == 2)
                [self matchWithModeTwo:card];
            else
                [self matchWithModeThree:card];
            
            

            
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
