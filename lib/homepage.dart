import 'package:flutter/material.dart';
import 'package:login_app/App.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
                subtitle: Text('HI, I am item $index'),
                leading: (index % 2 == 0)
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/sample.jpg'),
                        radius: 30,
                      )
                    : const SizedBox(
                        width: 60,
                        height: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/sample.jpg'),
                          )),
                        ),
                      ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 15),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){
            return  AlertDialog(title: Text("Sign Out"),
            content: Text("Do you want to sign out?"),
            actions: [
            TextButton(onPressed: (){
            Navigator.pop(context);
            }, child: Text("No",)),
            TextButton(onPressed: () async{
            final _sharedPrefs = await SharedPreferences.getInstance();
            await _sharedPrefs.clear();
            Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
            }, child: Text("Yes",style: TextStyle(color: Colors.red),))
            ],);
          });
        },
        backgroundColor: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Sign Out',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
