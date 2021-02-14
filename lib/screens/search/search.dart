import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    String errorForDisplay = 'Invalid Error';

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {
            if (state is SearchStateError) {
              errorForDisplay =  state.error;
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                title: Text(
                'Set Drop Off',
                style:
                TextStyle(fontSize: 20, fontFamily: 'BoltSemiBold', color: kForthColor),
            ),
            centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding:
                  const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0,),
                      buildTextField(title: 'PickUp Location',
                          controller: pickUpAddressController,
                          icon: Icons.location_on),
                      SizedBox(height: 20.0,),
                      buildTextField(title: 'Where To Go ?',
                          controller: destinationAddressController,
                          icon: Icons.location_on,
                          onChange: (userInput){
                            SearchCubit.get(context).findPlace(placeName: userInput);
                          }
                      ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! SearchStateError,
                        builder: (context) => Text(
                          '',
                          style:
                          TextStyle(fontSize: 20, fontFamily: 'BoltSemiBold', color: kSecondaryColor),
                        ),
                        fallback: (context) =>Center(child: Text(
                          errorForDisplay, style: TextStyle(fontSize: 12, fontFamily: 'Muli', color: kSecondaryColor),
                        ),),
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
