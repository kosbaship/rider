import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/prediction_place.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';

import 'cubit/search_cubit.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  final String currentUserAddress;

  SearchScreen({this.currentUserAddress});

  final pickUpAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (currentUserAddress != null) {
      pickUpAddressController.text = currentUserAddress;
    }

    String catchAndDisplayError = 'Invalid Error';

    return BlocProvider(
      create: (context) => SearchCubit(),
      child:
          BlocConsumer<SearchCubit, SearchStates>(listener: (context, state) {
        if (state is SearchStateError) {
          catchAndDisplayError = state.error;
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Set Drop Off',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'BoltSemiBold', color: kForthColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      title: 'PickUp Location',
                      controller: pickUpAddressController,
                      icon: Icons.location_on),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      title: 'Where To Go ?',
                      controller: destinationAddressController,
                      icon: Icons.location_on,
                      onChange: (userInput) {
                        SearchCubit.get(context)
                            .findPlace(placeName: userInput);
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! SearchStateError,
                    builder: (context) {
                      List<PredictionsPlace> predictions = SearchCubit.get(context).predictions;
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: predictions.length,
                            itemBuilder: (BuildContext context, int index) => Container(
                              padding: EdgeInsets.only(left: 24, top: 8, bottom: 8, right: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kMainColor,
                                width: 1,),
                                borderRadius: BorderRadius.circular(
                                  28.0,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on, color: kMainColor, size: 36,),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${predictions[index].predictionsPlaceMainText}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'BoltSemiBold',
                                              color: kMainColor),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '${predictions[index].predictionsPlaceSecondaryText}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Muli',
                                              color: kSecondaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.0,),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                    fallback: (context) => Center(
                      child: Text(
                        catchAndDisplayError,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Muli',
                            color: kSecondaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
