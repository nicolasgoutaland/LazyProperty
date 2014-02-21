//
//  RootViewController.m
//  LazyProperty
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "RootViewController.h"
#import "SimpleViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) SimpleViewController *simpleViewController;
@property (nonatomic, strong) SimpleViewController *simpleViewControllerCustomSelector;
@property (nonatomic, strong) SimpleViewController *simpleViewControllerEmbedded;
@property (nonatomic, strong) UINavigationController *embeddedNavigationController;
@end

@implementation RootViewController
#pragma mark - UI Actions
- (IBAction)simpleLazy:(id)sender
{
    [self presentViewController:self.simpleViewController
                       animated:YES
                     completion:nil];
}

- (IBAction)simpleCustomLazy:(id)sender
{
    [self presentViewController:self.simpleViewControllerCustomSelector
                       animated:YES
                     completion:nil];
}

- (IBAction)cascadeLazy:(id)sender
{
    [self presentViewController:self.embeddedNavigationController
                       animated:YES
                     completion:nil];
}

#pragma mark - Configuration methods
// This methods will be autotriggered when simpleViewController will be instantiated
- (void)configureSimpleViewController
{
    // This methods will be called only once, so you can perform initial configuration here
    _simpleViewController.view.backgroundColor = [UIColor greenColor];
}

// This methods will be autotriggered when simpleViewControllerCustomSelector will be instantiated
- (void)configureSimpleViewControllerCustomSelector
{
    // This methods will be called only once, so you can perform initial configuration here
    _simpleViewControllerCustomSelector.view.backgroundColor = [UIColor redColor];
}

// This methods will be autotriggered when embeddedNavigationController will be instantiated
// Parameter will be object set as third "object" in LAZY_PROPERTY_CUSTOM_SELECTOR macro (self.simpleViewControllerEmbedded in this case)
- (void)configureEmbeddedNavigationController:(SimpleViewController *)aSimpleViewController
{
    // This methods will be called only once, so you can perform initial configuration here
    // You can also  define a - (void)configureSimpleViewControllerEmbedded method in order to configure simpleViewController, but using
    // it as parameter allows you to write less code
    aSimpleViewController.view.backgroundColor = [UIColor yellowColor];
}

LAZY_PROPERTY(simpleViewController);
LAZY_PROPERTY(simpleViewControllerEmbedded);
LAZY_PROPERTY_CUSTOM_SELECTOR(simpleViewControllerCustomSelector, @selector(initWithInitialCount:), @(999));
LAZY_PROPERTY_CUSTOM_SELECTOR(embeddedNavigationController, @selector(initWithRootViewController:), self.simpleViewControllerEmbedded);
@end
