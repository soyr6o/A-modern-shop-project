import 'dart:typed_data';
import 'dart:math' as math;
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_service.dart';
import 'package:appwrite2/data/repositories/user/fetch_address.dart';
import 'package:get/get.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class CartCheck extends StatefulWidget {
  const CartCheck({super.key});

  @override
  State<CartCheck> createState() => _CartCheckState();
}

class _CartCheckState extends State<CartCheck> {

  late Future<List<Map<String, dynamic>>> _cartFuture;
  final fetch = CartItem();
  // انتخاب آدرس ذخیره‌شده‌ی کاربر
  // Persian: نگهداری ایندکس آدرس انتخاب‌شده برای استفاده در ارسال سفارش
  int? _selectedAddressIndex;
  late Future<List<Map<String, dynamic>>> _addressesFuture;
  // Persian: جزئیات آدرس انتخاب‌شده برای نمایش و استفاده در ادامه‌ی فرایند
  Map<String, dynamic>? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _cartFuture = fetch.fetchCartItem();
    // Persian: فراخوانی آدرس‌های ذخیره شده‌ی کاربر برای نمایش در لیست انتخاب
    _addressesFuture = FetchAddress().getUserAddress();
  }

  Future<Uint8List> getImage(String fileId) async {
    final appwrite = Get.find<AppwriteService>();
    final bytes = await appwrite.storage.getFileView(
      bucketId: "68ad372a00284ca04cb2",
      fileId: fileId,
    );
    return bytes;
  }
  @override
  Widget build(BuildContext context) {
    final total = Get.put(CartItemController());
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : Colors.black,
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(future: _cartFuture, builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade500 : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Lottie.asset(MImage.loadingAnimation5),)),
                );
              }
              if (!snapshot.hasData) {
                return Icon(Icons.image_not_supported);
              }
              final data = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade500 : Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  height: 300,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        final item = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: AspectRatio(aspectRatio: 1,
                                  child: FutureBuilder(future: getImage(item["mainImageId"]), builder: (context,imgshot){
                                    if (imgshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: Lottie.asset(MImage.loadingAnimation5),);
                                    }
                                    if (!imgshot.hasData) {
                                      return Icon(Icons.image_not_supported);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.memory(imgshot.data!,),
                                        ),
                                      ),
                                    );
                                  }),),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text("Name: ${item['productName']}"),
                                    SizedBox(height: 5,),
                                    Text("Quantity: ${item['quantity']}"),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: Text("Price: ${item['priceAtAdd']}"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Obx(() {
                    // Persian: محاسبه مقادیر صورت‌حساب
                    final double subtotal = total.totalPrice.value;
                    // Persian: مالیات تخمینی (Estimated Tax): 8.5% از ساب‌توتر
                    final double tax = double.parse((subtotal * 0.085).toStringAsFixed(2));
                    // Persian: محاسبه هزینه ارسال بر اساس وزن با حداقل وزن قابل محاسبه و نرخ‌های نمونه
                    const double defaultWeightKgPerUnit = 0.2; // وزن پیش‌فرض هر کالا (کیلوگرم)
                    const double minBillableWeightKg = 0.5;    // حداقل وزن محاسبه‌ای
                    const double ratePerKgDomestic = 6.0;       // نرخ داخلی به ازای هر کیلو (نمونه)
                    const double ratePerKgInternational = 18.0; // نرخ بین‌المللی به ازای هر کیلو (نمونه)

                    final int totalUnits = total.productQuantityInCart.value; // تعداد کل واحدهای کالا
                    final double assumedTotalWeight = totalUnits * defaultWeightKgPerUnit;
                    final double billableWeight = math.max(assumedTotalWeight, minBillableWeightKg);

                    double? shippingAmount;
                    String shippingLabel;
                    if (_selectedAddress != null) {
                      final country = (_selectedAddress!['country'] ?? '').toString().trim();
                      final isUS = country.isNotEmpty && country.toLowerCase() == 'united states';
                      if (isUS) {
                        // Persian: ارسال داخلی بر اساس وزن
                        shippingAmount = double.parse((billableWeight * ratePerKgDomestic).toStringAsFixed(2));
                        shippingLabel = 'Shipping (based on weight)';
                      } else {
                        // Persian: ارسال بین‌المللی بر اساس وزن
                        shippingAmount = double.parse((billableWeight * ratePerKgInternational).toStringAsFixed(2));
                        shippingLabel = 'Intl shipping (based on weight)';
                      }
                    } else {
                      // Persian: بدون آدرس انتخاب‌شده - نمایش محاسبه در مرحله پرداخت
                      shippingAmount = null;
                      shippingLabel = 'Shipping (calculated at checkout)';
                    }
                    // Persian: مجموع نهایی - اگر هزینه ارسال نامشخص است، فعلاً در مجموع لحاظ نمی‌شود
                    final double orderTotal = double.parse((subtotal + tax + (shippingAmount ?? 0)).toStringAsFixed(2));

                    String formatCurrency(double v) => "\$${v.toStringAsFixed(2)}";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Subtotal"),
                            Text(formatCurrency(subtotal)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Persian: نمایش توضیح ارسال
                            Text(shippingLabel),
                            if (shippingAmount == null)
                              const Text('—')
                            else
                              Text(shippingAmount == 0 ? 'FREE' : formatCurrency(shippingAmount)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Estimated tax"),
                            Text(formatCurrency(tax)),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Order total",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              formatCurrency(orderTotal),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        // Persian: نکته‌ی بین‌المللی - نمایش واحد پول و قوانین رایج ارسال
                      ],
                    );
                  }),
                ),
              ),
            ),

            // Persian: لیست آدرس‌های ذخیره‌شده‌ی کاربر با امکان انتخاب یکی از آن‌ها
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Persian: عنوان بخش آدرس‌ها
                      const Text(
                        "Select a delivery address",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: _addressesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LinearProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Text("Error retrieving addresses");
                          }
                          final addresses = snapshot.data ?? [];

                          if (addresses.isEmpty) {
                            return const Text("No address registered.");
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addresses.length,
                            separatorBuilder: (_, __) => const Divider(height: 8),
                            itemBuilder: (context, index) {
                              final address = addresses[index];
                              final title = (address['name'] ?? '').toString();
                              final line1 = (address['street'] ?? '').toString();
                              final line2 = [address['city'], address['state'], address['postCode']]
                                  .where((e) => (e?.toString().isNotEmpty ?? false))
                                  .join(', ');

                              // Persian: هر آدرس در یک کارت مجزا با نمایش نام و شماره تلفن
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    setState(() {
                                      _selectedAddressIndex = index;
                                      _selectedAddress = address;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Radio<int>(
                                          value: index,
                                          groupValue: _selectedAddressIndex,
                                          onChanged: (v) {
                                            setState(() {
                                              _selectedAddressIndex = v;
                                              _selectedAddress = address;
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    title.isEmpty ? 'Unnamed' : title,
                                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                                  ),
                                                  // Persian: نمایش شماره تلفن مخاطب
                                                  Text(
                                                    (address['phoneNumber'] ?? '').toString(),
                                                    style: const TextStyle(color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Text(line1),
                                              if (line2.isNotEmpty) Text(line2),
                                              if ((address['country'] ?? '').toString().isNotEmpty)
                                                Text((address['country']).toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      // Persian: نمایش خلاصه آدرس انتخاب‌شده در یک باکس کوچک
                      if (_selectedAddress != null)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green.withOpacity(0.05),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Selected address", style: TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Text((_selectedAddress!['name'] ?? '').toString()),
                              Text((_selectedAddress!['phoneNumber'] ?? '').toString()),
                              Text((_selectedAddress!['street'] ?? '').toString()),
                              Text([
                                _selectedAddress!['city'],
                                _selectedAddress!['state'],
                                _selectedAddress!['postCode'],
                              ].where((e) => (e?.toString().isNotEmpty ?? false)).join(', ')),
                              if ((_selectedAddress!['country'] ?? '').toString().isNotEmpty)
                                Text((_selectedAddress!['country']).toString()),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _selectedAddressIndex == null ? null : () {
                            final chosen = _selectedAddress;
                            if (chosen != null) {
                              Get.snackbar("Success", "Address selected successfully.",
                                backgroundColor: Colors.green.shade600,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(12),
                                borderRadius: 8,
                              );
                            }
                          },
                          child: const Text('Use this address'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
        ),
      );
  }
}
