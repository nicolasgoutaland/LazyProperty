//
//  DummyClass.h
//  LazyProperty
//
//  Created by Nicolas Goutaland on 04/02/2014.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
// Dummy object notifying its deallocation to Tests

@interface DummyClass : NSObject {
}

/* Return alive dummy objects count */
+ (NSInteger)aliveDummyObjectsCount;

@end
