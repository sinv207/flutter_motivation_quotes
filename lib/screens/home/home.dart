import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_motivation_quotes/config/data.dart';
import 'package:flutter_motivation_quotes/models/quote.dart';
import 'package:flutter_motivation_quotes/repositories/sample_quote_repository.dart';
import 'package:flutter_motivation_quotes/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentPage = images.length - 1.0;

  final SampleQuoteRepository _quoteRepository = SampleQuoteRepository();
  List<Quote> _quotes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
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
                    FutureBuilder<List<Quote>>(
                        future: _quotes.isEmpty
                            ? _quoteRepository.getAllQuotes()
                            : null,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Quote>> snapshot) {
                          if (snapshot.hasData) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) => setState(() {
                                      _quotes = snapshot.data;
                                    }));
                            print(snapshot.data);
                            return Text('${snapshot.data.length}+ Stories',
                                style: TextStyle(color: Colors.white));
                          }
                          return Container();
                        }),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage: currentPage, quotes: _quotes),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: _quotes.length ?? images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              // FavouriteQuotes(),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
