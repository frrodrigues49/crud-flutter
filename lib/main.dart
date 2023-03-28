import 'package:crudflutter/pages/user/form.dart';
import 'package:crudflutter/pages/user/list.dart';
import 'package:crudflutter/provider/user.dart';
import 'package:crudflutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: {
          Routes.HOME: (_) => UserList(),
          Routes.USER_FORM: (_) => UserForm()
        },
      ),
    );
  }
}
