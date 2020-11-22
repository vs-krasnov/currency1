import 'package:currency/stores/currencies_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CurrenciesStoreProvider extends StatelessWidget {
  final Widget child;

  const CurrenciesStoreProvider({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) async {
        final store = CurrenciesStore.create(ratesService: context.read());
        await store.init();
        return store;
      },
      builder: (context, _) {
        final store = context.watch<CurrenciesStore>();

        if (store == null) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return child;
      },
    );
  }
}
