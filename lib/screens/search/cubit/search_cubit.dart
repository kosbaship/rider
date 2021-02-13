import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/screens/search/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());



  static SearchCubit get(context) => BlocProvider.of(context);

  getReq({query}) {
    emit(SearchStateLoading());
    emit(SearchStateSuccess());
    // DioHelper.postData(
    //   path: 'lms/api/v1//search',
    //   token: getToken(),
    //   data: {
    //     'q': '$query',
    //     'type': '1',
    //   },
    // ).then((value) {
    //   emit(SearchStateSuccess());
    //
    //   list = (value.data['result']['data'] as List)
    //       .map((json) => CoursesModel.fromJson(json))
    //       .toList();
    //
    //   print('===============================');
    //   print(list.length);
    //   print('===============================');
    //   print(value.data['result']['data'][0]['price']);
    //   print('===============================');
    // }).catchError((e) {
    //   print(e.toString());
    //   emit(SearchStateError(e.toString()));
    // });
  }
}
