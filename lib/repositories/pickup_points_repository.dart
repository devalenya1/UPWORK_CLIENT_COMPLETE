import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/pickup_points_response.dart';

class PickupPointRepository{
  Future<PickupPointListResponse> getPickupPointListResponse()async{
    Uri url = Uri.parse('${AppConfig.BASE_URL}/pickup-list');

    final response = await http.get(url);

    print("response ${response.body}");

    return pickupPointListResponseFromJson(response.body);
  }
}