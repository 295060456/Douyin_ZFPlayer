//
//  MacroDef_Cor.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Cor_h
#define MacroDef_Cor_h

#pragma mark ======================================== 色彩相关 ========================================
#define kTableViewBackgroundColor HEXCOLOR(0xf6f5fa)
///常见颜色
#define kClearColor     [UIColor clearColor]
#define kBlackColor     [UIColor blackColor]
#define kBlueColor      [UIColor blueColor]
#define kWhiteColor     [UIColor whiteColor]
#define kCyanColor      [UIColor cyanColor]
#define kGrayColor      [UIColor grayColor]
#define kOrangeColor    [UIColor orangeColor]
#define kRedColor       [UIColor redColor]
#define KBrownColor     [UIColor brownColor]
#define KDarkGrayColor  [UIColor darkGrayColor]
#define KDarkTextColor  [UIColor darkTextColor]
#define KYellowColor    [UIColor yellowColor]
#define KPurpleColor    [UIColor purpleColor]
#define KLightTextColor [UIColor lightTextColor]
#define KLightGrayColor [UIColor lightGrayColor]
#define KGreenColor     [UIColor greenColor]
#define KMagentaColor   [UIColor magentaColor]
///System colors
/* Some colors that are used by system elements and applications.
* These return named colors whose values may vary between different contexts and releases.
* Do not make assumptions about the color spaces or actual colors used.
*/
#define KSystemRedColor [UIColor systemRedColor]
#define KSystemGreenColor [UIColor systemGreenColor]
#define KSystemBlueColor [UIColor systemBlueColor]
#define KSystemOrangeColor [UIColor systemOrangeColor]
#define KSystemYellowColor [UIColor systemYellowColor]
#define KSystemPinkColor [UIColor systemPinkColor]
#define KSystemPurpleColor [UIColor systemPurpleColor]
#define KSystemTealColor [UIColor systemTealColor]
#define KSystemIndigoColor [UIColor systemIndigoColor]
#define KSystemGrayColor [UIColor systemGrayColor]
/* The numbered variations, systemGray2 through systemGray6, are grays which increasingly
* trend away from systemGray and in the direction of systemBackgroundColor.
*
* In UIUserInterfaceStyleLight: systemGray1 is slightly lighter than systemGray.
*                               systemGray2 is lighter than that, and so on.
* In UIUserInterfaceStyleDark:  systemGray1 is slightly darker than systemGray.
*                               systemGray2 is darker than that, and so on.
*/
#define KSystemGray2Color [UIColor systemGray2Color]
#define KSystemGray3Color [UIColor systemGray3Color]
#define KSystemGray4Color [UIColor systemGray4Color]
#define KSystemGray5Color [UIColor systemGray5Color]
#define KSystemGray6Color [UIColor systemGray6Color]
/* Foreground colors for static text and related elements.
*/
#define KLabelColor [UIColor labelColor]
#define KSecondaryLabelColor [UIColor secondaryLabelColor]
#define KTertiaryLabelColor [UIColor tertiaryLabelColor]
#define KQuaternaryLabelColor [UIColor quaternaryLabelColor]
/* Foreground color for standard system links.
*/
#define KLinkColor [UIColor linkColor]
#define KPlaceholderTextColor [UIColor placeholderTextColor]
#define KSeparatorColor [UIColor separatorColor]
#define KOpaqueSeparatorColor [UIColor opaqueSeparatorColor]
///Background colors
/* We provide two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
*
* Each stack has three "levels" of background colors. The first color is intended to be the
* main background, farthest back. Secondary and tertiary colors are layered on top
* of the main background, when appropriate.
*
* Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
* We do not recommend mixing and matching background colors between stacks.
* The foreground colors above are designed to work in both stacks.
*
* 1. systemBackground
*    Use this stack for views with standard table views, and designs which have a white
*    primary background in light mode.
*/
#define KSystemBackgroundColor [UIColor systemBackgroundColor]
#define KSecondarySystemBackgroundColor [UIColor secondarySystemBackgroundColor]
#define KTertiarySystemBackgroundColor [UIColor tertiarySystemBackgroundColor]
/* 2. systemGroupedBackground
*    Use this stack for views with grouped content, such as grouped tables and
*    platter-based designs. These are like grouped table views, but you may use these
*    colors in places where a table view wouldn't make sense.
*/
#define KSystemGroupedBackgroundColor [UIColor systemGroupedBackgroundColor]
#define KSecondarySystemGroupedBackgroundColor [UIColor secondarySystemGroupedBackgroundColor]
#define KTertiarySystemGroupedBackgroundColor [UIColor tertiarySystemGroupedBackgroundColor]
///Fill colors
/* Fill colors for UI elements.
* These are meant to be used over the background colors, since their alpha component is less than 1.
*
* systemFillColor is appropriate for filling thin and small shapes.
* Example: The track of a slider.
*/
#define KSystemFillColor [UIColor systemFillColor]
/* secondarySystemFillColor is appropriate for filling medium-size shapes.
* Example: The background of a switch.
*/
#define KSecondarySystemFillColor [UIColor secondarySystemFillColor]
/* tertiarySystemFillColor is appropriate for filling large shapes.
* Examples: Input fields, search bars, buttons.
*/
#define KTertiarySystemFillColor [UIColor tertiarySystemFillColor]
/* quaternarySystemFillColor is appropriate for filling large areas containing complex content.
* Example: Expanded table cells.
*/
#define KQuaternarySystemFillColor [UIColor quaternarySystemFillColor]
///Other colors
/* lightTextColor is always light, and darkTextColor is always dark, regardless of the current UIUserInterfaceStyle.
* When possible, we recommend using `labelColor` and its variants, instead.
*/
#define KLightTextColor [UIColor lightTextColor]
#define KDarkTextColor [UIColor darkTextColor]
/* groupTableViewBackgroundColor is now the same as systemGroupedBackgroundColor.
*/
#define KGroupTableViewBackgroundColor [UIColor groupTableViewBackgroundColor]
#define KViewFlipsideBackgroundColor [UIColor viewFlipsideBackgroundColor]
#define KScrollViewTexturedBackgroundColor [UIColor scrollViewTexturedBackgroundColor]
#define KUnderPageBackgroundColor [UIColor underPageBackgroundColor]
///RGB颜色
#define RGBSAMECOLOR(x) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:1]
#define COLOR_RGB(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
///随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 \
green:arc4random_uniform(256) / 255.0 \
blue:arc4random_uniform(256) / 255.0 \
alpha:1] \
///十六进制颜色
#define HEXCOLOR(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1]
#define COLOR_HEX(hexValue, al)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:al]

#endif /* MacroDef_Cor_h */
