//
//  SimpleViewController.h
//  LazyProperty
//
//  Created by Nicolas Goutaland on 30/01/2014.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleViewController : UIViewController
/* Custom selector allowing to set an initial count */
- (id)initWithInitialCount:(NSNumber *)initialCount;
@end
