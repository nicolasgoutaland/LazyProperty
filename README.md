#LazyProperty [![Build Status](https://travis-ci.org/nicolasgoutaland/LazyProperty.png?branch=master)](https://travis-ci.org/nicolasgoutaland/LazyProperty)

One line lazy property definition, with auto triggering, custom selectors

ARC only, XCode 4.4 minimum (For auto synthesized properties)

##Description
Dealing with lazy properties can be cumbersome sometimes, copy/pasting same code again and again.<br/>
This code can be disturbing when reading source file.<br/>
Sometimes, you have to execute some code on property initialisation.

More information on lazy instanciation [on Wikipedia](http://en.wikipedia.org/wiki/Lazy_instantiation)

##Usage
* Declare a __strong nonatomic property__ for an __object type__
  * @property (nonatomic, strong) 
* Add one of these macros at the end of your file with property name, before end of class implementation __@end__
  * LAZY_PROPERTY(propertyName)
  * LAZY_PROPERTY_CUSTOM_SELECTOR(propertyName, @selector(customSelectorName:), @[@"parameter"])
* Optionally declare autotriggered methods. Auto triggered methods are named after property name, camelcase style, prefixed by __configure__
  * - (void)configurePropertyName ...

##Example
_RootViewController.m_

    @interface DemoViewController ()
    ...

    // Lazy properties
    @property (nonatomic, strong) SimpleViewController *simpleViewController; // Will be used modally
    @property (nonatomic, strong) DetailViewController *detailViewController; // Will be pushed from tableview
    @end

    @implementation DemoViewController
    ...

    #pragma mark - UITableViewDelegate methods
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        // No need to worry about detail view controller instantiation. It will be created at first call
        // This allows you to keep your code super clear
        [self.navigationController pushViewController:self.detailViewController
                                             animated:YES];
    }

    #pragma mark - UIActions
    - (IBAction)showModal:(id)sender
    {
        // No need to worry about view controller instantiation here too. It will be created at first call
        // First configuration was moved to a dedicated method, auto triggered on object creation
        [self presentViewController:self.simpleViewController
                           animated:YES
                         completion:nil];
    }

    #pragma mark - Configuration methods
    // This method will be autotriggered when simpleViewController will be instantiated
    - (void)configureSimpleViewController
    {
        // This methods will be called only once, so you can perform initial configuration here
        _simpleViewController.backgroundColor = [UIColor redcolor];
    }

    // Magic happens here. Write macros at the end of the file, to keep it clean. Use property name
    LAZY_PROPERTY(simpleViewController);
    LAZY_PROPERTY(detailViewController);
    @end


You will find more examples in provided sample, such as using custom selector.

##Use case
* View controller to be presented modally
* View controller to be pushed after selecting a row in a table view, to display a detail
* UserInfo NSMutableDictionary associated to a class
* MoviePlayer used in a detail view controller, needing customisation when initialised
* To infinity and beyond

Let me know if you have some other use cases

##Advantages
* Type less, do more
* Reduce amount of typed code
* Be focused on logic / business code instead of memory management
* Split configuration code from workflow
* Perform fastidious initialisation in less lines of code
* Reduce memory footprint, by not allocating unused objects

##Consideration
* Be careful, especially with UI Object, because initialisation will be on calling thread
* Generated ivar will remain __nil__ until property is accessed once
* You can directly access to generated __ivar__ (_propertyName), without triggering initialisation
* __init__ constructor is used by default
* Don't add @synthesize on your code
* Don't declare ivar

##Limitations
Only __strong__ properties are supported. Lazy __weak__ properties may instantiate a new instance at each call.
__atomic__ properties are not supported. When overriding __atomic__ properties, you have to override getter and setter. 
Using LazyProperty on an atomic property will result in compiler a warning message.

##Installation
__Cocoapods__: `pod 'LazyProperty'`<br>
__Manual__: Copy the __Classes__ folder in your project<br>

Import header in your project. .pch is a good place ;)
    
    #import "LazyProperty.h"

##Team
Nicolas Goutaland
