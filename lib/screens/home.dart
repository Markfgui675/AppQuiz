import 'package:appquiz/database/category_provider.dart';
import 'package:appquiz/state/state_manage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Category>?>(
          future: getCategories(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'));
            } else if(snapshot.hasData){
              //If snapshot has data, that mean Categories load sucess
              //So we will add more Category with name 'Exam' to let user do Quiz
              //All categories when click -> read more, help user learn from quiz
              //Only 'Exam' category help user make a quiz
              Category category = Category();
              category.ID = -1;
              category.name = 'Exam';
              snapshot.data?.add(category);
              return GridView.count(crossAxisCount: 2,
                                    childAspectRatio: 1.0,
                                    padding: EdgeInsets.all(4.0),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: snapshot.data!.map((category){
                                      return GestureDetector(
                                        child: Card(
                                          elevation: 2,
                                          color: category.ID == -1 ? Colors.green : Colors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Center(
                                                child: AutoSizeText(
                                                  '${category.name}',
                                                  style: TextStyle(
                                                    color: category.ID == -1 ? Colors.white : Colors.black,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),);
            } else return Center(child: CircularProgressIndicator());

          },
      )
    );
  }

  Future<List<Category>?> getCategories() async{
      var db = await copyDB();
      var result = await CategoryProvider().getCategories(db);
      //context.read(categoryListProvider).state = result;
      return result;
  }
}
