import '../services/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadListAgents() {
    return BaseNetwork.get("https://valorant-api.com/v1/agents");
  }

  Future<Map<String, dynamic>> getDetailAgent(String? id) {
    return BaseNetwork.get("https://valorant-api.com/v1/agents/${id}");
  }
}
