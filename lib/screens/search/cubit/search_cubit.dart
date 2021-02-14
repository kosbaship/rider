import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/prediction_place.dart';
import 'package:rider/network/api_provider.dart';
import 'package:rider/screens/search/cubit/search_states.dart';
import 'package:rider/shared/config_map.dart';
import 'package:rider/shared/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());

  List<PredictionsPlace> predictions = [];

  static SearchCubit get(context) => BlocProvider.of(context);

  findPlace({String placeName}) {
    print('\n================================================');
    print(placeName);
    print('================================================\n');
    ApiProvider.getAPIProviderInstance.fetchData(
      path: 'place/autocomplete/json?input=$placeName&key=$kMapKeyForIOS&sessiontoken=1234567890&components=country:eg',
    ).then((response) {

      if(response.data[kStatus] == kStatusOK){
        // print('\n================================================');
        // print(response.data[kPredictions][0][kPredictionsPlaceID]);
        // print('================================================\n');
        for (var place in response.data[kPredictions]) {
          predictions.add(PredictionsPlace(
            predictionsPlaceID: place[kPredictionsPlaceID],
            predictionsPlaceMainText: place[kStructuredFormatting][kPredictionsMainText],
            predictionsPlaceSecondaryText: place[kStructuredFormatting][kPredictionsSecondaryText],
          ));
        }
      }

      print('\n================================================');
      print('================================================');
      for (var place in predictions) {
        print(place.predictionsPlaceID);
        print(place.predictionsPlaceMainText);
        print(place.predictionsPlaceSecondaryText);
      }
      print('================================================\n');
      print('================================================');
      emit(SearchStateSuccess());
    }).catchError((e) {
      emit(SearchStateError(e.toString()));
    });
  }
}
