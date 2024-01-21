import 'package:daily_recipe/consts/colors.dart';
import 'package:flutter/material.dart';

class Directions extends StatelessWidget {
  final List? directions;

  const Directions({super.key, required this.directions});

  @override
  Widget build(BuildContext context) {
    return
        ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(directions![index]),
          leading: Container(
            color: ColorsApp.red,
            child: const Icon(
              Icons.fiber_manual_record,
              color: ColorsApp.PKColor,
              size: 10,
            ),
          ),
        );
      },
      itemCount: directions!.length,
    );

    // List.generate(
    //    directions!.length,
    //     (index) =>
    //         Row(
    //           children: [
    //            const Icon(Icons.fiber_manual_record,color: ColorsApp.PKColor,size: 10,),
    //            const SizedBox(width: 5,),
    //            Text(directions![index])])
    //            )
    //);
  }
}
