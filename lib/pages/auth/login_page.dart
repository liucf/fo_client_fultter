import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fo/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // String initialCountry = 'CN';
    PhoneNumber number = PhoneNumber(isoCode: 'CN');
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController smsCodeController = TextEditingController();

    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            const Text(
              "welcomelogin",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: SizedBox(
                width: width * 0.8,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    // debugPrint(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    if (value && loginController.isCounting.isFalse) {
                      loginController.isButtonEnable.value = true;
                    } else {
                      loginController.isButtonEnable.value = false;
                    }
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: phoneNumberController,
                  formatInput: true,
                  // countries: const ['CN', 'US'],
                  hintText: tr("input_phone"),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  // inputBorder: const OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    debugPrint('On Saved: $number');
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.9,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: <Widget>[
                    // const Text(
                    //   '验证码',
                    //   style: TextStyle(fontSize: 13, color: Color(0xff333333)),
                    // ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          maxLines: 1,
                          onSaved: (value) {
                            debugPrint(value);
                          },
                          onChanged: (value) {
                            // debugPrint(value);
                            if (value.length == 4) {
                              loginController.isSubmitButtonEnable.value = true;
                            } else {
                              loginController.isSubmitButtonEnable.value =
                                  false;
                            }
                          },
                          // validator: (String? value) {
                          //   debugPrint(value);
                          //   if (value != null && value.length == 4) {
                          //     loginController.isSubmitButtonEnable.value = true;
                          //     return null;
                          //   } else {
                          //     loginController.isSubmitButtonEnable.value =
                          //         false;
                          //     return 'Please input 4 digital validate number';
                          //   }
                          // return ()
                          //     ?
                          //     : null;
                          // },
                          controller: smsCodeController,
                          textAlign: TextAlign.left,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4)
                          ],
                          decoration: const InputDecoration(
                            hintText: ('填写验证码'),
                            // contentPadding: EdgeInsets.only(top: 5, bottom: 0),
                            // hintStyle: TextStyle(
                            //     // color: Color(0xff999999),
                            //     // fontSize: 13,
                            //     ),
                            alignLabelWithHint: true,
                            // border:
                            //     OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 115,
                      child: MaterialButton(
                        disabledColor: Colors.grey.withOpacity(0.1), //按钮禁用时的颜色
                        disabledTextColor:
                            Colors.black.withOpacity(0.6), //按钮禁用时的文本颜色
                        textColor: loginController.isButtonEnable.isTrue
                            ? Colors.white
                            : Colors.black.withOpacity(0.7), //文本颜色
                        color: loginController.isButtonEnable.isTrue
                            ? const Color(0xff44c5fe)
                            : Colors.grey.withOpacity(0.1), //按钮的颜色
                        splashColor: loginController.isButtonEnable.isTrue
                            ? Colors.white.withOpacity(0.1)
                            : Colors.transparent,
                        shape: const StadiumBorder(side: BorderSide.none),
                        onPressed: loginController.isButtonEnable.isTrue
                            ? () {
                                loginController
                                    .clickSendSMS(phoneNumberController.text);
                              }
                            : null,
                        //      child: Text('重新发送 (${secondSy})'),
                        child: Text(
                          loginController.buttonText.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              "input_phone_desc",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ).tr(),
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              width: width * 0.8,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: loginController.isSubmitButtonEnable.isTrue
                    ? () {
                        if (smsCodeController.text.toString() ==
                            loginController.validateCode.toString()) {
                          debugPrint("验证码正确！");
                          loginController.login();
                        } else {
                          Get.snackbar(
                            "Error",
                            "验证码错误，请重新输入",
                            icon: const Icon(Icons.error_outline_rounded,
                                color: Colors.white),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            borderRadius: 20,
                            margin: const EdgeInsets.all(15),
                            colorText: Colors.white,
                            duration: const Duration(seconds: 4),
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack,
                          );
                        }
                      }
                    : null,
                child: const Text(
                  "login",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ).tr(),
              ),
            )
          ],
        ),
      );
    });
  }
}
