//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init{
    self = [super init];
    if(self){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
