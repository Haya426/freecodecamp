  import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp/data/service/country_list_service.dart';
import 'package:freecodecamp/state/country_detail_state/country_detail_state.dart';

import '../../data/model/country_detail_model.dart';

class CountryDetailNotifier extends AutoDisposeNotifier<CountryDetailState> {
  final _countryService = CountryService();

  @override
  CountryDetailState build() {
    return CountryDetailLoading();
  }
void getCountry(String name) async{
try{
  state = CountryDetailLoading();
  final CountryDetailModel country = await _countryService.getCounry(name);
  state = CountryDetailSuccess(country);
} catch (e) {
state = CountryDetailFailed(e.toString());
}
}
}