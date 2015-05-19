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

@synthesize numBlocks,numGroups, numSubjects, numRepetitions;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        numBlocks = 0;
        numGroups = 1;
        numSubjects = 0;
        numRepetitions = 1;
        
        resultsArray = [NSMutableArray array];
        
        [self addObserver:self forKeyPath:@"numBlocks" options:nil context:nil];
        [self addObserver:self forKeyPath:@"numGroups" options:nil context:nil];
        [self addObserver:self forKeyPath:@"numSubjects" options:nil context:nil];
        [self addObserver:self forKeyPath:@"numRepetitions" options:nil context:nil];
        
    }
    return self;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"numBlocks"];
    [self removeObserver:self forKeyPath:@"numGroups"];
    [self removeObserver:self forKeyPath:@"numSubjects"];
    [self removeObserver:self forKeyPath:@"numRepetitions"];
}

#pragma mark Tracking changes
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self rollDice];
}

#pragma Getters
-(NSMutableArray *)resultsArray{
    return resultsArray;
}


#pragma Rolling
-(IBAction)roll:(id)sender{
    [[resultsView window] makeFirstResponder:nil];
    [self rollDice];
    [resultsView setNeedsDisplay:YES];
}

-(void)rollDice{
    [resultsArray removeAllObjects];
    NSMutableArray *groupArray = nil;
    if (numGroups > 1) {
        groupArray = [NSMutableArray array];
        if (numSubjects % numGroups){
            NSAlert *warningAlert = [NSAlert alertWithMessageText:@"Warning: remaining subjects." defaultButton:@"Hmmm" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The number of subjects is not an integer multiple of the number of groups.  Groups may be unequal"];
            [warningAlert runModal];
        }
        NSInteger subjPerGroup = (NSInteger)ceil((double)numSubjects / (double)numGroups);
        for (NSInteger i=0; i<numGroups; i++) {
            for (NSInteger j=0; j<subjPerGroup; j++) {
                [groupArray addObject:[NSNumber numberWithInteger:i+1]];
            }
        }
    }
    for (NSInteger i=0; i<numSubjects; i++) {
        NSMutableArray *newSubjArray = [NSMutableArray array];
        for (NSInteger k=0; k<numRepetitions; k++) {
            for (NSInteger j=0; j<numBlocks; j++) {
                [newSubjArray addObject:[DRHResultCell resultCellWithValue:j+1]];
                NSSortDescriptor *orderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
                NSArray *sortDescriptors = @[orderDescriptor];
                [newSubjArray sortUsingDescriptors:sortDescriptors];
            }
        }
        if (groupArray)
            [newSubjArray insertObject:[DRHResultCell resultCellWithValue:[[groupArray objectAtIndex:i] integerValue]] atIndex:0];
        [resultsArray addObject:newSubjArray];
    }
}

#pragma Printing
-(IBAction)print:(id)sender{
    NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:resultsView];
    [[printOp printPanel] setOptions:[[printOp printPanel] options] | NSPrintPanelShowsPageSetupAccessory];
    [printOp runOperation];
}

@end
