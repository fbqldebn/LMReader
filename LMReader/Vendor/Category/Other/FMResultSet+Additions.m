//
//  FMResultSet+Additions.m
//  xinjunshi
//
//  Created by 于君 on 16/4/7.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "FMResultSet+Additions.h"

#import <objc/runtime.h>

@implementation FMResultSet (Additions)

- (id)fmResultReflectModel:(DModel*)model;
{
    NSDictionary *mapping = nil;
    if(!mapping) {
        //实现了列-属性转换协议
        
        for (int i = 0; i < [self columnCount]; i++) {
            //列名
            NSString *columnName = [self columnNameForIndex:i];
            //进行数据库列名到model之间的映射转换，拿到属性名
            NSString *propertyName;
            
            if(mapping) {
                propertyName = mapping[columnName];
                if (propertyName == nil) {
                    //如果映射未定义，则视为相同
                    propertyName = columnName;
                }
            } else {
                propertyName = columnName;
            }
            
            objc_property_t objProperty = class_getProperty([model class], propertyName.UTF8String);
            //如果属性不存在，则不操作
            if (objProperty) {
                if(![self columnIndexIsNull:i]) {
                    NSString *firstType = [[[[NSString stringWithUTF8String:property_getAttributes(objProperty)] componentsSeparatedByString:@","] firstObject] substringFromIndex:1];
                    if([firstType isEqualToString:@"@\"NSData\""]){
                        NSData *value = [self dataForColumn:columnName];
                        
                        [model setValue:value forKey:propertyName];
                        
                    }else if([firstType isEqualToString:@"@\"NSInteger\""]){
                        NSNumber *number = [self objectForColumnName:columnName];
                        [model setValue:@(number.integerValue) forKey:propertyName];
                    }else if([firstType isEqualToString:@"@\"CGFloat\""]){
                        NSNumber *number = [self objectForColumnName:columnName];
                        [model setValue:@(number.floatValue) forKey:propertyName];
                    }
                    else if([firstType isEqualToString:@"@\"NSDate\""]){
                        NSDate *value = [self dateForColumn:columnName];
                        [model setValue:value forKey:propertyName];
                        
                    } else if([firstType isEqualToString:@"@\"NSString\""]){
                        NSString *value = [self stringForColumn:columnName];
                        [model setValue:value forKey:propertyName];
                        
                    }else if([firstType isEqualToString:@"@\"NSArray\""]){
                        NSData *value = [self dataForColumn:columnName];
                        id object = [NSKeyedUnarchiver unarchiveObjectWithData:value];
                        [model setValue:object forKey:propertyName];
                        
                    } else if([firstType isEqualToString:@"@\"NSDictionary\""]){
                        NSData *value = [self dataForColumn:columnName];
                        id object = [NSKeyedUnarchiver unarchiveObjectWithData:value];
                        [model setValue:object forKey:propertyName];
                        
                    } else {
                        if ([self objectForColumnName:columnName]) {
                            [model setValue:[self objectForColumnName:columnName] forKey:propertyName];
                        }else
                        {
                            [model setValue:[NSNull null] forKey:propertyName];
                        }
                        
                    }
                }
            }
            
            NSAssert(![propertyName isEqualToString:@"description"], @"description为自带方法，不能对description进行赋值，请使用其他属性名或请ColumnPropertyMappingDelegate进行映射");
        }
    }
    return model;
}
@end
