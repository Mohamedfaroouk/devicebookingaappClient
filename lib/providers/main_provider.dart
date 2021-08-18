import 'package:booking_app_client/constants.dart';
import 'package:booking_app_client/models/category_model.dart';
import 'package:booking_app_client/models/device_model.dart';
import 'package:booking_app_client/models/reserve_device_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  List<DeviceModel> allDevicesList = [
    // DeviceModel(
    //     id: '1',
    //     name: 'Samsung Note 10',
    //     model: 'Note 10',
    //     os: 'Android Pie',
    //     type: 'ANDROID',
    //     screenSize: '6 inch',
    //     isBooked: true,
    //     battery: '5000 mA',
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/Samsung-Galaxy-Note10-Duos-256GB-Pre-owned-Good-condition-Aura-Black-14042020-01-p.jpg'
    //     ]),
    // DeviceModel(
    //     id: '2',
    //     name: 'Huawei Mate 10',
    //     model: 'Mate 10',
    //     os: 'Android Marshmelo',
    //     type: 'ANDROID',
    //     screenSize: '6 inch',
    //     isBooked: false,
    //     battery: '3330 mA',
    //     imageUrl: [
    //       'https://images-na.ssl-images-amazon.com/images/I/51uAjhBSzOL._AC_SX522_.jpg'
    //     ]),
    // DeviceModel(
    //     id: '3',
    //     name: 'Samsung A50',
    //     model: 'A50',
    //     os: 'Android Pie',
    //     type: 'ANDROID',
    //     isBooked: false,
    //     screenSize: '6 inch',
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/Original-Samsung-Galaxy-A50-Gradation-Cover-EF-AA505CBEGWW-Black-8801643776848-22042019-01-p.jpg'
    //     ],
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '4',
    //     name: 'Iphone X',
    //     model: 'X',
    //     os: 'IOS 10',
    //     type: 'IOS',
    //     isBooked: false,
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/iPhone-X-XS-Fake-Camera-Sticker-Black-05122019-01-p.jpg',
    //       'https://www.tjara.com/wp-content/uploads/2021/04/temp1618662955_1903984948.jpg',
    //       'https://cdn.alloallo.media/catalog/product/apple/iphone/iphone-x/iphone-x-space-gray.jpg'
    //     ],
    //     screenSize: '6 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '5',
    //     name: 'Iphone 9',
    //     model: '9',
    //     os: 'IOS 9',
    //     type: 'IOS',
    //     isBooked: false,
    //     screenSize: '6 inch',
    //     imageUrl: [
    //       'https://fdn.gsmarena.com/imgroot/news/20/01/iphone-9-renders/-727/gsmarena_005.jpg'
    //     ],
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '6',
    //     name: 'HP 110',
    //     model: '110',
    //     os: 'Windows 10',
    //     type: 'PC',
    //     isBooked: false,
    //     imageUrl: ['https://www.notebookcheck.net/uploads/tx_nbc2/hp110.jpg'],
    //     screenSize: '15 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '7',
    //     name: 'Lenovo 120',
    //     model: '120',
    //     os: 'Windows 10',
    //     type: 'PC',
    //     isBooked: true,
    //     imageUrl: [
    //       'https://www.notebookcheck.net/uploads/tx_nbc2/1204810_10.jpg'
    //     ],
    //     screenSize: '15 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '8',
    //     name: 'Huawei 3G/4G LTE',
    //     model: 'E589u',
    //     os: 'android',
    //     type: 'OTHERS',
    //     isBooked: false,
    //     imageUrl: [
    //       'https://www-konga-com-res.cloudinary.com/w_auto,f_auto,fl_lossy,dpr_auto,q_auto/media/catalog/product/N/a/59917_1516110926.jpg'
    //     ],
    //     screenSize: '3 inch',
    //     battery: '5000 mA'),
  ];
  List<CatergoryModel> categories = [
    // CatergoryModel(
    //     name: 'Android',
    //     imageUrl:
    //         'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fandroid96.png?alt=media&token=04dfd03d-2494-48f9-95fe-1f1af390f2c7'),
    // CatergoryModel(
    //     name: 'IOS',
    //     imageUrl:
    //         'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fios-96.png?alt=media&token=9fdeb72c-e35e-4d29-a78e-305361fb0b3d'),
    // CatergoryModel(
    //     name: 'PC',
    //     imageUrl:
    //         'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fpc-96.png?alt=media&token=30326472-db66-4374-aa8e-153bef4587a7'),
    // CatergoryModel(
    //     name: 'Others',
    //     imageUrl:
    //         'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fothers-96.png?alt=media&token=b95ea046-d22c-46c5-b782-a17303832320'),
  ];
  List<DeviceModel> devicesNotBookedList = [];
  List<DeviceModel> androidDevicesList = [];
  List<DeviceModel> iosDevicesList = [];
  List<DeviceModel> pcDevicesList = [];
  List<DeviceModel> othersDevicesList = [];
  List<dynamic> searchList = [];

  List<ReserveDeviceModel> reservedDevicesList = [
    // ReserveDeviceModel(
    //     id: '1',
    //     deviceName: 'Samsung Note 10',
    //     userId: '1',
    //     type: 'ANDROID',
    //     startDate: '01/07/2021',
    //     endDate: '20/07/2021'),
    // ReserveDeviceModel(
    //     id: '2',
    //     deviceName: 'Huawei Mate 10',
    //     userId: '2',
    //     type: 'ANDROID',
    //     startDate: '01/07/2021',
    //     endDate: '20/07/2021'),
  ];

  DateTime? startDateTime;
  DateTime? endDateTime;

  void changeStartDateTime(DateTime date) {
    startDateTime = date;
    notifyListeners();
  }

  void changeEndDateTime(DateTime date) {
    endDateTime = date;
    notifyListeners();
  }

  Future filterDevices() async {
    allDevicesList.forEach((device) {
      //filter devices by reservation
      if (device.isBooked == false) {
        var isExest = devicesNotBookedList.indexWhere(
          (element) => element.id == device.id,
        );
        if (isExest == -1) {
          devicesNotBookedList.add(device);
        }
      }

      //filter devices by type
      if (device.type == 'Android' && device.isBooked == false) {
        var isExest = androidDevicesList.indexWhere(
          (element) => element.id == device.id,
        );
        if (isExest == -1) {
          androidDevicesList.add(device);
        }
      } else if (device.type == 'IOS' && device.isBooked == false) {
        var isExest =
            iosDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          iosDevicesList.add(device);
        }
      } else if (device.type == 'pc' && device.isBooked == false) {
        var isExest =
            pcDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          pcDevicesList.add(device);
        }
      } else if (device.type == 'OTHERS' && device.isBooked == false) {
        var isExest =
            othersDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          othersDevicesList.add(device);
        }
      }
    });
  }

  DeviceModel findDeviceById(String id) {
    return allDevicesList.firstWhere((element) => element.id == id);
  }

  Future refreshDevices() async {
    getdevices();
    await filterDevices();
    notifyListeners();
  }

  Future bookDevice(DeviceModel id) async {
    print('the device is booked');

    FirebaseFirestore.instance
        .collection("categories")
        .doc(id.type)
        .collection("devices")
        .where("name", isEqualTo: id.name)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({"isBooked": true});
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("mydevises")
        .doc(id.id)
        .set(ReserveDeviceModel(
                id: id.id,
                deviceName: id.name,
                userId: user.email,
                type: id.type,
                startDate: startDateTime.toString(),
                endDate: endDateTime.toString())
            .toMap());

    reservedDevicesList.add(ReserveDeviceModel(
        id: id.id,
        deviceName: id.name,
        userId: user.email,
        type: id.type,
        startDate: startDateTime.toString(),
        endDate: endDateTime.toString()));
    startDateTime = null;
    endDateTime = null;
    allDevicesList.removeWhere((device) => device.id == id.id);
    devicesNotBookedList.removeWhere((device) => device.id == id.id);
    refreshDevices();

    notifyListeners();
  }

  Future unBookedDevice(ReserveDeviceModel id) async {
    reservedDevicesList.removeWhere((device) => device.id == id.id);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("mydevises")
        .doc(id.id)
        .delete();
    FirebaseFirestore.instance
        .collection("categories")
        .doc(id.type)
        .collection("devices")
        .where("name", isEqualTo: id.deviceName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({"isBooked": false});

        refreshDevices();
        print(allDevicesList.last.name);
        notifyListeners();
      });
    });
    refreshDevices();

    notifyListeners();
  }

  void getdevices() {
    allDevicesList = [];
    FirebaseFirestore.instance
        .collection("categories")
        .doc("Android")
        .collection("devices")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allDevicesList.add(DeviceModel.fromMap(element.data()));
      });
    });
    FirebaseFirestore.instance
        .collection("categories")
        .doc("pc")
        .collection("devices")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allDevicesList.add(DeviceModel.fromMap(element.data()));
      });
    });
    FirebaseFirestore.instance
        .collection("categories")
        .doc("IOS")
        .collection("devices")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allDevicesList.add(DeviceModel.fromMap(element.data()));
      });
    });
    notifyListeners();
  }

  void getcategory() {
    FirebaseFirestore.instance.collection("categories").get().then((value) {
      value.docs.forEach((element) {
        categories.add(CatergoryModel.fromMap(element.data()));

        // print(categoryTypeList);
      });
    });
    notifyListeners();
  }

  void getmymydevises() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("mydevises")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        reservedDevicesList.add(ReserveDeviceModel.fromMap(element.data()));

        // print(categoryTypeList);
      });
    });
    notifyListeners();
  }
}
