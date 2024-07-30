import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:select_address/model/province_model.dart';

class ProvinceController extends GetxController {
  var provinces = <Data>[].obs;
  var selectedProvince = Data().obs;
  var districts = <Data2>[].obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    fetchProvinces();
    super.onInit();
  }

  void fetchProvinces() async {
    await _fetchData(
      'https://esgoo.net/api-tinhthanh/4/0.htm',
      onSuccess: (data) {
        provinces.value = data.map<Data>((e) => Data.fromJson(e)).toList();
      },
      onError: (error) {
        Get.snackbar('Error', 'Failed to fetch provinces: $error');
      },
    );
  }

  void setSelectedProvince(Data province) {
    selectedProvince.value = province;

    fetchDistricts(province.id ?? "");
  }

  void fetchDistricts(String provinceId) async {
    await _fetchData(
      'https://esgoo.net/api-tinhthanh/1/$provinceId.htm',
      onSuccess: (data) {
        districts.value = data.map<Data2>((e) => Data2.fromJson(e)).toList();
      },
      onError: (error) {
        Get.snackbar('Error', 'Failed to fetch districts: $error');
      },
    );
  }

  Future<void> _fetchData(
    String url, {
    required Function(List<dynamic>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data['data'];
        onSuccess(jsonResponse);
      } else {
        onError('Status code: ${response.statusCode}');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
