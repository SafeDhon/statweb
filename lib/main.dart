import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:statweb/constants.dart';
import 'package:statweb/responsive/responsive_page.dart';

Future<void> main() async {
  String? user = '';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: myFirebaseOptions())
      .then((value) async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        // Loged in
        user = event.displayName;
        getUser(user.toString());
        // FirebaseAuth.instance.currentUser!.updateDisplayName('7160').then(
        //   (value) {
        //     print(' >>>>>>>>>>>>>>>>>>>>..   finish');
        //   }
        // );

        runApp(const MyApp());
      } else {
        // Logout
        setPreferences('', '', '', '');
        runApp(const MyApp());
      }
    });
  });
}

Future<void> getUser(String user) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(user)
      .get()
      .then((value) async {
    setPreferences(
      user,
      value['name'],
      value['surname'],
      value['typeuser'],
    ).then((value) {
    });
  });
}

Future<void> setPreferences(
    String id, String name, String surname, String type) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('id', id);
  preferences.setString('name', name);
  preferences.setString('surname', surname);
  preferences.setString('type', type);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stat For Engineer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ResponsiveLayout(
      //   mobileScaffold: const MobileScaffold(),
      //   tabletScaffold: const TabletScaffold(),
      //   desktopScaffold: const DesktopScaffold(),
      // ),
      home: const ResponsivePage(),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final routerDelegate = BeamerDelegate(
//     locationBuilder: RoutesLocationBuilder(
//       routes: {
//         '/': (context, state, data) => const Home(),
//         '/score': (context, state, data) => const ScoreDesktop(),
//       },
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       routeInformationParser: BeamerParser(),
//       routerDelegate: routerDelegate,
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';
// import 'package:beamer/beamer.dart';

// // DATA
// class Book {
//   const Book(this.id, this.title, this.author);

//   final int id;
//   final String title;
//   final String author;
// }

// const List<Book> books = [
//   Book(1, 'Stranger in a Strange Land', 'Robert A. Heinlein'),
//   Book(2, 'Foundation', 'Isaac Asimov'),
//   Book(3, 'Fahrenheit 451', 'Ray Bradbury'),
// ];

// // SCREENS
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => context.beamToNamed('/books'),
//           child: const Text('See books'),
//         ),
//       ),
//     );
//   }
// }

// class BooksScreen extends StatelessWidget {
//   const BooksScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Books'),
//       ),
//       body: ListView(
//         children: books
//             .map(
//               (book) => ListTile(
//                 title: Text(book.title),
//                 subtitle: Text(book.author),
//                 onTap: () => context.beamToNamed('/books/${book.id}'),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// class BookDetailsScreen extends StatelessWidget {
//   const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

//   final Book? book;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(book?.title ?? 'Not Found'),
//       ),
//       body: book != null
//           ? InkWell(
//               onTap: () =>
//                   context.beamToNamed('/books/${book!.id}/${book!.author}'),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('Author: ${book!.author}'),
//               ),
//             )
//           : const SizedBox.shrink(),
//     );
//   }
// }

// class AuthorDetailsScreen extends StatelessWidget {
//   const AuthorDetailsScreen({Key? key, required this.book}) : super(key: key);

//   final Book? book;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(book?.author ?? 'Not Found'),
//       ),
//       body: book != null
//           ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Book: ${book!.title}'),
//             )
//           : const SizedBox.shrink(),
//     );
//   }
// }

// // LOCATIONS
// class BooksLocation extends BeamLocation<BeamState> {
//   @override
//   List<Pattern> get pathPatterns => ['/books/:bookId/:author'];

//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     final pages = [
//       const BeamPage(
//         key: ValueKey('home'),
//         title: 'Home',
//         child: HomeScreen(),
//       ),
//       if (state.uri.pathSegments.contains('books'))
//         const BeamPage(
//           key: ValueKey('books'),
//           title: 'Books',
//           child: BooksScreen(),
//         ),
//     ];
//     final String? bookIdParameter = state.pathParameters['bookId'];
//     if (bookIdParameter != null) {
//       final bookId = int.tryParse(bookIdParameter);
//       final book = books.firstWhereOrNull((book) => book.id == bookId);
//       pages.add(
//         BeamPage(
//           key: ValueKey('book-$bookIdParameter'),
//           title: 'Book #$bookIdParameter',
//           child: BookDetailsScreen(book: book),
//         ),
//       );
//     }
//     final String? author = state.pathParameters['author'];
//     if (author != null) {
//       final book = books.firstWhereOrNull((book) => book.author == author);
//       pages.add(
//         BeamPage(
//           key: ValueKey('author-$author'),
//           title: 'Author #$author',
//           child: AuthorDetailsScreen(book: book),
//         ),
//       );
//     }
//     return pages;
//   }
// }

// // APP
// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   final routerDelegate = BeamerDelegate(
//     locationBuilder: BeamerLocationBuilder(
//       beamLocations: [BooksLocation()],
//     ),
//     notFoundRedirectNamed: '/books',
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate: routerDelegate,
//       routeInformationParser: BeamerParser(),
//       backButtonDispatcher:
//           BeamerBackButtonDispatcher(delegate: routerDelegate),
//     );
//   }
// }

// void main() => runApp(MyApp());
