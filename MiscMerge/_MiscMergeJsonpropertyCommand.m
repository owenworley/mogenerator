//
//  _MiscMergeJsonpropertyCommand.m
//  mogenerator
//
//  Created by Owen Worley on 13/01/2015.
//
//

#import "_MiscMergeJsonpropertyCommand.h"

@interface _MiscMergeJsonpropertyCommand ()
@property (nonatomic, copy) NSString *currentType;
@end

@implementation _MiscMergeJsonpropertyCommand
- (BOOL)parseFromScanner:(NSScanner *)aScanner template:(MiscMergeTemplate *)template
{
    [self eatKeyWord:@"JSONProperty" fromScanner:aScanner isOptional:NO];
    NSString *typeName = [[self getArgumentStringFromScanner:aScanner toEnd:YES] retain];
    self.currentType = typeName;

    return YES;
}

- (MiscMergeCommandExitType)executeForMerge:(MiscMergeEngine *)aMerger {
    NSString *nsType = [self JSONToPropertyMapping][self.currentType];
    if (!nsType) {
        nsType = @"strong";
    }
    [aMerger appendToOutput:nsType];
    return MiscMergeCommandExitNormal;
}

- (NSDictionary *) JSONToPropertyMapping{
    return @{@"object" : @"strong",
             @"string" : @"copy",
             @"array" : @"copy",
             @"boolean" : @"assign",
             @"integer" : @"assign "};
}
@end
