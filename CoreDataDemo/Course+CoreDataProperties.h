//
//  Course+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by 李俊宇 on 2018/10/15.
//  Copyright © 2018年 李俊宇. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *creatdate;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Student *> *lentstudent;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addLentstudentObject:(Student *)value;
- (void)removeLentstudentObject:(Student *)value;
- (void)addLentstudent:(NSSet<Student *> *)values;
- (void)removeLentstudent:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
