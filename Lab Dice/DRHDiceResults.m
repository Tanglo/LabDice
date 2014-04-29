//
//  DRHDiceResults.m
//  Lab Dice
//
//  Created by Lee Walsh on 19/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import "DRHDiceResults.h"
#import "DRHResultCell.h"
#import "DRHResultsView.h"

@implementation DRHDiceResults

@synthesize numBlocks,numGroups, numSubjects;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        numBlocks = 0;
        numGroups = 0;
        numSubjects = 0;
        
        resultsArray = [NSMutableArray array];
    }
    return self;
}

/*
#pragma mark dataSource methods

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex {
    if ([[tableColumn identifier] isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%ld.",rowIndex+1];
    } else {
        return [[[resultsArray objectAtIndex:rowIndex] objectAtIndex:[[results tableColumns] indexOfObject:tableColumn]-1] value];
    }
    return [NSNumber numberWithInteger:0];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(NSMutableString *) newEntry forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex
{

}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return numSubjects;
}
 */

#pragma Getters
-(NSMutableArray *)resultsArray{
    return resultsArray;
}


#pragma Rolling
-(IBAction)roll:(id)sender{
    [[resultsView window] makeFirstResponder:nil];
    //NSLog(@"Number of columns: %ld",[[results tableColumns] count]);
/*    NSArray *tableCols = [results tableColumns];
    if ([tableCols count] < numBlocks+1) {
        for (NSInteger i=[tableCols count]; i<numBlocks+1; i++) {
            NSString *colIdent = [NSString stringWithFormat:@"%ld",i];
            NSString *colHeader = [NSString stringWithFormat:@"Block %ld",i];
            NSTableColumn *newColumn = [[NSTableColumn alloc] initWithIdentifier:colIdent];
            [[newColumn headerCell] setStringValue:colHeader];
            [results addTableColumn:newColumn];
        }
    } else if ([tableCols count] > numBlocks+1) {
        for (NSInteger i=[tableCols count]-1; i>numBlocks; i--) {
            //NSString *colIdent = [NSString stringWithFormat:@"%ld",i];
            [results removeTableColumn:[tableCols objectAtIndex:i]];
        }
    }*/
    [self rollDice];
    [resultsView setNeedsDisplay:YES];
}

-(void)rollDice{
    [resultsArray removeAllObjects];
    for (NSInteger i=0; i<numSubjects; i++) {
        NSMutableArray *newSubjArray = [NSMutableArray array];
        for (NSInteger j=0; j<numBlocks; j++) {
            [newSubjArray addObject:[DRHResultCell resultCellWithValue:j+1]];
            NSSortDescriptor *orderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
            NSArray *sortDescriptors = @[orderDescriptor];
            [newSubjArray sortUsingDescriptors:sortDescriptors];
        }
        [resultsArray addObject:newSubjArray];
    }
}

#pragma Printing
-(IBAction)print:(id)sender{
//    [self roll:sender];       //seems to skip call to isFlipped
//    [[resultsView window] makeFirstResponder:nil];
    [[NSPrintOperation printOperationWithView:resultsView] runOperation];
}

@end
