//
//  LazyPropertyTests.m
//  LazyPropertyTests
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LazyPropertyTests : XCTestCase

@end

@implementation LazyPropertyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#warning TODO : Test with _ivar == nil
#warning TODO : Test with self.ivar != nil
#warning TODO : Test with self.ivar == _previousivar
#warning TODO : Test with [self.ivar class] == class
#warning TODO : Test with self.ivar id not instantiated
#warning TODO : Test with self.ivar and custom selector triggered
#warning TODO : Test with self.ivar = nil and _ivar == nil
#warning TODO : Test with self.ivar and _ivar != nil && != _previousivar


- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
