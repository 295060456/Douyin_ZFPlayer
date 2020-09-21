
typedef void(^NoResultBlock)(void);
typedef void(^MKDataBlock)(id data);
typedef void(^TwoDataBlock)(id data,id data2);
typedef void(^ThreeDataBlock)(id data,id data2,id data3);
typedef void(^FourDataBlock)(id data,id data2,id data3,id data4);
typedef void(^FiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef void(^SixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef void(^SevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef void(^EightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef void(^NineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef void(^TenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef id(^noResultBlock)(void);
typedef id(^mkDataBlock)(id data);
typedef id(^twoDataBlock)(id data,id data2);
typedef id(^threeDataBlock)(id data,id data2,id data3);
typedef id(^fourDataBlock)(id data,id data2,id data3,id data4);
typedef id(^fiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef id(^sixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef id(^sevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef id(^eightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef id(^nineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef id(^tenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef void(^MMDataBlock)(id firstArg,...);//第一个参数写：有多少个实际参数 用NSNumber表示 @1

typedef id(^mmDataBlock)(id firstArg,...);//第一个参数写：有多少个实际参数 用NSNumber表示 @1
