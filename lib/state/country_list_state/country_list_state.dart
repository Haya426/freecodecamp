

import '../../data/model/country_list_model.dart';

sealed class CountryListState {}

class CountryListLoading extends CountryListState{}

class CountryListSuccess extends CountryListState{
  final List<CountryListModel> countryList;

  CountryListSuccess(this.countryList);
}

class CountryListFailed extends CountryListState{
  final String errorMessage;

  CountryListFailed(this.errorMessage);
}
