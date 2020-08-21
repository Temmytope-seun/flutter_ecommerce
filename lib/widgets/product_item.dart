import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_start.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/pages/product_detail_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';

class ProductItem extends StatelessWidget {
  ProductItem({this.item});
  final Product item;

  bool _isInCart(AppState state, String id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id ) > -1;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://10.0.2.2:1337${item.picture['url']}';
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ProductDetailPage(item: item);
      })),
      child: GridTile(
        footer: GridTileBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(item.name, style: TextStyle(fontSize: 20.0),),
          ),
          subtitle: Text("\N${item.price}", style: TextStyle(fontSize: 16.0),),
          backgroundColor: Color(0xBB000000),
          trailing: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) {
              return state.user != null ?
                IconButton(
                  icon:  Icon(Icons.remove_shopping_cart),
                  color: Colors.cyan[700],
                  onPressed: () {
//                    print("ok");
                    StoreProvider.of<AppState>(context).dispatch(toggleCartProductAction(item));
                  },
                ) : Text('');
            },
          ),
        ),
        child: Hero(
            tag: item,
            child: Image.network(pictureUrl, fit: BoxFit.cover,)),
      ),
    );
  }
}
