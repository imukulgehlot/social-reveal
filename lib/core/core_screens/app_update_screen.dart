import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';

import '../basic_features.dart';
import '../widgets/custom_appbar.dart';

class ForceUpdateScreen extends StatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  State<ForceUpdateScreen> createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: CustomAppBar.blankAppbar(),
          body: Container(
            padding: EdgeInsets.all(Dimensions.w20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimensions.w180,
                  height: Dimensions.w180,
                  child: Image.asset(ImageAsset.icForceUpdate),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Dimensions.w15),
                  child: Text(AppString.forceUpdate, style: fontStyleRegular14),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Dimensions.w15),
                  child: Text(AppString.forceUpdateMessage,
                      textAlign: TextAlign.center, style: fontStyleBold12),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: Dimensions.w15),
                    child: MyButton(
                      onPressed: () async {
                        OpenStore.instance.open(
                            androidAppBundleId: AppUtils.packageName,
                            appStoreId: AppUtils.packageName);
                      },
                      title: AppString.forceUpdateBtnText,
                    ))
              ],
            ),
          ),
        ));
  }
}
