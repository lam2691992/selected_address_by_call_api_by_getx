import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:select_address/model/province_model.dart';

class ProvinceController extends GetxController {
  var provinces = <Data>[].obs;
  var selectedProvince = Data().obs;
  var districts = <Data>[].obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    fetchProvinces();
    super.onInit();
  }

  void fetchProvinces() async {
    try {
      final response =
          await _dio.get('https://esgoo.net/api-tinhthanh/4/0.htm');
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data['data'];
        provinces.value = jsonResponse.map((e) => Data.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch provinces');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch provinces: $e');
    }
  }

  void setSelectedProvince(Data province) {
    selectedProvince.value = province;
    fetchDistricts(province.id ?? "");
  }

  void fetchDistricts(String provinceId) async {
    try {
      final response =
          await _dio.get('https://esgoo.net/api-tinhthanh/1/$provinceId.htm');
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data['data'];
        districts.value = jsonResponse.map((e) => Data.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch districts');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch districts: $e');
    }
  }
}