//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Abraham Koshy on 12/25/13.
//  Copyright (c) 2013 Ubikwity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card*)cardAtIndex:(NSUInteger)index;
-(BOOL)deal;

@property (nonatomic, readonly) NSInteger score;
@end
