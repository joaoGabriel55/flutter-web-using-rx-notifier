import 'package:dio/dio.dart';
import 'package:flutter_web_app/src/domain/apollo_eleven.dart';
import 'package:flutter_web_app/src/infra/api.dart';

class HomeService {
  Future<List<ApolloEleven>> getApolloElevenImages() async {
    API api = new API();
    Response response = await api.getInstance().get(
        '/search?q=apollo%2011&description=moon%20landing&media_type=image');

    List<dynamic> items = response.data['collection']['items'];
    List<Map<String, dynamic>> jsonCollection = [];
    for (var item in items) {
      Map<String, dynamic> json = new Map();
      dynamic data = item['data'][0];
      json['title'] = data['title'];
      json['description'] = data['description'];
      json['location'] = data['location'];
      json['imageUrl'] = item['links'][0]['href'];
      jsonCollection.add(json);
    }

    List<ApolloEleven> apolloImages = jsonCollection.map((json) {
      ApolloEleven apolloEleven = new ApolloEleven.fromJson(json);
      print(apolloEleven);
      return apolloEleven;
    }).toList();

    return apolloImages;
  }
}
