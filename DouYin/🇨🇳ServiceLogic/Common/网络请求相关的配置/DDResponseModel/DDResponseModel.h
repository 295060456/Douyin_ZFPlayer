//
//  DDResponseModel.h
//  DouDong-II
//
//  Created by xxx on 2021/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDResponseModel : NSObject

@property(nonatomic,assign)int code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)id data;

@end

NS_ASSUME_NONNULL_END

//if (successBlock) {
//    if ([responseObject isKindOfClass:NSDictionary.class]) {
//        NSDictionary *dataDic = (NSDictionary *)responseObject;
//        DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
//        // 公共请求错误直接抛出
//        if (model.code != HTTPResponseCodeSuccess) {
//            [WHToast toastMsg:model.msg];
//        }else{
//            successBlock(model);
//        }
//    }else{
//        [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
//    }
//}
