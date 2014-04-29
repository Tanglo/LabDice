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
    IBOutlet NSTextField *numBlocksField;
    IBOutlet NSTextField *numSubjectsField;
    
    NSInteger numBlocks;
    NSInteger numGroups;
    NSInteger numSubjects;
    
    NSMutableArray *resultsArray;
}
@property NSInteger numBlocks;
@property NSInteger numGroups;
@property NSInteger numSubjects;

/*
#pragma mark dataSource methods
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex;
- (void)tableView:(NSTableView *)aTableView setObjectValue:(NSMutableString *) newEntry forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
 */

#pragma Getters
-(NSMutableArray *)resultsArray;

#pragma Rolling
-(IBAction)roll:(id)sender;
-(void)rollDice;

#pragma Printing
-(IBAction)print:(id)sender;

@end
