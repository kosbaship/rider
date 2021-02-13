import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/network/api_provider.dart';
import 'package:rider/screens/search/cubit/search_states.dart';
import 'package:rider/shared/config_map.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());



  static SearchCubit get(context) => BlocProvider.of(context);

  findPlace({String placeName}) {
    print('\n================================================');
    print(placeName);
    print('================================================\n');
    ApiProvider.getAPIProviderInstance.fetchData(
      path: 'place/autocomplete/json?input=$placeName&key=$kMapKeyForIOS&sessiontoken=1234567890&components=country:eg',
    ).then((response) {

      print('\n================================================');
      print(response);
      print('================================================\n');
      emit(SearchStateSuccess());
    }).catchError((e) {
      emit(SearchStateError(e.toString()));
    });
  }
}
