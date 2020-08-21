import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_start.dart';
import 'package:flutter_ecommerce/pages/cart_page.dart';
import 'package:flutter_ecommerce/redux/reducers.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:redux_logging/redux_logging.dart';
import './pages/register_page.dart';
import './pages/login_page.dart';
import './pages/products_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(), middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  MyApp({this.store});
  final Store<AppState> store;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/' : (BuildContext context) => ProductsPage(
            onInit: () {
              StoreProvider.of<AppState>(context).dispatch(getUserAction);
              StoreProvider.of<AppState>(context).dispatch(getProductsAction);
              StoreProvider.of<AppState>(context).dispatch(getCartProductsAction);

            }
          ),
          '/login' : (BuildContext context) => LoginPage(),
          '/register' : (BuildContext context) => RegisterPage(),
          '/cart' : (BuildContext context) => CartPage(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          accentColor: Colors.orangeAccent[200],
          textTheme: TextTheme(
            headline5: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 18.0),
          ),
        ),

      ),
    );
  }
}

