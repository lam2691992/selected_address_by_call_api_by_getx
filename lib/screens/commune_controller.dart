import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:select_address/model/commune_model.dart';

class CommuneController extends GetxController {
  var communes = <Data3>[].obs; // Danh sách xã/phường Data3
  var selectedCommune = Data3().obs; // Xã/phường đã chọn
  final Dio _dio = Dio();
void fetchCommunes(String districtId) async {
  print('Fetching communes for districtId: $districtId'); // Log
  await _fetchData(
    'https://esgoo.net/api-tinhthanh/3/$districtId.htm',
    onSuccess: (data) {
      print('Data fetched: $data'); // Log
      communes.value = data.map<Data3>((e) => Data3.fromJson(e)).toList();
    },
    onError: (error) {
      Get.snackbar('Error', 'Failed to fetch communes: $error');
    },
  );
}


void setSelectedCommune(Data3 commune) {
  selectedCommune.value = commune;
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
