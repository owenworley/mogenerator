//
//  _MiscMergeJSONTypeCommand.m
//  mogenerator
//
//  Created by Owen Worley on 13/01/2015.
//
//

#import "_MiscMergeJsontypeCommand.h"

@interface _MiscMergeJsontypeCommand ()
@property (nonatomic, copy) NSString *currentType;
@end

@implementation _MiscMergeJsontypeCommand

- (BOOL)parseFromScanner:(NSScanner *)aScanner template:(MiscMergeTemplate *)template
{
    [self eatKeyWord:@"JSONType" fromScanner:aScanner isOptional:NO];
    NSString *typeName = [[self getArgumentStringFromScanner:aScanner toEnd:YES] retain];
    self.currentType = typeName;

    return YES;
}

- (MiscMergeCommandExitType)executeForMerge:(MiscMergeEngine *)aMerger {
    NSString *nsType = [self JSONToNSMapping][self.currentType];
    if (!nsType) {
        nsType = @"id ";
    }
    [aMerger appendToOutput:nsType];
    return MiscMergeCommandExitNormal;
}

- (NSDictionary *) JSONToNSMapping{
    return @{@"object" : @"NSObject *",
             @"string" : @"NSString *",
             @"array" : @"NSArray *",
             @"boolean" : @"BOOL ",
             @"integer" : @"NSInteger ",
};
}

@end



