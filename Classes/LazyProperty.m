//
//  LazyProperty.m
//  LazyProperty
//
//  Created by Nicolas Goutaland on 16/04/11.
//  Copyright 2011 Nicolas Goutaland. All rights reserved.
#ifndef __LazyProperty__M__
#define __LazyProperty__M__

#import "LazyProperty.h"
#import <objc/runtime.h>

#pragma mark Private
// SRC : https://github.com/AlanQuatermain/aqtoolkit
const char * property_getTypeString(objc_property_t property);

/* Return the type type of a given property */
const char * property_getTypeString(objc_property_t property)
{
	const char * attrs = property_getAttributes( property );
	if ( attrs == NULL )
		return ( NULL );
	
	static char buffer[256];
	const char * e = strchr( attrs, ',' );
	if ( e == NULL )
		return ( NULL );
	
	int len = (int)(e - attrs);
	if (len >= sizeof(buffer))
		return NULL;

	memcpy( buffer, attrs, len );
	buffer[len] = '\0';
	
	return ( buffer );
}

#pragma mark Lazy instanciation utils
/* Return the class of a given property name. If not a class or class cannot be found, nil will be returned */
Class classFromPropertyName(const char *cPropertyName, Class aClass)
{
	// Get back property description
	objc_property_t property = class_getProperty(aClass, cPropertyName);
	
	if (!property)
		return nil;
	
	// Extract typr string
	const char *cTypeString = property_getTypeString(property);
	
	if (!cTypeString)
		return nil;
	
	// Build NSString from type string
	NSString *typeStr = [NSString stringWithCString:cTypeString
										   encoding:NSUTF8StringEncoding];

	// Check that property type is a class
	if ([typeStr rangeOfString:@"T@\""].location == NSNotFound)
		return nil;

	// Extract class Name. Type string is T@"..."
	NSString *className = [typeStr substringWithRange:NSMakeRange(@"T@\"".length, typeStr.length - @"T@\"\"".length)];

	// Return built class
	return NSClassFromString(className);
}
#endif
