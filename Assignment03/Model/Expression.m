//
//  Expression.m
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "Expression.h"

@interface Expression()
@property (nonatomic) NSMutableArray * elements;
@end

@implementation Expression

-(BOOL) orderIsValid:(int)order{
    return ((order >= 0) && (order < self.size));
}

-(NSMutableArray *) elements {
    if(_elements == nil){
        _elements = [[NSMutableArray alloc]init];
    }
    return _elements;
}

-(BOOL) isEmpty{
    return (self.elements.count == 0);
}

-(BOOL)isFull{
    return FALSE;
}

-(int)size{
    return (int)self.elements.count;
}

-(void)addToLast:(NSObject *)element{
    if(element == nil){
        return;
    }
    [self.elements addObject:element];
}

-(NSString *)elementAt:(int)order{
    if(![self orderIsValid:order]){
        return nil;
    }
    else{
        return [self.elements objectAtIndex:order];
    }
}
- (BOOL)replaceAt:(int)order withElement:(NSString *)element{
    if([self orderIsValid:order]){
        [self.elements replaceObjectAtIndex:order withObject:element];
        return TRUE;
    }
    else{
        return FALSE;
    }
}

- (void)removeLast{
    [self.elements removeLastObject];
}

- (void)clear{
    [self.elements removeAllObjects];
}
@end
