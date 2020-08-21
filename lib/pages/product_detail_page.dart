import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/kGradientBackground.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/app_start.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';

class ProductDetailPage extends StatelessWidget {
  final Product item;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductDetailPage({this.item});

  bool _isInCart(AppState state, String id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id ) > -1;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://10.0.2.2:1337${item.picture['url']}';
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Container(
        decoration: kGradientBackground,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Hero(
                tag: item,
                child: Image.network(
                  pictureUrl,
                  width: orientation == Orientation.portrait ? 600 : 550,
                  height: orientation == Orientation.portrait ? 400 : 200,
                  fit: BoxFit.cover,),
              ),
            ),
            Text(item.name, style: Theme.of(context).textTheme.headline5,),
            Text('\N${item.price}', style: Theme.of(context).textTheme.bodyText2,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (_, state) {
                  return state.user != null ?
                  IconButton(
                    icon: _isInCart(state, item.id) ? Icon(Icons.remove_shopping_cart) : Icon(Icons.shopping_cart),
                    color: _isInCart(state, item.id) ? Colors.cyan[700] : Colors.white,
                    onPressed: () {
//                      StoreProvider.of<AppState>(context).dispatch(toggleCartProductAction(item));
                      final snackbar  = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Cart updated', style: TextStyle(color: Colors.green),),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackbar);
                    },
                  ) : Text('');
                },
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
                    child: Text(item.description, ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
