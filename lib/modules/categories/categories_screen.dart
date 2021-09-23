import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/layout/cubit/cubit.dart';
import 'package:shop_app_am/layout/cubit/states.dart';
import 'package:shop_app_am/model/categories_model.dart';
import 'package:shop_app_am/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index],),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image),
              width: 80,
              height: 80,
            ),
            SizedBox(width: 20,),
            Text('${model.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Spacer(),
            Icon(Icons.arrow_forward_ios
            ),
          ],
        ),
      );
}
