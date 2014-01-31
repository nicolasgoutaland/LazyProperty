####LazyProperty [![Build Status](https://travis-ci.org/nicolasgoutaland/LazyProperty.png?branch=master)](https://travis-ci.org/nicolasgoutaland/LazyProperty)

One line lazy property definition, with auto triggering, custom selectors

ARC only, XCode 4.4 minimum (For auto synthesized properties)

####Description
Dealing with lazy properties can be cumbersome sometimes, copy/pasting same code again and again.
This code can be disturbing when reading source file.
Sometimes, you have to execute some code on property initialisation.

More information on lazy instanciation [on Wikipedia](http://en.wikipedia.org/wiki/Lazy_instantiation)

####Usage
* Declare a __strong nonatomic property__ for an __object type__
  * @property (nonatomic, strong) 
* Add macro at the end of your file with property name
  * LAZY_PROPERTY(propertyName)
  * LAZY_PROPERTY_CUSTOM_SELECTOR(propertyName, @selector(customSelectorName:), @[@"parameter"])
* Optionally declare autotriggered methods. Auto triggered methods are named after property name, with capitalized first letter, prefixed by __configure__
  * - (void)configurePropertyName ...

####Examples

####Advantages
* Type less, do more
* Reduce amount of typed code
* Be focused on logic / business code instead of memory management
* Split configuration code from logic code
* Perform fastidious initialisation in less lines of code
* Reduce memory footprint, by not allocating unused objects

####Consideration
* Be careful, especially with UI Object, because initialisation will be on calling thread
* Generated ivar will remain __nil__ until property is accessed once
* You can directly access to generated __ivar__ (_propertyName), without triggering initialisation
* Generated getters is assumed to be nonatomic (for now)
* Don't add @synthesize on your code
* Don't declare ivar

####Limitations
Only __nonatomic__ __strong__ properties are supported.

####Installation
__Manual__: Copy the __Classes__ folder in your project<br>

`#import <LazyProperty.h>`

####Team
Nicolas Goutaland
