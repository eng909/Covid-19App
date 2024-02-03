import 'dart:convert';

import 'package:covid19trackerapp/Services/Utilities/app_url.dart';
import 'package:covid19trackerapp/Model/WorldStatesModel.dart';
import 'package:covid19trackerapp/View/countries_list.dart';
import 'package:http/http.dart'as http;
class StatesServices{
  Future<WorldStatesModel> fecthWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(json);
    }else{
      throw Exception('error');
    }
  }

  Future<List<dynamic>> CountriesListApi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }
  }
}