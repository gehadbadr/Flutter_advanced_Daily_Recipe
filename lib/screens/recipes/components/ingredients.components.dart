import 'package:flutter/material.dart';

class Ingredients extends StatelessWidget {
  final List? ingredients;

  const Ingredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:List.generate(
       ingredients!.length,
        (index) =>
            Text(ingredients![index])));
    //  return Container();
    // return GridView.builder(
    //   itemCount: 100,
    //   itemBuilder: (context, index) => Text(ingredients![index].toString()),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 2,
    //   ),
    // );
  }
}
