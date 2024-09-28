import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../../core/model/ui_model/category_model.dart';
import '../../../../../../core/widgets/custom_image.dart';
import '../../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';

class TagPeopleScreen extends StatelessWidget {
  TagPeopleScreen({super.key});

  late final List<CommonUIModel> listOfPeople = [
    CommonUIModel(
        title: "Joey Tribbiani",
        image:
            "https://i.guim.co.uk/img/media/ae14333615408ab5d5ba6c23810be683e0d6f631/389_282_1481_889/master/1481.jpg?width=620&dpr=1&s=none"),
    CommonUIModel(
      title: "Rachel Green",
      image: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    CommonUIModel(
      title: "Ross Geller",
      image: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    CommonUIModel(
      title: "Monica Geller",
      image: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    CommonUIModel(
      title: "Chandler Bing",
      image: "https://randomuser.me/api/portraits/men/4.jpg",
    ),
    CommonUIModel(
      title: "Phoebe Buffay",
      image: "https://randomuser.me/api/portraits/women/5.jpg",
    ),
    CommonUIModel(
      title: "Joey Tribbiani",
      image: "https://randomuser.me/api/portraits/men/6.jpg",
    ),
    CommonUIModel(
      title: "Janice Hosenstein",
      image: "https://randomuser.me/api/portraits/women/7.jpg",
    ),
    CommonUIModel(
      title: "Gunther",
      image: "https://randomuser.me/api/portraits/men/8.jpg",
    ),
    CommonUIModel(
      title: "Emily Waltham",
      image: "https://randomuser.me/api/portraits/women/9.jpg",
    ),
    CommonUIModel(
      title: "Richard Burke",
      image: "https://randomuser.me/api/portraits/men/10.jpg",
    ),
    CommonUIModel(
      title: "Judy Geller",
      image: "https://randomuser.me/api/portraits/women/11.jpg",
    ),
    CommonUIModel(
      title: "Mike Hannigan",
      image: "https://randomuser.me/api/portraits/men/12.jpg",
    ),
    CommonUIModel(
      title: "Erica Bing",
      image: "https://randomuser.me/api/portraits/women/13.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.tagPeople,
          style: fontStyleSemiBold17.apply(
            color: Theme.of(context).colorScheme.textColor,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          iconSize: Dimensions.w28,
          icon: CustomSvgAssetImage(
            image: ImageAsset.icBackArrowNav,
            width: Dimensions.w28,
            height: Dimensions.h28,
            color: Theme.of(context).colorScheme.textColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(bottom: Dimensions.h10),
            child: SearchBarTextBoxField(
              height: Dimensions.h35,
              bgColor: Theme.of(context).colorScheme.textFieldColor,
              textController: Get.put(TextEditingController()),
              topLeftRadius: Dimensions.r20,
              topRightRadius: Dimensions.r20,
              bottomLeftRadius: Dimensions.r20,
              bottomRightRadius: Dimensions.r20,
              onChanged: (val) {},
              afterClearButton: () {},
              prefixIcon: const SizedBox(),
              hintText: AppString.searchPeople,
              hintTextColor: Theme.of(context).colorScheme.textColor,
              suffixIcon: CustomSvgAssetImage(
                image: ImageAsset.icSearch,
                height: Dimensions.w30,
                width: Dimensions.w30,
                color: Theme.of(context).colorScheme.textColor,
              ),
            ),
          ),

          // People List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen,
                    vertical: Dimensions.h5),
                leading: MyCircleNetworkImage(
                  image: listOfPeople[index].image!,
                  radius: Dimensions.r25,
                ),
                title: Text(
                  listOfPeople[index].title,
                  style: fontStyleSemiBold14.apply(
                      color: Get.theme.colorScheme.textColor),
                )),
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: Dimensions.commonPaddingForScreen),
              child: Container(
                color: ColorConst.dividerColor,
                height: Get.height * 0.0001,
              ),
            ),
            itemCount: listOfPeople.length,
          )
        ],
      )),
    );
  }
}
