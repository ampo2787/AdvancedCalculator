//
//  Expression.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Expression : NSObject

-(BOOL) isEmpty;
-(BOOL) isFull;
-(int) size;
-(void) clear;
-(BOOL) orderIsValid:(int)order;
-(void) addToLast:(NSObject *) element;
-(NSString *) elementAt:(int) order;
-(BOOL) replaceAt:(int) order withElement:(NSString *) element;
-(void) removeLast;

@end

NS_ASSUME_NONNULL_END
