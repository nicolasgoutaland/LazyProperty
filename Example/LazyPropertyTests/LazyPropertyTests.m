//
//  LazyPropertyTests.m
//  LazyPropertyTests
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "LazyProperty.h"

@interface LazyPropertyTests : XCTestCase
// Data
@property (nonatomic, assign) BOOL configureViewControllerTriggered;
@property (nonatomic, assign) NSInteger configureViewControllerTriggeredCount;

// Tested properties
@property (nonatomic, strong) id invalidProperty;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSArray *arrayCustomSelector;
@end

@implementation LazyPropertyTests

- (void)setUp
{
    [super setUp];
    
    // Configure method not called
    _configureViewControllerTriggered = NO;
    _configureViewControllerTriggeredCount = 0;
    self.viewController = nil;
    self.mutableArray = nil;
    self.invalidProperty = nil;
    self.arrayCustomSelector = nil;
}

#pragma mark - Test instanciation
// Unkown class cannot be instantiated
- (void)testInvalidProperty
{
    XCTAssertNil(_invalidProperty, @"_invalidProperty have to be nil");

    // Trigger property
    [self.invalidProperty respondsToSelector:@selector(init)];

    XCTAssertNil(_invalidProperty, @"_invalidProperty should remain nil");
}

// Test a mutable array creation
- (void)testMutableArray
{
    XCTAssertNil(_mutableArray, @"_mutableArray have to be nil");
    
    // Trigger property
    [self.mutableArray addObject:@(YES)];

    XCTAssertNotNil(_mutableArray, @"_mutableArray should be set");
    XCTAssertTrue(_mutableArray.count == 1, @"_mutableArray should contains one object");
    XCTAssertTrue([_mutableArray isKindOfClass:[NSMutableArray class]], @"_mutableArray have to be a NSMutableArray");
    // Unset array
    self.mutableArray = nil;
    XCTAssertNil(_mutableArray, @"_mutableArray have to be nil");
}

// Test reuse of a property
- (void)testReuseMutableArrayReuse
{
    // Trigger property
    [self.mutableArray addObject:@(YES)];

    // Hold mutable array
    NSMutableArray *tmpMutableArray = _mutableArray;
    self.mutableArray = nil;

    // Create a new mutable array
    [self.mutableArray addObject:@(NO)];

    XCTAssertTrue(_mutableArray.count == 1, @"_mutableArray should contains one object");
    XCTAssertTrue(tmpMutableArray.count == 1, @"tmpMutableArray should contains one object");
    XCTAssertTrue(_mutableArray != tmpMutableArray, @"_mutableArray and tmpMutableArray have to be different");
}

// Test trigger
- (void)testViewControllerTriggered
{
    // Trigger property
    XCTAssertNil(_viewController, @"_mutableArray have to be nil");
    XCTAssertFalse(_configureViewControllerTriggered, @"Configure method should not have been called");
    [self.viewController respondsToSelector:@selector(init)];

    XCTAssertNotNil(_viewController, @"_mutableArray have to be set");
    XCTAssertTrue(_configureViewControllerTriggered, @"Configure method should have been called");
    XCTAssertTrue(_configureViewControllerTriggeredCount == 1, @"Configure method should have been called once");
    
    [self.viewController respondsToSelector:@selector(init)];
    XCTAssertTrue(_configureViewControllerTriggeredCount == 1, @"Configure method should not have been called once more");
}

// Test custom selector
- (void)testArrayCustomSelector
{
    // Trigger property
    XCTAssertNil(_arrayCustomSelector, @"_arrayCustomSelector have to be nil");
    [self.arrayCustomSelector respondsToSelector:@selector(init)];

    XCTAssertNotNil(_arrayCustomSelector, @"_arrayCustomSelector have to be set");
    XCTAssertTrue(_arrayCustomSelector.count == 1, @"_arrayCustomSelector should have contains one object, beause using custom selector");
}

#pragma mark - Configuration methods
- (void)configureViewController
{
    _configureViewControllerTriggered = YES;
    _configureViewControllerTriggeredCount++;
}

LAZY_PROPERTY(invalidProperty);
LAZY_PROPERTY(viewController);
LAZY_PROPERTY(mutableArray);
LAZY_PROPERTY_CUSTOM_SELECTOR(arrayCustomSelector, @selector(initWithArray:), @[@(YES)]);
@end
