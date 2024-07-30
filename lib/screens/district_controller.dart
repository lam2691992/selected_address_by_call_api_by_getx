import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:select_address/model/district_model.dart';

class DistrictController extends GetxController {
  var districts = <Data2>[].obs; // Danh sách quận/huyện (Data2)
  var selectedDistrict = Data2().obs; // Quận/huyện đã chọn
  final Dio _dio = Dio();

  void fetchDistricts(String provinceId) async {
   
    await _fetchData(
      'https://esgoo.net/api-tinhthanh/2/$provinceId.htm',
      onSuccess: (data) {
        districts.value = data.map<Data2>((e) => Data2.fromJson(e)).toList();
      },
      onError: (error) {
        Get.snackbar('Error', 'Failed to fetch districts: $error');
      },
    );
  }

  void setSelectedDistrict(Data2 district) {
     districts.clear(); 
    selectedDistrict.value = district;
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
