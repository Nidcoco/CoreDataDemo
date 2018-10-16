//
//  Student+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by 李俊宇 on 2018/10/15.
//  Copyright © 2018年 李俊宇. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nullable, nonatomic, retain) NSSet<Course *> *lentcourse;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addLentcourseObject:(Course *)value;
- (void)removeLentcourseObject:(Course *)value;
- (void)addLentcourse:(NSSet<Course *> *)values;
- (void)removeLentcourse:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
