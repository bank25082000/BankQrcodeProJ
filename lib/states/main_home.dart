import 'package:bankqrcodeproj/states/add_product.dart';
import 'package:bankqrcodeproj/states/all_product.dart';
import 'package:bankqrcodeproj/states/cart_product.dart';
import 'package:bankqrcodeproj/states/history_item.dart';
import 'package:bankqrcodeproj/states/history_product.dart';
import 'package:bankqrcodeproj/states/scan_product.dart';
import 'package:bankqrcodeproj/utility/my_constant.dart';
import 'package:bankqrcodeproj/widgets/show_image.dart';
import 'package:bankqrcodeproj/widgets/show_text.dart';
import 'package:bankqrcodeproj/widgets/show_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var user = FirebaseAuth.instance.currentUser;
  String? emailUser;

  var titles = <String>[
    'สแกนสินค้า',
    'ตะกร้าสินค้า',
    'สินค้าทั้งหมด',
    'เพิ่มสินค้า',
    'ประวัติทำรายการ',
    'ประวัติสินค้า',
  ];

  var pathImages = <String>[
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
    'images/image5.png',
    'images/image6.png',
  ];
  var widgets = <Widget>[
    const ScanProduct(),
    const CartProduct(),
    const AllProduct(),
    const AddProduct(),
    const HistoryItem(),
    const HistoryProduct(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  void findUser() {
    setState(() {
      emailUser = user!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.white,
      appBar: newAppBar(context),
      body: ListView(
        children: [
          showTitle(),
          GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: titles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widgets[index],
                  ),
                );
              },
              child: Card(
                color: MyConstant.light,
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      child: ShowImage(
                        path: pathImages[index],
                      ),
                    ),
                    ShowText(
                      text: titles[index],
                      textStyle: MyConstant().h3Style(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ShowText showTitle() {
    return ShowText(
      text: 'Menu:',
      textStyle: MyConstant().h1Style(),
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.account_circle_outlined,
            color: MyConstant.dark,
          ),
          const SizedBox(
            width: 4,
          ),
          ShowText(
            text: emailUser ?? '',
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: MyConstant.white,
      actions: [
        ShowTextButton(
          label: 'Sign Out',
          pressFunc: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/authen', (route) => false);
            });
          },
        )
      ],
    );
  }
}
