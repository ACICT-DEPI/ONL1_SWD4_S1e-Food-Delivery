// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food_app/common/color_extension.dart';
import 'package:delivery_food_app/common_widget/round_button.dart';
import 'package:delivery_food_app/common_widget/round_textfield.dart';
import 'package:delivery_food_app/models/meals.model.dart';
import 'package:delivery_food_app/models/meals.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../common_widget/category_cell.dart';
import '../../common_widget/most_popular_cell.dart';
import '../../common_widget/popular_resutaurant_row.dart';
import '../../common_widget/recent_item_row.dart';
import '../../common_widget/view_all_title_row.dart';
import '../more/my_order_view.dart';
import 'dart:io';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<MenuItem> menuItems = [];
  bool isUploading = true;
  TextEditingController txtSearch = TextEditingController();
  @override
  void initState() {
    getMenuItems();
    super.initState();
  }

  Future<void> getMenuItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('menu').get();
    menuItems = querySnapshot.docs
        .map((e) => MenuItem.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    isUploading = false;
    setState(() {});
    print('menuItems: ${menuItems}');
  }

// Function to upload image and get its download URL

  List catArr = [
    {"image": "assets/img/cat_offer.png", "name": "Offers"},
    {"image": "assets/img/cat_sri.png", "name": "Sri Lankan"},
    {"image": "assets/img/cat_3.png", "name": "Italian"},
    {"image": "assets/img/cat_4.png", "name": "Indian"},
  ];

  List mostPopArr = [
    {
      "image": "assets/img/m_res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/m_res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];

  List recentArr = [
    {
      "image": "assets/img/item_1.png",
      "name": "Mulberry Pizza by Josh",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_2.png",
      "name": "Barita",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_3.png",
      "name": "Pizza Rush Hour",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good morning ${ServiceCall.userPayload[KKey.name] ?? ""}!",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        color: TColor.white,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // SizedBox(
              //   height: 120,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     itemCount: catArr.length,
              //     itemBuilder: ((context, index) {
              //       var cObj = catArr[index] as Map? ?? {};
              //       return CategoryCell(
              //         cObj: cObj,
              //         onTap: () {},
              //       );
              //     }),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Menu",
                  onView: () {},
                ),
              ),
              isUploading
                  ? CircularProgressIndicator(
                      color: TColor.primary,
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: menuItems.length,
                      itemBuilder: ((context, index) {
                        return PopularRestaurantRow(
                          name: menuItems[index].name,
                          imageUrl: menuItems[index].imageUrl,
                          rating: menuItems[index].rating,
                          category: menuItems[index].category,
                          price: menuItems[index].price,
                          description: menuItems[index].description,
                          onTap: () {},
                        );
                      }),
                    ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: ViewAllTitleRow(
              //     title: "Most Popular",
              //     onView: () {},
              //   ),
              // ),
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     itemCount: mostPopArr.length,
              //     itemBuilder: ((context, index) {
              //       var mObj = mostPopArr[index] as Map? ?? {};
              //       return MostPopularCell(
              //         mObj: mObj,
              //         onTap: () {},
              //       );
              //     }),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: ViewAllTitleRow(
              //     title: "Recent Items",
              //     onView: () {},
              //   ),
              // ),
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   itemCount: recentArr.length,
              //   itemBuilder: ((context, index) {
              //     var rObj = recentArr[index] as Map? ?? {};
              //     return RecentItemRow(
              //       rObj: rObj,
              //       onTap: () {},
              //     );
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

void uploadNewImage() async {
  // Pick an image from the gallery
  File? imageFile = await pickImage();

  if (imageFile == null) {
    print('No image selected.');
    return;
  }

  // Generate a unique name for the image, e.g., using a timestamp
  String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  // Upload the image and get the download URL
  String? imageUrl = await uploadImage(imageFile, imageName);

  if (imageUrl != null) {
    print('Image URL: $imageUrl');
    // You can now use this URL to save the image reference in your Firestore database.
  } else {
    print('Image upload failed.');
  }
}

Future<String?> uploadImage(File imageFile, String imageName) async {
  try {
    // Create a reference to the Firebase Storage
    Reference storageReference =
        FirebaseStorage.instance.ref().child('menu_images/$imageName');

    // Upload the file to the specified location
    UploadTask uploadTask = storageReference.putFile(imageFile);

    // Listen for upload progress
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(
          'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
    });

    // Wait until the upload completes
    TaskSnapshot snapshot = await uploadTask;

    // Get the download URL for the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();

    print('Image uploaded successfully: $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('No image selected.');
    return null;
  }
}

Future<void> addMenuItem(
    {required String name,
    required String description,
    required double price,
    required double rating,
    required String category,
    required File imageFile,
    required imageUrl}) async {
  // Generate a unique name for the image, e.g., using the name or a timestamp
  String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  // Upload the image and get the download URL
  // String? imageUrl = await uploadImage(imageFile, imageName);
  if (imageUrl == null) {
    print('Failed to upload image.');
    return;
  }

  // Create a MenuItem object
  MenuItem menuItem = MenuItem(
    name: name,
    imageUrl: imageUrl,
    description: description,
    price: price,
    rating: rating,
    category: category,
  );

  try {
    // Reference to the 'menu' collection in Firestore
    CollectionReference menuRef = FirebaseFirestore.instance.collection('menu');

    // Add the menu item to Firestore
    await menuRef.add(menuItem.toJson());
    print('Menu item added successfully.');
  } catch (e) {
    print('Error adding menu item: $e');
  }
}

void uploadNewItem() async {
  String name = 'Cold Brew Coffee';
  String description = 'Slow-steeped coffee served over ice.';
  double price = 3.49;
  double rating = 4.5;
  String category = 'Beverages';
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/ordersdelivery-403d3.appspot.com/o/menu_images%2FCold%20Brew%20Coffee.jpg?alt=media&token=e9f8e22e-ade5-41ca-aaa9-e19acd343049';
  File imageFile = File('path/to/your/image.jpg');

  await addMenuItem(
    name: name,
    description: description,
    price: price,
    rating: rating,
    category: category,
    imageFile: imageFile,
    imageUrl: imageUrl,
  );
}
