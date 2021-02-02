import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mystore/Restaurant/resthome.dart';
import 'package:mystore/Restaurant/rlogin.dart';
import 'package:mystore/Restaurant/rsignup.dart';
import 'package:mystore/firstpage.dart';
import 'package:mystore/screens/details/details_screen.dart';
import './loginpage/sigin_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './bloc/cartListBloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import './model/fooditem.dart';
import './const/themeColor.dart';
import './bloc/listTileColorBloc.dart';
import './cart.dart';
import './loginpage/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/promo_items.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //add yours BLoCs controlles
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ],
      child: MaterialApp(
          title: "MyStore",
          home: FirstPage(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/landingpage': (BuildContext context) => new MyApp(),
            '/signup': (BuildContext context) => new SignUpPage(),
            '/homepage': (BuildContext context) => new Home(),
            '/signin': (BuildContext context) => new SignInPage(),
            '/rlogin': (BuildContext context) => new RestaurantLogin(),
            '/rsignup': (BuildContext context) => new RestaurantSignup(),
            '/resthome': (BuildContext context) => new RestaurantHome(),
            '/firstpage': (BuildContext context) => new FirstPage(),
          }),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: searchBar(),
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[shoppingCartIcon()],
        titleSpacing: 5,
        leadingWidth: 40,
        backgroundColor: Themes.darkBrown,
      ),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Themes.orange,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(user.photoURL),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text(
                      user.displayName,
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Setting',
                style: TextStyle(fontSize: 18),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _googleSignIn.signOut();
                print('User Signed Out');
                Navigator.of(context).pop();
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/firstpage');
                }).catchError((e) {
                  print(e);
                });
              },
            ),
          ],
        ),
      ),
      body: FirstHalf(),
    );
  }

  Widget shoppingCartIcon() {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Stack(children: [
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        tooltip: 'Go to summary page',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (BuildContext context) {
          //     return Scaffold(
          //       appBar: AppBar(
          //         title: const Text('Search'),
          //       ),
          //       body: const Center(
          //         child: Text(
          //           'Put something here',
          //           style: TextStyle(fontSize: 24),
          //         ),
          //       ),
          //     );
          //   },
          // ));
        },
      ),
      Positioned(
        right: 3,
        top: 4,
        child: StreamBuilder(
          stream: bloc.listStream,
          builder: (context, snapshot) {
            List<FoodItem> foodItems = snapshot.data;
            int length = foodItems != null ? foodItems.length : 0;
            return buildGestureDetector(length, context, foodItems);
          },
        ),
      )
    ]);
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        child: Text(length.toString()),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            color: Themes.orange, borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackBar = SnackBar(
          content: Text('${foodItem.title} adicionado ao Carrinho'),
          duration: Duration(milliseconds: 550),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      foodItem: foodItem,
                    )));
      },
      child: Items(
        id: foodItem.id,
        description: foodItem.description,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        weight: foodItem.weight,
        leftAligned: (foodItem.id % 2) == 0 ? true : false,
      ),
    ));
  }
}

class FirstHalf extends StatefulWidget {
  const FirstHalf({
    Key key,
  }) : super(key: key);

  @override
  _FirstHalfState createState() => _FirstHalfState();
}

class _FirstHalfState extends State<FirstHalf> {
  final PageController controller =
      PageController(viewportFraction: 0.8, initialPage: 1);
  int currentPage = 0;

  @override
  void initState() {
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.width * 9 / 16;
    double kDefaultPaddin = 20;
    // return GridView.builder(
    //     itemCount: products.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: kDefaultPaddin,
    //       crossAxisSpacing: kDefaultPaddin,
    //       childAspectRatio: 0.75,
    //     ),
    //     itemBuilder: (context, index) => ItemCard(
    //           product: products[index],
    //           press: () => Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => Scaffold(),
    //               )),
    //         ));
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                itemCount: fooditemList.foodItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) => Container(
                    child: ItemContainer(
                        foodItem: fooditemList.foodItems[index]))),
            // children: [
            //   Container(
            //       child: ItemContainer(foodItem: fooditemList.foodItems[0])),
            //   Container(
            //       child: ItemContainer(foodItem: fooditemList.foodItems[1]))
            // ],
            // crossAxisCount: 1, //fooditemList.foodItems.length,
          ),
        ),
        // ListView(
        //   children: <Widget>[
        Container(
          color: Themes.darkerBrown,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: PageView(controller: controller, children: promoItemList),
          ),
        ),
        //SizedBox(height: 10),
        //categories(),

        // for (var foodItem in fooditemList.foodItems)
        //   Builder(
        //     builder: (context) {
        //       return ItemContainer(foodItem: foodItem);
        //     },
        //   )
        //   ],
        // )
      ],
    );
    //);
  }
}

Widget categories() {
  return Container(
    height: 119,
    width: 140,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Burgers",
          availability: 2,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Pizza",
          availability: 1,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Samosa",
          availability: 1,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Idli Sambhar",
          availability: 1,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Masala Dosa",
          availability: 1,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Rolls",
          availability: 1,
          selected: true,
        ),
      ],
    ),
  );
}

class Items extends StatefulWidget {
  Items({
    @required this.id,
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.description,
    @required this.weight,
  });

  final int id;
  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final double weight;
  final String description;

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double installments = 6;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            height: 180, //280,
            child: ClipRRect(
              child: Hero(
                tag: "${widget.id}",
                child: Image.network(
                  widget.imgUrl,
                ),
              ),
              // ),
            ),
          ),
          //Divider(thickness: 1.0, color: Themes.darkBrown),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Text(widget.itemName,
                  style: TextStyle(
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Themes.darkBrown)),
            ),
          ),
          SizedBox(height: 0),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text('R\$ ' + widget.itemPrice.toStringAsFixed(2),
                    style: TextStyle(
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Themes.darkBrown)),
              ),
              Text(widget.weight.toStringAsFixed(0) + 'g',
                  style: TextStyle(
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Themes.orange)),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String shortenedDesc(String description) {
    if (description.length > 100) {
      return description.substring(0, 100) + '...';
    }
    return description;
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected,
  }) : super(key: key);

  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.only(right: 10, left: 10),
          padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Themes.darkBrown : Themes.orange,
            border: Border.all(
                color: selected ? Colors.transparent : Colors.grey[200],
                width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[100],
                blurRadius: 15,
                offset: Offset(15, 15),
                spreadRadius: 5,
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey[200],
                    width: 1.5)),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Text(
          categoryName,
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

Widget searchBar() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Themes.lightBrown,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search,
                color: Colors.black45,
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: "Pesquisar....",
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    hintStyle: TextStyle(
                      color: Themes.darkerBrown,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // border: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
              ),
            ],
          )),
    ],
  );
}

Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 45),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Cacau",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          Text(
            "Brasil",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          ),
        ],
      )
    ],
  );
}

Widget pageView(PageController controller) {
  return PageView(controller: controller, children: [
    Container(
      color: Colors.red,
      width: 10,
      height: 100,
    ),
    Container(
      color: Colors.blue,
      width: 10,
      height: 100,
    )
  ]);
}
