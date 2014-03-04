//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtINdex:(NSUInteger)index;
- (void)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
