//
//  LookinConnectionResponse.m
//  Lookin
//
//  Copyright © 2019 hughkli. All rights reserved.
//

#import "LookinConnectionResponseAttachment.h"
#import "LookinDefines.h"

@interface LookinConnectionResponseAttachment ()

@end

@implementation LookinConnectionResponseAttachment

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:self.lookinServerVersion forKey:@"lookinServerVersion"];
    [aCoder encodeObject:self.error forKey:@"error"];
    [aCoder encodeObject:@(self.dataTotalCount) forKey:@"dataTotalCount"];
    [aCoder encodeObject:@(self.currentDataCount) forKey:@"currentDataCount"];
    [aCoder encodeBool:self.lookinServerIsExprimental forKey:@"lookinServerIsExprimental"];
}

- (instancetype)init {
    if (self = [super init]) {
        self.lookinServerVersion = LOOKIN_SERVER_VERSION;
        self.dataTotalCount = 0;
        self.lookinServerIsExprimental = LOOKIN_SERVER_IS_EXPERIMENTAL;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.lookinServerVersion = [aDecoder decodeIntForKey:@"lookinServerVersion"];
        self.lookinServerIsExprimental = [aDecoder decodeBoolForKey:@"lookinServerIsExprimental"];
        self.error = [aDecoder decodeObjectForKey:@"error"];
        self.dataTotalCount = [[aDecoder decodeObjectForKey:@"dataTotalCount"] unsignedIntegerValue];
        self.currentDataCount = [[aDecoder decodeObjectForKey:@"currentDataCount"] unsignedIntegerValue];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)attachmentWithError:(NSError *)error {
    LookinConnectionResponseAttachment *attachment = [LookinConnectionResponseAttachment new];
    attachment.error = error;
    return attachment;
}

@end
