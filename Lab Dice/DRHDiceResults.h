//
//  DRHDiceResults.h
//  Lab Dice
//
//  Created by Lee Walsh on 19/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DRHResultsView;

@interface DRHDiceResults : NSObject {
    IBOutlet DRHResultsView *resultsView;
    
    NSInteger numBlocks;
    NSInteger numGroups;
    NSInteger numSubjects;
    
    NSMutableArray *resultsArray;
}
@property NSInteger numBlocks;
@property NSInteger numGroups;
@property NSInteger numSubjects;
@property NSInteger numRepetitions;

#pragma mark Getters
-(NSMutableArray *)resultsArray;

#pragma mark Rolling
-(IBAction)roll:(id)sender;
-(void)rollDice;

#pragma mark Printing
-(IBAction)print:(id)sender;

@end
