import 'package:dialogi_app/controllers/subscription_controllers/paypal_payment_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/stripe_payment_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/subscription_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/alert_dialog/alert_dialog.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  // StripePaymentController stripePaymentController = Get.find<StripePaymentController>();
  SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  PaypalPaymentController paypalPaymentController = Get.find<PaypalPaymentController>();

  String? premium = Get.parameters["premium"];

  bool visaCardChecked = false;
  bool masterCardChecked = false;
  bool paypalCardChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const CustomImage(
                imageSrc: AppIcons.chevronLeft,
                size: 24,
              )),
          CustomText(
            text: premium == "true"
                ? AppStrings.upgradetoPremium
                : AppStrings.upgradetoPremiumPlus,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox(),
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            const CustomText(
              maxLines: 3,
              text: AppStrings.selectPaymentMethodForUpgrade,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),

            SizedBox(
              height: 24.h,
            ),

            ///<<<================= Card Icons List ======================>>>

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        visaCardChecked = true;
                        masterCardChecked = false;
                        paypalCardChecked = false;
                      });
                    },
                    child: Container(
                      decoration: visaCardChecked? const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: AppColors.blue_300,
                            offset: Offset(0, 0)
                          )
                        ]
                      ): null,
                      child: const CustomImage(
                        imageSrc: AppImages.visa,
                        imageType: ImageType.png,
                        size: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        visaCardChecked = false;
                        masterCardChecked = true;
                        paypalCardChecked = false;
                      });
                    },
                    child: Container(
                      decoration: masterCardChecked? const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: AppColors.blue_300,
                                offset: Offset(0, 0)
                            )
                          ]
                      ): null,
                      child: const CustomImage(
                        imageSrc: AppImages.masterCard,
                        imageType: ImageType.png,
                        size: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        visaCardChecked = false;
                        masterCardChecked = false;
                        paypalCardChecked = true;
                      });
                    },
                    child: Container(
                      decoration: paypalCardChecked? const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: AppColors.blue_300,
                                offset: Offset(0, 0)
                            )
                          ]
                      ): null,
                      child: const CustomImage(
                        imageSrc: AppImages.paypal,
                        imageType: ImageType.png,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //
            //     CheckboxListTile(
            //       contentPadding: EdgeInsets.only(left: 60),
            //       title: Transform.translate(
            //         offset: Offset(-60, 0),
            //         child: CustomImage(
            //           imageSrc: AppImages.visa,
            //           imageType: ImageType.png,
            //           size: 100.w,
            //         ),
            //       ),
            //       value: visaCardChecked,
            //       onChanged: (newValue) {
            //         setState(() {
            //           visaCardChecked = newValue!;
            //           masterCardChecked = false;
            //           paypalCardChecked = false;
            //         });
            //       },
            //       controlAffinity:
            //           ListTileControlAffinity.leading, //  <-- leading Checkbox
            //     ),
            //     SizedBox(
            //       height: 8.h,
            //     ),
            //     CheckboxListTile(
            //       contentPadding: EdgeInsets.only(left: 50),
            //       title: Transform.translate(
            //         offset: Offset(-60, 0),
            //         child: CustomImage(
            //           imageSrc: AppImages.masterCard,
            //           imageType: ImageType.png,
            //           size: 100.w,
            //         ),
            //       ),
            //       value: masterCardChecked,
            //       onChanged: (newValue) {
            //         setState(() {
            //           visaCardChecked = false;
            //           masterCardChecked = newValue!;
            //           paypalCardChecked = false;
            //         });
            //       },
            //       controlAffinity:
            //           ListTileControlAffinity.leading, //  <-- leading Checkbox
            //     ),
            //     SizedBox(
            //       height: 8.h,
            //     ),
            //     CheckboxListTile(
            //       contentPadding: EdgeInsets.only(left: 50),
            //       title: Transform.translate(
            //         offset: Offset(-60, 0),
            //         child: CustomImage(
            //           imageSrc: AppImages.paypal,
            //           imageType: ImageType.png,
            //           size: 100.w,
            //         ),
            //       ),
            //       value: paypalCardChecked,
            //       onChanged: (newValue) {
            //         setState(() {
            //           visaCardChecked = false;
            //           masterCardChecked = false;
            //           paypalCardChecked = newValue!;
            //         });
            //       },
            //       controlAffinity:
            //           ListTileControlAffinity.leading, //  <-- leading Checkbox
            //     ),
            //   ],
            // ),

            ///<<<=============== card holder Details =====================>>>

            // Column(
            //   children: [
            //     CustomTextField(
            //       keyboardType: TextInputType.text,
            //       textAlign: TextAlign.start,
            //       hintText: AppStrings.entercardholdername,
            //       hintStyle: GoogleFonts.prompt(
            //           fontSize: 14.h,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.black_300),
            //       inputTextStyle: GoogleFonts.prompt(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 16.h,
            //           color: AppColors.black_500),
            //       fieldBorderColor: Colors.white,
            //       fieldBorderRadius: 8,
            //       isPrefixIcon: true,
            //       prefixIcon: Icon(
            //         Icons.person,
            //         size: 24.h,
            //         color: AppColors.blue_500,
            //       ),
            //     ),
            //     SizedBox(
            //       height: 24.h,
            //     ),
            //
            //     ///card number
            //     CustomTextField(
            //       inputFormatters: [
            //         FilteringTextInputFormatter.digitsOnly,
            //       ],
            //       keyboardType: const TextInputType.numberWithOptions(signed: true),
            //       textAlign: TextAlign.start,
            //       hintText: AppStrings.cardnumber,
            //       hintStyle: GoogleFonts.prompt(
            //           fontSize: 14.h,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.black_300),
            //       inputTextStyle: GoogleFonts.prompt(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 16.h,
            //           color: AppColors.black_500),
            //       fieldBorderColor: Colors.white,
            //       fieldBorderRadius: 8,
            //       isPrefixIcon: true,
            //       prefixIcon: Icon(
            //         Icons.credit_card,
            //         size: 24.h,
            //         color: AppColors.blue_500,
            //       ),
            //     ),
            //     SizedBox(
            //       height: 24.h,
            //     ),
            //
            //     ///cvv
            //     CustomTextField(
            //         inputFormatters: [
            //           FilteringTextInputFormatter.digitsOnly,
            //         ],
            //         keyboardType:
            //         const TextInputType.numberWithOptions(signed: true),
            //         textAlign: TextAlign.start,
            //         hintText: AppStrings.cVVCVC,
            //         hintStyle: GoogleFonts.prompt(
            //             fontSize: 14.h,
            //             fontWeight: FontWeight.w400,
            //             color: AppColors.black_300),
            //         inputTextStyle: GoogleFonts.prompt(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 16.h,
            //             color: AppColors.black_500),
            //         fieldBorderColor: Colors.white,
            //         fieldBorderRadius: 8,
            //         isPrefixIcon: true,
            //         prefixIcon: IconButton(
            //             onPressed: () {},
            //             icon: const Icon(
            //               Icons.lock_outlined,
            //               size: 24,
            //               color: AppColors.blue_500,
            //             ))),
            //
            //     const SizedBox(
            //       height: 24,
            //     ),
            //
            //     ///dob
            //     CustomTextField(
            //       inputFormatters: [
            //         FilteringTextInputFormatter.digitsOnly,
            //       ],
            //       keyboardType: const TextInputType.numberWithOptions(signed: true),
            //       textAlign: TextAlign.start,
            //       hintText: AppStrings.mMYY,
            //       hintStyle: GoogleFonts.prompt(
            //           fontSize: 14.h,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.black_300),
            //       inputTextStyle: GoogleFonts.prompt(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 16.h,
            //           color: AppColors.black_500),
            //       fieldBorderColor: Colors.white,
            //       fieldBorderRadius: 8,
            //       isPrefixIcon: true,
            //       prefixIcon: Icon(
            //         Icons.date_range_outlined,
            //         size: 24.h,
            //         color: AppColors.blue_500,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<StripePaymentController>(
        builder: (stripePaymentController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: stripePaymentController.isPaymentRepoCalled? const Center(child: CircularProgressIndicator()) : CustomElevatedButton(
              onPressed: () {
                if(visaCardChecked || masterCardChecked){
                  stripePaymentController.makePayment(amount: premium == "true"
                      ? "${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].price}"
                      : "${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![1].price}",
                    subscriptionName: premium == "true"? "Premium" : "Premium Plus",
                    currency: 'USD', );

                } else if(paypalCardChecked){
                  print("object");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => paypalPaymentController.buildPaypalCheckout(context: context, amount: premium == "true"
                        ? "${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].price}"
                        : "${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![1].price}",
                      subscriptionName: premium == "true"? "Premium" : "Premium Plus",
                      currency: 'USD',),
                  ));
                }
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialogs(
                //           successtext: AppStrings.successful,
                //           completeText: AppStrings.proceedToPayment,
                //           buttonText: AppStrings.gotoHome,
                //           onPressed: () {
                //             Get.toNamed(AppRoutes.homeScreen);
                //           });
                //     });
              },
              titleText: AppStrings.proceedToPayment),
        );
      },),
    );
  }
}
