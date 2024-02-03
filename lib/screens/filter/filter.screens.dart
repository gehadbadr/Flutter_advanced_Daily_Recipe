import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var selectedUserValue = {};
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    TextApp.filter,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextApp.meals,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
                // space between chips
                spacing: 10,
                // list of chips
                children: [
                  InkWell(
                    onTap: () {
                      selectedUserValue['type'] = "breakfast";
                      setState(() {});
                    },
                    child: Chip(
                      label: Text('Breakfast' ,style: TextStyle(fontSize: 16, color:selectedUserValue['type'] == "breakfast"?ColorsApp.PKColor: ColorsApp.fontGrey,
                          )),
                      backgroundColor: selectedUserValue['type'] == "breakfast"
                          ? Color.fromARGB(255, 255, 175, 128)
                          : ColorsApp.lightGrey,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedUserValue['type'] = "launch";
                      setState(() {});
                    },
                    child: Chip(
                      label: Text('Launch',style: TextStyle(fontSize: 16, color:selectedUserValue['type'] == "launch"?ColorsApp.PKColor: ColorsApp.fontGrey,
                          )),
                      backgroundColor: selectedUserValue['type'] == "launch"
                        ? Color.fromARGB(255, 255, 175, 128)
                          : ColorsApp.lightGrey,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedUserValue['type'] = "dinner";
                      setState(() {});
                    },
                    child: Chip(
                      label: Text('Dinner',style: TextStyle(fontSize: 16, color:selectedUserValue['type'] == "Dinner"?ColorsApp.PKColor: ColorsApp.fontGrey,
                          )),
                      backgroundColor: selectedUserValue['type'] == "dinner"
                          ? ColorsApp.chips
                          : ColorsApp.lightGrey,
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ]),
            const SizedBox(
              height: 20,
            ),
            Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextApp.servingFilter,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextApp.prepTime,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextApp.calories,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
              const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: context.screenWidth - 50,
                height: 60,
                child: CustomButton(
                  bgColor: ColorsApp.PKColor,
                  textColor: ColorsApp.whiteColor,
                  title: TextApp.apply,
                  onPress: () async {
                    //authController.signIn(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
