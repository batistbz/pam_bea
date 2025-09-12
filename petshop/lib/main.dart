import 'main.dart';
import 'pet_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetShop CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.orangeAccent),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
