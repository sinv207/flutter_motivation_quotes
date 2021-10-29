import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_motivation_quotes/blocs/bloc/quote_bloc.dart';
import 'package:flutter_motivation_quotes/config/data.dart';
import 'package:flutter_motivation_quotes/models/quote.dart';
import 'package:flutter_motivation_quotes/repositories/sample_quote_repository.dart';
import 'package:flutter_motivation_quotes/widgets/quote/quote.dart';
import 'package:flutter_motivation_quotes/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentPage = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            // AppBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: 'Calibre-Semibold',
                        letterSpacing: 1.0,
                      )),
                  PremiumButton()
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Text('Viewed Quotes',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text('25+ Stories', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            BlocBuilder<QuoteBloc, QuoteState>(
              builder: (context, state) {
                switch (state.status) {
                  case QuoteStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                  case QuoteStatus.success:
                    if (state.quotes.isEmpty) {
                      return const Center(child: Text('no posts'));
                    }
                    print(state.quotes.length);
                    return QuoteSwiper(quotes: state.quotes);
                  // return QuoteCardScroll(
                  //   currentPage: currentPage,
                  //   controller: controller,
                  //   quotes: state.quotes,
                  // );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // FavouriteQuotes(),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
