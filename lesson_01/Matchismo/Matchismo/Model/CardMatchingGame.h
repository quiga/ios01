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

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSInteger cardMode;

- (instancetype)initWithCardCount:(NSUInteger)count 
                        usingDeck:(Deck *)deck 
                     useThreeCard:(BOOL)isThreeCard;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

//- (void)resetGame;

@end
