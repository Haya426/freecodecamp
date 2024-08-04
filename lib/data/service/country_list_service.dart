import 'package:dio/dio.dart';
import 'package:freecodecamp/data/model/country_detail_model.dart';
import '../../const/api_const.dart';
import '../model/country_list_model.dart';

class CountryService{
  final Dio _dio = Dio();

  Future<List<CountryListModel>> getCountryList() async{
    Uri uri = Uri.parse('${ApiConst.baseUrl}${ApiConst.all}?fields=name,region,flags');
    final response = await _dio.getUri(uri);
    return (response.data as List).map((data){
      return CountryListModel.fromJson(data);
    }).toList();
  }

  Future<CountryDetailModel> getCounry(String name) async{
    Uri uri= Uri.parse('${ApiConst.baseUrl}${ApiConst.detail}/$name?fullText=true&fields=name,capital,flags,region,subregion,population');
    final response = await _dio.getUri(uri);

    final detailList= (response.data as List).map((country) => CountryDetailModel.fromJson(country)).toList();
    return detailList[0];
  }

}