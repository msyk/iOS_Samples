//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

@property (nonatomic, strong) NSString *name;
- (NSString *)deluxName: (NSString *)prefix;

@end
