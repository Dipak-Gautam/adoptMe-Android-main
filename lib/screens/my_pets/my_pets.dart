// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class MyListedPets extends StatefulWidget {
  const MyListedPets({super.key});

  @override
  State<MyListedPets> createState() => _MyListedPetsState();
}

class _MyListedPetsState extends State<MyListedPets> {
  late List<Pet> pets = [];
  late int starss;
  bool _isLoading = true;
  bool _isEmpty = true;
  String? userID;
  String? urlImageUser;
  String? nameUser;
  String? emailUser;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('_uid');
    urlImageUser = prefs.getString('imageUser');
    nameUser = prefs.getString('name');
    emailUser = prefs.getString('uEmail');
    setState(() {
      _isLoading = true;
    });
    try {
      Response response =
          await Dio().get("${Constants.uri}/returnpets/myPets/$userID");
      setState(() {
        if (response.data == null) {
          _isEmpty = true;
          _showMaterialDialog("Empty", "No data to show");
        }
        pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
        _isEmpty = false;
        _isLoading = false;
        // print(pets);
      });
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }

  Future deletePets(Pet pets) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final data = {'id': pets.pid};

      Response response =
          await Dio().post("${Constants.uri}/delete/removePet", data: data);

      setState(() {
        refresh();
      });
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          setState(() {
                            _isEmpty = true;
                          });
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          setState(() {
                            _isEmpty = true;
                          });

                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          setState(() {
                            _isEmpty = true;
                          });
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[300],
      appBar: MyAppBar(
        urlImg: urlImageUser,
        context: context,
        scaffoldKey: scaffoldKey,
        title: "My Listings",
      ),
      extendBodyBehindAppBar: false,
      // appBar: AppBar(
      //   title: Text("My Listings"),
      //   elevation: 0,
      //   backgroundColor: Colors.blue,
      //   automaticallyImplyLeading: true,
      // ),
      drawer: DrawerWidget(
        name: nameUser,
        image: urlImageUser,
        email: emailUser,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height * 0.9,
        child: RefreshIndicator(
          onRefresh: refresh,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _isEmpty
                  ? Center(
                      child: Center(child: DataNotFound()),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pets.length,
                      itemBuilder: (context, index) {
                        //final pet = pets[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetDetails(
                                  pet: pets[index],
                                  userID: userID as String,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Widget cancelButton = TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // dismiss dialog
                                    },
                                  );
                                  Widget okButton = TextButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        deletePets(pets[index]);
                                      });
                                  return AlertDialog(
                                    title: Text("Confirm Action"),
                                    content: Text(
                                        "Do you wish to remove the Pet? It is an non returnable action once commenced."),
                                    actions: [
                                      cancelButton,
                                      okButton,
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.height * 0.95,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.05),
                              ),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Center(
                                  child: SizedBox(
                                    height: constraints.maxHeight * 0.85,
                                    width: constraints.maxWidth * 0.93,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CardPerfil(
                                          height: constraints.maxWidth * 0.33,
                                          width: constraints.maxWidth * 0.33,
                                          color: Colors.blue.shade200,
                                          link: pets[index].imageUrl,
                                        ),
                                        CardTexts(
                                          widthA: constraints.maxWidth * 0.4,
                                          name: pets[index].nickname,
                                          race: pets[index].breed,
                                          old: pets[index].age,
                                          sex: pets[index].gender,
                                          distance: pets[index].location,
                                        ),
                                        CardIcon(
                                          stars: pets[index].stars,
                                          width: constraints.maxWidth * 0.13,
                                          height: constraints.maxHeight * 0.4,
                                          sizeIcon:
                                              constraints.maxHeight * 0.24,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
