//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Abraham Koshy on 12/25/13.
//  Copyright (c) 2013 Ubikwity. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (strong, nonatomic) Deck* deck;
@property (nonatomic) NSUInteger count;
@end

@implementation CardMatchingGame

-(NSMutableArray*) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck {
    self = [super init];
    if (self) {
        self.deck = deck;
        self.count = count;
        if ([self deal] == NO) {
            self = Nil;
        }
    }
    NSLog(@"card count = %d", [self.cards count]);
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card* card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against other chosen cards
            for (Card* otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(Card*)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(BOOL) deal {
    BOOL dealt = YES;
    [self.cards removeAllObjects];
    self.score = 0;
    for (int i = 0; i < self.count; i++) {
        Card* card = [self.deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        } else {
            dealt = NO;
        }
    }
    return dealt;
}

@end
