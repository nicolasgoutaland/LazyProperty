//
//  AppDelegate.m
//  LazyProperty
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Display window
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Configuration methods
// This methods will be autotriggered when window will be instantiated
- (void)configureWindow
{
    // This methods will be called only once, so you can perform initial configuration here
    _window.frame = [[UIScreen mainScreen] bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    // Set root view controller
    _window.rootViewController = self.rootViewController;
}

LAZY_PROPERTY(window);
LAZY_PROPERTY(rootViewController);
@end
