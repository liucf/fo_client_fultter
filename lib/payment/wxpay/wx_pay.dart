import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fo/payment/wxpay/wechat_pay_model.dart';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

/// 微信支付
class WxPay {
  static void pay() async {
    bool installed = await fluwx.isWeChatInstalled;
    if (!installed) {
      // 未安装微信，请前去下载
      String name = Platform.isIOS ? "AppStore" : "应用商店";
      Get.snackbar("提醒", "您未安装微信,请前往$name下载~");
      return;
    }

    // try {
    //   WeChatPayModel weChatPayParams = WeChatPayModel(
    //     dotenv.env['WX_APPID']!,
    //     "partnerId",
    //     "prepayId",
    //     "nonceStr",
    //     DateUtil.currentTimeMillis(),
    //     "package",
    //     "sign",
    //     "signType",
    //   );

    //   if (weChatPayParams != null) {
    //     fluwx.payWithWeChat(
    //       appId: weChatPayParams.appId,
    //       partnerId: weChatPayParams.partnerId,
    //       prepayId: weChatPayParams.prepayId,
    //       packageValue: weChatPayParams.package,
    //       nonceStr: weChatPayParams.nonceStr,
    //       timeStamp: weChatPayParams.timestamp,
    //       sign: weChatPayParams.sign,
    //     );
    //     // 监听支付结果
    //     fluwx.weChatResponseEventHandler.listen((event) async {
    //       print(event.errCode);
    //       // 支付成功
    //       if (event.errCode == 0) {
    //         Toast.show('微信支付成功~');
    //       } else {
    //         Toast.show('微信支付失败~');
    //       }
    //       // 关闭弹窗
    //     });
    //   }
    // } catch (e) {
    //   Toast.show("吊起微信失败~${e.toString()}");
    // }
  }
}
