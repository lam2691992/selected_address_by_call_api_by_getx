import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'commune_controller.dart';
import 'province_controller.dart';
import 'district_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final ProvinceController provinceController = Get.put(ProvinceController());
  final DistrictController districtController = Get.put(DistrictController());
  final CommuneController communeController = Get.put(CommuneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Column(
                            children: [
                              Icon(Icons.directions_car, size: 30),
                              Text('Vận chuyển',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(width: 40, height: 2, color: Colors.black),
                          const Column(
                            children: [
                              Icon(Icons.wallet_membership, size: 30),
                              Text('Thanh toán'),
                            ],
                          ),
                          Container(width: 40, height: 1, color: Colors.grey),
                          const Column(
                            children: [
                              Icon(Icons.check_box_sharp, size: 30),
                              Text('Xác nhận'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Họ và tên', style: TextStyle(fontSize: 17)),
                        SizedBox(width: 3),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Tên của bạn',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Số điện thoại'),
                        SizedBox(width: 3),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '+84',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Email'),
                        SizedBox(width: 3),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email của bạn',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text('Địa chỉ'),
                        SizedBox(width: 3),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Địa chỉ',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _showProvinceModalBottomSheet(context),
                      child: Obx(() {
                        return AbsorbPointer(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: provinceController
                                      .selectedProvince.value.name ??
                                  'Tỉnh/thành phố',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _showDistrictModalBottomSheet(context),
                      child: Obx(() {
                        return AbsorbPointer(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: districtController
                                      .selectedDistrict.value.name ??
                                  'Quận/huyện',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _showCommuneModalBottomSheet(context),
                      child: const AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Phường/xã',
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Container(
                        height: 40,
                        width: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 58, 157, 238)),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Tiếp tục'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProvinceModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 199, 220, 230),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      'Tỉnh/thành phố',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )),
                ],
              ),
            ),
            Obx(() {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: provinceController.provinces.length,
                  itemBuilder: (BuildContext context, int index) {
                    var province = provinceController.provinces[index];
                    return ListTile(
                      title: Text(province.name ?? ''),
                      onTap: () {
                        provinceController.setSelectedProvince(province);
                        districtController.fetchDistricts(province.id ?? '');
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }

  void _showDistrictModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 199, 220, 230),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      'Quận/huyện',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )),
                ],
              ),
            ),
            Obx(() {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: districtController.districts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var district = districtController.districts[index];
                    return ListTile(
                      title: Text(district.name ?? ''),
                      onTap: () {
                        districtController.setSelectedDistrict(district);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }

  void _showCommuneModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (
        BuildContext context,
      ) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 199, 220, 230),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      'Phường/xã',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ))
                ],
              ),
            ),
            Obx(() {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: communeController.communes.length,
                  itemBuilder: (BuildContext context, int index) {
                    var commune = communeController.communes[index];
                    return ListTile(
                      title: Text(commune.name ?? ''),
                      onTap: () {
                        communeController.setSelectedCommune(commune);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            })
          ],
        );
      },
    );
  }
}
