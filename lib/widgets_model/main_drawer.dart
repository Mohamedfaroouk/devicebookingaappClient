import 'package:booking_app_client/screens/Profile_screen.dart';
import 'package:booking_app_client/screens/my_reserved_devices_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/all_devices_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/home_screen.dart';
import 'package:booking_app_client/widgets_model/custom_list_tile.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text("Booking App Employee"),
              automaticallyImplyLeading: true,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.menu)),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),
              title: 'Available devices',
              leading: Icon(Icons.devices),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AllDevicesScreen())),
              title: 'All devices',
              leading: Icon(Icons.apps),
            ),
            Divider(),
            // CustomListTile(
            //   onTap: () => Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //           builder: (context) => AndroidDevicesScreen())),
            //   title: 'Adnroid Devices',
            //   leading: Icon(Icons.android),
            // ),
            // CustomListTile(
            //   onTap: () => Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => IosDevicesScreen())),
            //   title: 'IOS Devices',
            //   leading: Icon(Icons.phone_android),
            // ),
            // CustomListTile(
            //   onTap: () => Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => PcDevicesScreen())),
            //   title: 'PC Devices',
            //   leading: Icon(Icons.computer),
            // ),
            // Divider(),
            CustomListTile(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => MyReservedDevicesScreen())),
                title: 'My Reserved Devices',
                leading: Icon(Icons.mobile_friendly)),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen())),
              title: 'Profile',
              leading: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
