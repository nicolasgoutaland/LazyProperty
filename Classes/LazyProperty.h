//
//  LazyProperty.h
//  LazyProperty
//
//  Created by Nicolas Goutaland on 16/04/11.
//  Copyright 2011 Nicolas Goutaland. All rights reserved.
//
#ifndef __LazyProperty__H__
#define __LazyProperty__H__
/* Macro used to generate a lazy instanciation property. Property have to be a suclass of NSObject. 
 * "constructor" selector will be used instead of "init" one. If nil, init will be used instead.
 * 
 * Method triggering
 * Two kind of methods can be triggered:
 * - Method called "configure" + property
 * - Method called "configure" + property + ":"
 *   - Parameter will specified "object" when using LAZY_PROPERTY_CUSTOM_SELECTOR() macro
 * /!\ Property name should have first as uppercase
 */
#define LAZY_PROPERTY_CUSTOM_SELECTOR(property, constructor, object) \
- (id)property { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    if (_ ## property == nil) { \
        _ ## property = [[classFromPropertyName(#property, [self class]) alloc] performSelector:(constructor ? constructor : @selector(init)) withObject:object]; \
\
        NSString *propertyName = @#property;\
        NSString *configureMethod = [@"configure" stringByAppendingString:[NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]]];\
        SEL selector = NSSelectorFromString(configureMethod);\
\
        if ([self respondsToSelector:selector]) {\
            [self performSelector:selector];\
        } else {\
            configureMethod = [configureMethod stringByAppendingString:@":"];\
            selector = NSSelectorFromString(configureMethod);\
\
            if ([self respondsToSelector:selector])\
                [self performSelector:selector withObject:object];\
        }\
	} \
_Pragma("clang diagnostic pop") \
    return _ ## property;\
}

/* Macro used to generate a lazy instanciation property. Property have to be a suclass of NSObject */
#define LAZY_PROPERTY(property) LAZY_PROPERTY_CUSTOM_SELECTOR(property, nil, nil)

/* Return the class of a given property name. If not a class or class cannot be found, nil will be returned */
Class classFromPropertyName(const char *cPropertyName, Class aClass);
#endif
