import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/country_list_model.dart';
import '../../data/service/country_list_service.dart';
import 'country_list_state.dart';

class CountryListNotifier extends Notifier<CountryListState> {
  final CountryService _countryService = CountryService();
  @override
  CountryListState build() {
    return CountryListLoading();
  }

  void getCountryList () async{
    state = CountryListLoading();
    try {
          state = CountryListLoading();
          final List<CountryListModel> countryList = await _countryService.getCountryList();
          state = CountryListSuccess(countryList);

    } catch(e){
      state = CountryListFailed(e.toString());
    }
  }
}