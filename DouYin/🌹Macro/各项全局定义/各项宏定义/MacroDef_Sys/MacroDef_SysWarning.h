//
//  MacroDef_SysWarning.h
//  DouYin
//
//  Created by Jobs on 2021/3/12.
//

#ifndef MacroDef_SysWarning_h
#define MacroDef_SysWarning_h

// 封装处理系统宏忽略警告⚠️
// 警告查询网址：http://ww1.fuckingclangwarnings.com/
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
//#pragma clang diagnostic ignored "-Wincomplete-implementation"
//#pragma clang diagnostic ignored "-Wdeprecated-implementations"
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//#pragma clang diagnostic pop

/*
     拓展知识：
     在忽略警告的处理上
     你可以在项目运行的时候
     右键警告选择 reveal in log
     就可以在警告详情中发现 -Wobjc-protocol-method-implementation 这么一个格式的字段
     在-W后添加一个no-
     然后添加到 other warning flags 中
     就可以忽略你这些警告了
 */

//⚠️ 在category中重写了原类的方法
#define SuppressWobjcProtocolMethodImplementationWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wobjc-protocol-method-implementation\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
/*
    用于NS_DESIGNATED_INITIALIZER,
    NS_DESIGNATED_INITIALIZER是一个宏,代替的是runtime中的一个东西
    作用：对于多个构造方法，它可以指定一个基础的构造方法；其它快捷的构造方法都必须通过它来实现类的初始化。代码规范的一种，可以避免不必要的bug，良好的编程习惯
    注意事项：指定构造方法需要先调用父类的指定构造方法，然后再对自身类的属性进行初始化。如果子类的指定构造t方法与父类不同，则该子类需要覆写父类的指定构造方法，并在该实现里面调用自身的指定构造方法。
 */
// ⚠️ 你使用了非指定初始化方法之外的方法。不影响正常使用。
#define SuppressDesignatedInitializersWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wobjc-designated-initializers\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
//⚠️【未声明的选择器】
#define SuppressWundeclaredSelectorWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
// ????? 什么意思
#define SuppressWincompatiblePointerTypesWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wincompatible-pointer-types\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
// ⚠️【方法定义未实现】
#define SuppressWincompleteImplementationWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wincomplete-implementation\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
// ⚠️【废弃声明 —— 实现】
#define SuppressWdeprecatedImplementationsWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wdeprecated-implementations\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
// ⚠️【废弃声明 —— 方法】
#define SuppressWdeprecatedDeclarationsWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)
// ⚠️【编译器发现可能存在的内存泄漏问题】
#define SuppressWarcPerformSelectorLeaksWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
} while (0)


#endif /* MacroDef_SysWarning_h */
