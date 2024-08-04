import 'package:freecodecamp/data/model/country_detail_model.dart';

sealed class CountryDetailState{}

class CountryDetailLoading extends CountryDetailState{}

class CountryDetailSuccess extends CountryDetailState {
  final CountryDetailModel countryDetailModel;
  CountryDetailSuccess(this.countryDetailModel);
}
class CountryDetailFailed extends CountryDetailState {
  final String errorMessage;
  CountryDetailFailed(this.errorMessage);
}
