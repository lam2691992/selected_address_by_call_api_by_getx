import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:select_address/model/district_model.dart';

class DistrictController extends GetxController {
  var districts = <Data2>[].obs; // Danh sách quận/huyện (Data2)
  var selectedDistrict = Data2().obs; // Quận/huyện đã chọn
  final Dio _dio = Dio();
  final String apiUrl = 'https://esgoo.net/api-tinhthanh/2'; // URL của API

  @override
  void onInit() {
    super.onInit();
  }

  // Hàm để tải danh sách quận/huyện
void fetchDistricts(String provinceId) async {
  try {
    final response = await _dio.get('$apiUrl/$provinceId.htm');
    if (response.statusCode == 200) {
      final districtModel = DistrictModel.fromJson(response.data);
      if (districtModel.data != null) {
        var province = districtModel.data!.firstWhere(
            (element) => element.id == provinceId,
            orElse: () => Data(id: ''));
        if (province.data2 != null && province.data2!.isNotEmpty) {
          districts.value = province.data2!;
        } else {
          districts.clear();
          Get.snackbar('Thông báo', 'Không có dữ liệu quận/huyện');
        }
      }
    }
  } catch (e) {
    if (e is DioException) {
      Get.snackbar('Lỗi', 'Không thể tải dữ liệu quận/huyện: ${e.message}');
    } else {
      Get.snackbar('Lỗi', 'Có lỗi xảy ra khi tải dữ liệu quận/huyện: $e');
    }
  }
}
  void setSelectedDistrict(Data2 district) {
    selectedDistrict.value = district;
  }
}