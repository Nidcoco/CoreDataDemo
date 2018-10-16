//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 李俊宇 on 2018/10/15.
//  Copyright © 2018年 李俊宇. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"
#import "Course+CoreDataClass.h"




@interface ViewController ()
{
    //用来管理上下文的对象
    NSManagedObjectContext * _context;
}


- (IBAction)insertData;

- (IBAction)queryData;

- (IBAction)deleteData;

- (IBAction)upDateData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatsqlite];
}


    //创建数据库
    - (void)creatsqlite
    {
    //1、创建模型对象
    //获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    //2、创建持久化存储助理：数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"sqlite.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3、创建上下文 保存信息 操作数据库
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context = context;
    
}




    //增
    - (IBAction)insertData {
    
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    
    //  2 根据表Course中的键值，给NSManagedObject对象赋值
    
    Course *course1 = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Course"
                       inManagedObjectContext:_context];
    course1.name = @"iOS";
    course1.creatdate = [NSDate date];
    
    Course *course2 = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Course"
                       inManagedObjectContext:_context];
    course2.name = @"Android";
    course2.creatdate = [NSDate date];
    
    //  3 同上操作
    
    Student *student1 = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Student"
                         inManagedObjectContext:_context];
    student1.name = @"张三";
    student1.birthday = [NSDate date];
    //student1.lentcourse = course1;
    [student1 addLentcourseObject:course1];
    
    Student *student2 = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Student"
                         inManagedObjectContext:_context];
    student2.name = @"李四";
    student2.birthday = [NSDate date];
    [student2 addLentcourseObject:course2];
    
    
    //   4.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"数据插入到数据库成功");
    }else{

        NSLog(@"数据插入到数据库失败, %@",error);
    }


    
    }

//查
- (IBAction)queryData {
    //1:FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //2:设置过滤条件  这里我们查询选了iOS课的学生信息
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"ANY lentcourse.name = %@",@"iOS"];
    request.predicate = pre;
    //3:设置排序
    //    NSSortDescriptor *height = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    //    request.sortDescriptors = @[height];
    
    //4:执行请求
    NSArray *message = [_context executeFetchRequest:request error:nil];
    //遍历查询结果
    for (Student *student in message) {
        NSLog(@"名字：%@,生日：%@",student.name,student.birthday);
    }
    
    
    
}

//删
- (IBAction)deleteData {
    //1:先查询到需要删除的数据(比如这里以删除员工张三的数据为例)
    //1.1:FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //1.2:设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"张三"];
    request.predicate = pre;
    //1.3执行查询请求
    NSArray *message = [_context executeFetchRequest:request error:nil];
    //2:执行删除操作
    for (Student *student in message) {
        [_context deleteObject:student];
    }
    
    //3:保存
    [_context save:nil];
}
//改
- (IBAction)upDateData {
    //1:先查询出需要更新的数据
    //1.1:FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //1.2:设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"李四"];
    request.predicate = pre;
    //1.3执行查询请求
    NSArray *message = [_context executeFetchRequest:request error:nil];
    
    //2:更新数据
    for (Student *student  in message) {
        student.name = @"王五";
    }
    //3:保存
    [_context save:nil];
    
}

/* 谓词的条件指令
 1.比较运算符 > 、< 、== 、>= 、<= 、!=
 例：@"number >= 99"
 
 2.范围运算符：IN 、BETWEEN
 例：@"number BETWEEN {1,5}"
 @"address IN {'shanghai','nanjing'}"
 
 3.字符串本身:SELF
 例：@"SELF == 'APPLE'"
 
 4.字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
 例：  @"name CONTAIN[cd] 'ang'"  //包含某个字符串
 @"name BEGINSWITH[c] 'sh'"    //以某个字符串开头
 @"name ENDSWITH[d] 'ang'"    //以某个字符串结束
 
 5.通配符：LIKE
 例：@"name LIKE[cd] '*er*'"   // *代表通配符,Like也接受[cd].
 @"name LIKE[cd] '???er*'"
 
 *注*: 星号 "*" : 代表0个或多个字符
 问号 "?" : 代表一个字符
 
 6.正则表达式：MATCHES
 例：NSString *regex = @"^A.+e$"; //以A开头，e结尾
 @"name MATCHES %@",regex
 
 注:[c]*不区分大小写 , [d]不区分发音符号即没有重音符号, [cd]既不区分大小写，也不区分发音符号。
 
 7. 合计操作
 ANY，SOME：指定下列表达式中的任意元素。比如，ANY children.age < 18。
 ALL：指定下列表达式中的所有元素。比如，ALL children.age < 18。
 NONE：指定下列表达式中没有的元素。比如，NONE children.age < 18。它在逻辑上等于NOT (ANY ...)。
 IN：等于SQL的IN操作，左边的表达必须出现在右边指定的集合中。比如，name IN { 'Ben', 'Melissa', 'Nick' }。
 
 提示:
 1. 谓词中的匹配指令关键字通常使用大写字母
 2. 谓词中可以使用格式字符串
 3. 如果通过对象的key
 path指定匹配条件，需要使用%K
 
 */

@end

