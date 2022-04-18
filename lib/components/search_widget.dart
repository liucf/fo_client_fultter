import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        debugPrint("click search");
        Get.toNamed('/search');
      },
      icon: const Icon(Icons.search),
    );
  }
}
