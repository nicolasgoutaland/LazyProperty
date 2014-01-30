//
//  LazyProperty.h
//  LazyProperty
//
//  Created by Nicolas Goutaland on 16/04/11.
//  Copyright 2011 Nicolas Goutaland. All rights reserved.
//

/* Macro used to generate a lazy instanciation property. Property have to be a suclass of NSObject. 
 * "constructor" selector will be used instead of "init" one. If nil, init will be used instead.
 * If a method called "configure" + property (With first letter as uppercase) exists, it will be automatically called
 */
#define PZ_LAZY_PROPERTY_CUSTOM_SELECTOR(property, constructor, object) \
- (id)property { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    if (_ ## property) return _ ## property; \
        _ ## property = [[classFromPropertyName(#property, [self class]) alloc] performSelector:(constructor ? constructor : @selector(init)) withObject:object]; \
\
    NSString *configureMethod = [@"configure" stringByAppendingString:[@#property stringUcFirst]];\
    SEL selector = NSSelectorFromString(configureMethod);\
\
    if ([self respondsToSelector:selector])\
        [self performSelector:selector];\
_Pragma("clang diagnostic pop") \
    return _ ## property;\
}

/* Macro used to generate a lazy instanciation property. Property have to be a suclass of NSObject */
#define LAZY_PROPERTY(property) PZ_LAZY_PROPERTY_CUSTOM_SELECTOR(property, nil, nil)

/* Return the class of a given property name. If not a class or class cannot be found, nil will be returned */
Class classFromPropertyName(const char *cPropertyName, Class aClass);
