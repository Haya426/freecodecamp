
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freecodecamp/data/model/country_list_model.dart';
import 'package:go_router/go_router.dart';

class CountryListView extends StatelessWidget {
  const CountryListView({super.key,required this.countryList});
  final List<CountryListModel> countryList;

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        final CountryListModel countryModel = countryList[index];
        final String? flaglink = countryModel.flags?.png;
        return InkWell(
          onTap: (){
            if(kIsWeb)
            context.go("/name/${countryModel.name?.common}");
            else context.push("/name/${countryModel.name?.common}");

          },
          child: Card(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(flaglink !=null)
                    Image.network(flaglink,width: 100,height: 100,),
                    Text(countryModel.name?.common??'')
                  ],
                ),
              ),
              Text(countryModel.region ?? ''),
              SizedBox(height: 8,)
             
            ],),
          ),
        );
      },);
  }
}