import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp/data/model/country_detail_model.dart';
import 'package:freecodecamp/state/country_detail_state/country_detail_notifier.dart';
import 'package:freecodecamp/state/country_detail_state/country_detail_state.dart';
import 'package:freecodecamp/ui/widgets/country_detail_widget.dart';
import 'package:freecodecamp/ui/widgets/error_widget.dart';

class Detail extends ConsumerStatefulWidget {
  const Detail({super.key,required this.name});

  final String name;

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

class _DetailState extends ConsumerState<Detail> {
  final countryDetailProvider = AutoDisposeNotifierProvider<CountryDetailNotifier,CountryDetailState> (
    ()=>CountryDetailNotifier()
  );
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      ref.read(countryDetailProvider.notifier).getCountry(widget.name.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final CountryDetailState countryDetailState = ref.watch(countryDetailProvider);
    return Scaffold(
      appBar: AppBar(title:  Text(widget.name),centerTitle: true,),
      body: switch(countryDetailState) {
        
        
        CountryDetailLoading() => Center(child: CircularProgressIndicator(),),
        
        CountryDetailSuccess(countryDetailModel: CountryDetailModel model) => CountryDetail(countryDetailModel: model),
       
        CountryDetailFailed(errorMessage: String errorMessage) => FailedWidget(errorMessage: errorMessage, tryAgain: (){

        }),
      },
    );
  }
}