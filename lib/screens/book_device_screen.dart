import 'package:booking_app_client/models/device_model.dart';
import 'package:booking_app_client/providers/main_provider.dart';
import 'package:booking_app_client/screens/veiw_screens/home_screen.dart';
import 'package:booking_app_client/widgets_model/custom_elevated_button.dart';
import 'package:booking_app_client/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BookDeviceScreen extends StatefulWidget {
  final String deviceId;

  BookDeviceScreen({
    Key? key,
    required this.deviceId,
  }) : super(key: key);

  @override
  _BookDeviceScreenState createState() => _BookDeviceScreenState();
}

class _BookDeviceScreenState extends State<BookDeviceScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffold = GlobalKey();
  late DeviceModel deviceModel;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    deviceModel = Provider.of<MainProvider>(context, listen: false)
        .findDeviceById(widget.deviceId);
  }

  void bookDevice(BuildContext context, MainProvider value) async {
    if (value.startDateTime == null || value.endDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a date'),
        backgroundColor: Colors.black54,
      ));
    } else {
      isLoading = true;
      await Provider.of<MainProvider>(context, listen: false)
          .bookDevice(deviceModel)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The device has been booked')));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Book Device'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<MainProvider>(
          builder: (context, value, child) => Column(
            children: [
              Container(
                  height: 275,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    deviceModel.imageUrl[0],
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomText(
                      text: deviceModel.name,
                      fontSize: 20,
                      color: KPrimaryColor,
                    ),
                    CustomText(
                      text: 'Type: ' + deviceModel.type,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'Model: ' + deviceModel.model,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'OS: ' + deviceModel.os,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'ScreenSize: ' + deviceModel.screenSize,
                      color: Colors.grey,
                    ),
                    CustomText(
                      text: 'Battery: ' + deviceModel.battery,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () => showDatePicker(
                                    context: context,
                                    initialDate: value.startDateTime == null
                                        ? DateTime.now()
                                        : value.startDateTime!,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050))
                                .then((date) {
                              if (date == null) return;
                              value.changeStartDateTime(date);
                            }),
                        icon: Icon(Icons.date_range),
                        label: CustomText(
                          text: 'From',
                        )),
                    CustomText(
                        color: KPrimaryColor,
                        text: value.startDateTime == null
                            ? ''
                            : DateFormat()
                                .add_yMd()
                                .format(value.startDateTime!)
                                .toString())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () => showDatePicker(
                                    context: context,
                                    initialDate: value.endDateTime == null
                                        ? DateTime.now()
                                        : value.endDateTime!,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050))
                                .then((date) {
                              if (date == null) return;
                              value.changeEndDateTime(date);
                            }),
                        icon: Icon(Icons.date_range),
                        label: CustomText(
                          text: 'To',
                        )),
                    CustomText(
                        color: KPrimaryColor,
                        text: value.endDateTime == null
                            ? ''
                            : DateFormat()
                                .add_yMd()
                                .format(value.endDateTime!)
                                .toString())
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomElevatedButton(
                        text: 'Book',
                        onPressed: () => bookDevice(context, value),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
