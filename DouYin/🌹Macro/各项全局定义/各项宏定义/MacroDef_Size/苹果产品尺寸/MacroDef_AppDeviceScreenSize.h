//
//  MacroDef_AppDeviceScreenSize.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/20.
//

#ifndef MacroDef_AppDeviceScreenSize_h
#define MacroDef_AppDeviceScreenSize_h

#define CurrentModeSize UIScreen.mainScreen.currentMode.size
#define CurrentModeRespondSelector CurrentModeRespondSelector
#pragma mark —— 判断iPhone
// 判断 【iPhone 6】、【iPhone 6s】、【iPhone 7】、【iPhone 8】
#define iPh6_6s_7_8 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(750, 1334), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 6Plus】、【iPhone 6sPlus】、【iPhone 7Plus】、【iPhone 8Plus】
#define iPh6_6s_7_8PlusSeries (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2208), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone X】
#define iPhX (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone XR】
#define iPhXR (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(828, 1792), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone XS】
#define iPhXS (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneXS_Max】
#define iPhXS_Max (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2688), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneSE (第一代)】
#define iPhSE_1 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(640, 1136), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneSE (第二代)】
#define iPhSE_2 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(750, 1334), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11】
#define iPh11 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(828, 1792), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11 Pro】
#define iPh11Pro (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11 Pro Max】
#define iPh11ProMax (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2688), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Mini】
#define iPh12Mini (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1080, 2340), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12】
#define iPh12 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1170, 2532), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Pro】
#define iPh12Pro (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1170, 2532), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Pro Max】
#define iPh12ProMax (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1284, 2778), CurrentModeSize) && !isPad : NO)
#pragma mark —— 判断iPad
// 判断 【iPad mini 7.9】、【iPad 9.7】
#define iPadMini7_9Or9_7 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2048, 1536), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 10.2】
#define iPadPro10_2 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2160, 1620), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 10.5】
#define iPadPro10_5 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2224, 1668), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 11】
#define iPadPro11 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2388, 1668), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 12.9】
#define iPadPro12_9 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2732, 2048), CurrentModeSize) && !isiPhone : NO)

#endif /* MacroDef_AppDeviceScreenSize_h */
