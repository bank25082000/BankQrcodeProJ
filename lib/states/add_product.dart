import 'package:bankqrcodeproj/models/product_model.dart';
import 'package:bankqrcodeproj/utility/my_constant.dart';
import 'package:bankqrcodeproj/utility/my_dialog.dart';
import 'package:bankqrcodeproj/widgets/show_button.dart';
import 'package:bankqrcodeproj/widgets/show_form.dart';
import 'package:bankqrcodeproj/widgets/show_image.dart';
import 'package:bankqrcodeproj/widgets/show_text.dart';
import 'package:bankqrcodeproj/widgets/show_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController barCodeTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();

  String? codeScan, name, status, uidRecord, price, amount;
  Timestamp? dateRecord;

  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    DateTime dateTime = DateTime.now();
    dateRecord = Timestamp.fromDate(dateTime);

    status = 'เพิ่มสินค้า';
    uidRecord = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.white,
      appBar: AppBar(
        title: ShowText(
          text: 'เพิ่ม และ เปลี่ยนแปลง สินค้า',
          textStyle: MyConstant().h2Style(),
        ),
        backgroundColor: MyConstant.white,
        foregroundColor: MyConstant.dark,
        elevation: 0,
      ),
      body: ListView(
        children: [
          buttonScanQrcode(),
          newCenter(
              widget: ShowForm(
            textEditingController: barCodeTextEditingController,
            iconData: Icons.qr_code,
            hint: 'barcode :',
            changeFunc: (p0) {
              codeScan = p0.trim();
            },
          )),
          newCenter(
              widget: ShowForm(
            textEditingController: nameTextEditingController,
            iconData: Icons.fingerprint,
            hint: 'ชื่อสินค้า',
            changeFunc: (p0) {
              name = p0.trim();
            },
          )),
          newCenter(
              widget: ShowForm(
            textEditingController: priceTextEditingController,
            iconData: Icons.money,
            hint: 'ราคา:',
            changeFunc: (p0) {
              price = p0.trim();
            },
          )),
          newCenter(
              widget: ShowForm(
            textEditingController: amountTextEditingController,
            iconData: Icons.numbers,
            hint: 'จำนวน:',
            changeFunc: (p0) {
              amount = p0.trim();
            },
          )),
          newCenter(
              widget: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowButton(
                  width: 120,
                  label: 'ล้างข้อมูล',
                  pressFunc: () {
                    processClear();
                  },
                ),
                ShowButton(
                  width: 120,
                  label: 'เพิ่มสินค้า',
                  pressFunc: () async {
                    if ((codeScan?.isEmpty ?? true) ||
                        (name?.isEmpty ?? true) ||
                        (price?.isEmpty ?? true) ||
                        (amount?.isEmpty ?? true)) {
                      MyDialog(context: context).normalDialog(
                          title: 'กรอกไม่ครบ',
                          subTitle: 'กรุณากรอกให้ครบทุกช่อง');
                    } else {
                      await FirebaseFirestore.instance
                          .collection('product')
                          .where('codeScan', isEqualTo: codeScan)
                          .get()
                          .then((value) async {
                        if (value.docs.isEmpty) {
                          ProductModal productModal = ProductModal(
                              codeScan: codeScan!,
                              name: name!,
                              price: double.parse(price!),
                              amount: int.parse(amount!),
                              uidRecord: uidRecord!,
                              dateRecord: dateRecord!,
                              status: status!);

                          await FirebaseFirestore.instance
                              .collection('product')
                              .doc()
                              .set(productModal.toMap())
                              .then((value) {
                            processClear();
                          });
                        } else {
                          MyDialog(context: context).normalDialog(
                              title: 'code ซ้ำ', subTitle: 'Code นี้มีแล้ว');
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Row newCenter({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
      ],
    );
  }

  Row buttonScanQrcode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: 200,
          child: InkWell(
            onTap: () async {
              try {
                var result = await scan();
                print('result ===> $result');

                await FirebaseFirestore.instance
                    .collection('product')
                    .where('codeScan', isEqualTo: result)
                    .get()
                    .then((value) {
                  if (value.docs.isEmpty) {
                    setState(() {
                      barCodeTextEditingController.text = result.toString();
                      codeScan = barCodeTextEditingController.text;
                    });
                  } else {
                    MyDialog(context: context).normalDialog(
                        title: 'สินค้าซ้ำ ?', subTitle: 'สินค้านี้มีแล้ว');
                  }
                });
              } catch (e) {}
            },
            child: const ShowImage(
              path: 'images/image1.png',
            ),
          ),
        ),
      ],
    );
  }

  void processClear() {
    barCodeTextEditingController.text = '';
    nameTextEditingController.text = '';
    priceTextEditingController.text = '';
    amountTextEditingController.text = '';
  }
}
