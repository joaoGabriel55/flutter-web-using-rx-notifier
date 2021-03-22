import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_app/src/domain/apollo_eleven.dart';
import 'package:flutter_web_app/src/home/home_controller.dart';
import 'package:flutter_web_app/src/infra/constants.dart';
import 'package:rive/rive.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.deepPurple[900],
        accentColor: Colors.red,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(title: 'Apollo eleven'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(IMAGE_BACKGROUND),
            fit: BoxFit.cover,
          ),
        ),
        child: RxBuilder(
          builder: (_) {
            var apolloImages = homeController.getApolloElevenImages();
            if (homeController.isLoading() == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      child: Text(
                        "Loading apollo eleven stories...",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              );
            }
            if (homeController.isEmpty) {
              return Center(
                child: Text(
                  "Space is empty!",
                  style: TextStyle(fontSize: 24),
                ),
              );
            }
            return Center(
              child: ListView.builder(
                itemCount: apolloImages?.length,
                itemBuilder: (context, i) {
                  ApolloEleven apolloImage = apolloImages[i];
                  return Container(
                    margin: EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            apolloImage?.title,
                            style: TextStyle(fontSize: 24),
                          ),
                          margin: EdgeInsets.all(8),
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(apolloImage?.imageUrl),
                          ),
                          width: 500,
                          margin: EdgeInsets.all(8),
                        ),
                        Container(
                          child: Text(apolloImage?.location),
                          margin: EdgeInsets.all(8),
                        ),
                        Container(
                          width: 500,
                          child: Text(apolloImage?.description),
                          margin: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
