import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/place_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://tourism.api.opendatahub.com/v1/'));

  Future<List<PlaceModel>> fetchData(String type) async {
    try{
      String endpoint = '';
      if (type == 'accomodation') endpoint = 'Accommodation';
      else if (type == 'activity') endpoint = 'Activity';
      else endpoint = 'POI';

      final response = await _dio.get(endpoint, queryParameters: {
        'pagenumber': 1,
        'pagesize': 20,
      });

      List list = response.data['Items'];
      return list.map((json) => PlaceModel.fromJson(json)).toList();
    }catch (e){
      throw Exception('Erro ao carregar dados: $e');
    }
  }
}