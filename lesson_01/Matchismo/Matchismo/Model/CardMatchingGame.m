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
@property (nonatomic, readwrite) NSInteger count;

//- (void)getRandomCards;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSEN = 1;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck{
    self = [super init];
    
    if(self){
        [self.cards removeAllObjects];
        self.count = count;
        for (int i = 0; i < self.count; i++) {
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
/*
- (void)getRandomCards{
    for (int i = 0; i < self.count; i++) {
        Card *card = [deck drawRandomCard];
        if(card) [self.cards addObject:card];
        else{
            self = nil;
            break;
        }
    }
}
*/
- (void)resetGame{
    [self.cards removeAllObjects];
    
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
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
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.flip = YES;
                        card.flip = YES;
                    }
                    break;
                }
            }
            
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
