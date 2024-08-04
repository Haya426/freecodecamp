  import 'package:flutter/material.dart';
import 'package:freecodecamp/data/model/country_detail_model.dart';

class CountryDetail extends StatelessWidget {
  const CountryDetail({super.key,required this.countryDetailModel});
  final CountryDetailModel countryDetailModel;
  @override
  Widget build(BuildContext context) {
    final flagLink = countryDetailModel.flags?.png;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Common Name'),
              trailing: Text(countryDetailModel.name?.common??""),
            ),
            ListTile(
              title: Text('Official Name'),
              trailing: Text(countryDetailModel.name?.official??""),
            ),
            ListTile(
              title: Text('Population'),
              trailing: Text(countryDetailModel.population.toString()),
            ),
            ListTile(
              title: Text('Region'),
              trailing: Text(countryDetailModel.region??""),
            ),
            ListTile(
              title: Text('Sub Region'),
              trailing: Text(countryDetailModel.subregion??""),
            ),
            if(flagLink != null)
            Image.network(flagLink)
          ],
        ),
      ),
    );
  }
}