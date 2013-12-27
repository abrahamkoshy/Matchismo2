//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Abraham Koshy on 12/24/13.
//  Copyright (c) 2013 Ubikwity. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@end

@implementation CardGameViewController

-(CardMatchingGame*)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];

}
- (IBAction)touchDealButton:(UIButton *)sender {
    [self.game deal];
    [self updateUI];
}

-(void) updateUI {
    for (UIButton* cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

-(Deck*)createDeck {
    return [[PlayingCardDeck alloc]init];
}

-(NSString*)titleForCard:(Card*) card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage*)backgroundImageForCard:(Card*) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
