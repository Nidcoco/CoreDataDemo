//
//  Course+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by 李俊宇 on 2018/10/15.
//  Copyright © 2018年 李俊宇. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Course"];
}

@dynamic creatdate;
@dynamic name;
@dynamic lentstudent;

@end
