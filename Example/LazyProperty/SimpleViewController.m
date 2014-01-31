//
//  SimpleViewController.m
//  LazyProperty
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel *countLabel;

// Data
@property (nonatomic, assign) NSInteger displayCount;
@property (nonatomic, strong) NSMutableArray *displayDates;
@end

@implementation SimpleViewController
#pragma mark - Constructor
- (id)init
{
    if (self = [super initWithNibName:@"SimpleViewController" bundle:nil])
    {
        _displayCount = 0;
    }
    
    return self;
}

- (id)initWithInitialCount:(NSNumber *)initialCount
{
    if (self = [super initWithNibName:@"SimpleViewController" bundle:nil])
    {
        _displayCount = [initialCount intValue];
    }

    return self;
}

#pragma mark - View management
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Log display dates. If not using property, variable won't be instantiated, so nil will be displayed
    NSLog(@"%@", _displayDates);

    // Update display count
    _displayCount++;

    // Refresh label
    _countLabel.text = [NSString stringWithFormat:@"%d", _displayCount];

    // Hold display date
    [self.displayDates addObject:[NSDate date]];

    // Log display dates. Property was called before, so array is instantiated now
    NSLog(@"%@", _displayDates);
}

#pragma mark - UI Actions
- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

LAZY_PROPERTY(displayDates);
@end
