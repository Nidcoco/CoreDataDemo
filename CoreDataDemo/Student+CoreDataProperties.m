//
//  Student+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by 李俊宇 on 2018/10/15.
//  Copyright © 2018年 李俊宇. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic birthday;
@dynamic lentcourse;

@end
