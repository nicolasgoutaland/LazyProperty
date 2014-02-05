//
//  DummyClass.m
//  LazyProperty
//
//  Created by Nicolas Goutaland on 04/02/2014.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//

#import "DummyClass.h"

@implementation DummyClass
#pragma mark - Static methods
static NSInteger aliveDummyObjectCount = 0;
+ (NSInteger)aliveDummyObjectsCount
{
    return aliveDummyObjectCount;
}

#pragma mark - Constructor
- (id)init
{
	if (self = [super init])
	{
        aliveDummyObjectCount++;
		NSLog(@"Dummy object created");
	}
	
	return self;
}

#pragma mark - Memory
- (void)dealloc
{
    aliveDummyObjectCount--;
    NSLog(@"Dummy object destroyed");
}

@end