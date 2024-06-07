import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/custom_settings_list_tile.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Settings',
            style: appBarTitleStyle,
          ),
          automaticallyImplyLeading: true,
          // backgroundColor: kPrimaryColor,
        ),
        body: Column(
          children: [
            customSettingsListTile(
                onTap: () {},
                leading: const Icon(Icons.doorbell_outlined),
                title: "Notifiacation",
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            customSettingsListTile(
                onTap: () {},
                leading: const Icon(Icons.privacy_tip_outlined),
                title: "Privacy Policies",
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            customSettingsListTile(
                onTap: () {},
                leading: const Icon(Icons.info_outline),
                title: "About us",
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            customSettingsListTile(
                onTap: () async {
                  showConfirmationDialog(
                    context: context,
                    title: 'Log out!',
                    content: 'Are you sure..?',
                    confirmButtonText: "confirm",
                    cancelButtonText: "cancel",
                    onConfirm: () async {
                      await clearUserSession();
                      await googleSignOut();
                      currentPage.value = 0;
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ScreenLogin();
                          }),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  );
                },
                leading: const Icon(Icons.logout),
                title: "Logout",
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ))
          ],
        ));
  }
}
