//
//  MacroDef_App.h
//  DouYin
//
//  Created by Jobs on 2021/2/2.
//

#ifndef MacroDef_App_h
#define MacroDef_App_h

//输入原型图上的宽和高，对外输出App对应的移动设备的真实宽高
#define KWidth(width) (SCREEN_WIDTH / 375) * (width) //375 对应原型图的宽
#define KHeight(height) (SCREEN_HEIGHT / 743) * (height) //743 对应原型图的高

#endif /* MacroDef_App_h */
