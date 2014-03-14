//
//  Card.h
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic, getter = isFliped) BOOL flip;

@property (nonatomic) NSUInteger numberOfMatchingCards;

- (int)match:(NSArray *)otherCards;


@end
