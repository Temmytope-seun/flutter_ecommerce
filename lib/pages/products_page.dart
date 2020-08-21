import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/kGradientBackground.dart';
import 'package:flutter_ecommerce/models/app_start.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:flutter_ecommerce/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductsPage extends StatefulWidget {
  final void Function() onInit;
  ProductsPage({this.onInit});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onInit();
  }
  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text(state.user.username) : FlatButton(
            child: Text('Register Here', style: Theme.of(context).textTheme.bodyText2),
            onPressed: () => Navigator.pushNamed(context, '/register'),
          )),
          leading: state.user != null ?
          BadgeIconButton(
            itemCount: state.cartProducts.length,
            badgeColor: Colors.lime,
            badgeTextColor: Colors.black,
            icon: Icon(Icons.store), onPressed: () => Navigator.pushNamed(context, '/cart'),) : Text(''),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(logoutUserAction);
                },
                builder: (_, callback){
                  return  state.user != null ? IconButton(icon: Icon(Icons.exit_to_app), onPressed: callback ): Text('');
                },
                )

            )
          ],
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: kGradientBackground,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return  Column(
              children: <Widget>[
                Expanded(
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: orientation == Orientation.portrait ? 1.0 : 1.3,
                          ),
                          itemBuilder: (context, i) =>
                            ProductItem(item: state.products[i]),

                      ),
                    )
                )
              ],
            );
          },

        ),
      ),
    );
  }
}
