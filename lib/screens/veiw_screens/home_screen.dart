import 'package:booking_app_client/providers/main_provider.dart';
import 'package:booking_app_client/screens/veiw_screens/android_devices_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/device_details_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/ios_devices_screen.dart';
//import 'package:booking_app_client/screens/veiw_screens/others_devices_screen.dart';
import 'package:booking_app_client/screens/veiw_screens/pc_devices_screen.dart';
import 'package:booking_app_client/widgets_model/custom_text.dart';
import 'package:booking_app_client/widgets_model/device_item_view.dart';
import 'package:booking_app_client/widgets_model/gatecory_widget.dart';
import 'package:booking_app_client/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<CatergoryModel> categories = [
  //   CatergoryModel(
  //       name: 'Android', imageUrl: 'assets/images/category/android-96.png'),
  //   CatergoryModel(name: 'IOS', imageUrl: 'assets/images/category/ios-96.png'),
  //   CatergoryModel(name: 'PC', imageUrl: 'assets/images/category/laptop-96.png'),
  // ];

  bool _isSearch = false;
  TextEditingController? searchController = TextEditingController();
  @override
  void initState() {
    Provider.of<MainProvider>(context, listen: false).filterDevices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
          child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: _isSearch
                ? Consumer<MainProvider>(
                    builder: (context, value, child) => TextField(
                      autofocus: true,
                      controller: searchController,
                      onChanged: (val) {
                        setState(() {
                          value.searchList = value.devicesNotBookedList
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: " Search...",
                          border: InputBorder.none,
                          // errorBorder: InputBorder.none,
                          //focusedBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10)),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Text("Booking App Employee"),
            actions: [
              IconButton(
                  icon: _isSearch
                      ? Icon(Icons.cancel_outlined)
                      : Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearch = !_isSearch;
                      searchController!.clear();
                    });
                    Provider.of<MainProvider>(context, listen: false).searchList =
                        [];
                  })
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                CustomText(
                  text: 'Categories',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                Consumer<MainProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AndroidDevicesScreen())),
                        child: CategoryWidget(
                          text: value.categories[0].name,
                          imageUrl: value.categories[0].imageUrl,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IosDevicesScreen())),
                        child: CategoryWidget(
                          text: value.categories[1].name,
                          imageUrl: value.categories[1].imageUrl,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PcDevicesScreen())),
                        child: CategoryWidget(
                          text: value.categories[2].name,
                          imageUrl: value.categories[2].imageUrl,
                        ),
                      ),
                     // GestureDetector(
                       // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                         //   builder: (context) => OthersDevicesScreen())),
                        //child: CategoryWidget(
                         // text: value.categories[3].name,
                          //imageUrl: value.categories[3].imageUrl,
                        //),
                      //),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  text: 'Recent Add',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Consumer<MainProvider>(
                    builder: (context, value, child) => RefreshIndicator(
                      onRefresh:()=> value.refreshDevices(),
                                          child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            //mainAxisExtent: 200,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) => searchController!
                                .text.isNotEmpty
                            ? GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => DeviceDetailsScreen(
                                            deviceId: value.searchList[index].id))),
                                child: DeviceItemView(
                                    imageUrl: value.searchList[index].imageUrl[0],
                                    name: value.searchList[index].name,
                                    available: value.searchList[index].isBooked,
                                    screenSize: value.searchList[index].screenSize),
                              )
                            : GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => DeviceDetailsScreen(
                                            deviceId: value
                                                .devicesNotBookedList[index].id))),
                                child: DeviceItemView(
                                    imageUrl: value
                                        .devicesNotBookedList[index].imageUrl[0],
                                    name: value.devicesNotBookedList[index].name,
                                    available:
                                        value.devicesNotBookedList[index].isBooked,
                                    screenSize: value
                                        .devicesNotBookedList[index].screenSize),
                              ),
                        itemCount: searchController!.text.isNotEmpty
                            ? value.searchList.length
                            : value.devicesNotBookedList.length,
                      ),
                    ),
                  ),
                )
              ])),
          drawer: MainDrawer()),
    );
  }
}
