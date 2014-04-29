//
//  DRHResultCell.m
//  Lab Dice
//
//  Created by Lee Walsh on 25/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import "DRHResultCell.h"

@implementation DRHResultCell

@synthesize value, order;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        value = [NSNumber numberWithInteger:0];
        order = [NSNumber numberWithDouble:arc4random()];
    }
    return self;
}

-(id)initWithValue: (NSInteger) newValue{
    self = [self init];
    if (self) {
        value = [NSNumber numberWithInteger:newValue];
    }
    return self;
}

+(id)resultCellWithValue: (NSInteger) newValue{
    return [[self alloc] initWithValue:newValue];  //autorelease];
}


@end
