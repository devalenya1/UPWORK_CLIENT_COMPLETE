import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/addons_response.dart';

class AddonsRepository{
Future<List<AddonsListResponse>> getAddonsListResponse() async{
  Uri url = Uri.parse('${AppConfig.BASE_URL}/addon-list');

  final response = await http.get(url);
  print("adons ${response.body}");
  return addonsListResponseFromJson(response.body);
}
}