import 'package:flutter/material.dart';
import 'package:fo/controllers/search_controller.dart';
import 'package:fo/models/fojing.dart';
import 'package:fo/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchController searchController = Get.find();

  List<Widget> buildTags(searchTextController) {
    List<Widget> tags = <Widget>[];
    for (int i = searchController.historyList.length - 1; i >= 0; i--) {
      tags.add(
          createTag(i, searchController.historyList[i], searchTextController));
    }
    return tags;
  }

  Widget createTag(
      int index, String tagTitle, TextEditingController searchTextController) {
    // return Obx(() {
    return InkWell(
      onTap: () {
        debugPrint("click tag " + tagTitle);
        searchController.keyword.value = tagTitle;
        searchTextController.text = tagTitle;
        searchController.search();
      },
      child: Chip(backgroundColor: yellow, label: Text(tagTitle)),
    );
    // });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("search").tr(),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: searchTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: searchController.keyword.value == ""
                        ? tr('searchhint')
                        : searchController.keyword.value.toString(),
                    suffixIcon:
                        searchController.keyword.value.toString().trim() != ''
                            ? IconButton(
                                onPressed: () {
                                  searchController.keyword.value = "";
                                  searchController.resultList.value = [];
                                  searchTextController.text = "";
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                  ),
                  onChanged: (value) {
                    searchController.keyword.value = value;
                  },
                  onSubmitted: (value) {
                    if (searchTextController.text.trim() == "") {
                      return;
                    }
                    searchController.search();
                  }),
            ),
            searchController.resultList.isEmpty
                ? searchController.isLoading.isTrue
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: width,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0, // Underline width
                              ))),
                              child: const Text('History Search').tr(),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 15.0,
                                    direction: Axis.horizontal,
                                    children: buildTags(searchTextController),
                                  ),
                                ))
                          ],
                        ),
                      )
                : Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: searchController.resultList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      FojingElement.fromJson(searchController
                                              .resultList[index])
                                          .name,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                  const Icon(Icons.play_arrow),
                                ],
                              ),
                            ),
                            onTap: () => Get.toNamed('player', parameters: {
                              "albumid": FojingElement.fromJson(
                                      searchController.resultList[index])
                                  .albumId
                                  .toString(),
                              "playid": FojingElement.fromJson(
                                      searchController.resultList[index])
                                  .id
                                  .toString()
                            }),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  )
          ],
        );
      }),
    );
  }
}
