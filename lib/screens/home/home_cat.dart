// ignore_for_file: prefer_const_constructors

import 'package:adoptme/screens/home/home_dog.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class HomeCat extends StatefulWidget {
  const HomeCat({super.key});

  @override
  State<HomeCat> createState() => _HomeCatState();
}

class _HomeCatState extends State<HomeCat> {
  late List<Pet> pets = [];

  bool _isLoading = true;
  String? userID;
  String? urlImageUser;
  String? nameUser;
  String? emailUser;
  bool _isEmpty = false;
  //final AuthService authService = AuthService();
  void signOutUser(BuildContext context) {
    AuthService().signOutuser(context);
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  String _selectedSpecies = 'All';
  Future refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    urlImageUser = prefs.getString('imageUser');
    nameUser = prefs.getString('name');
    emailUser = prefs.getString('uEmail');
    userID = prefs.getString('_uid');
    setState(() => pets.clear());
    setState(() {
      _isLoading = true;
    });
    try {
      final data = {'category': 'Cat'};
      Response response =
          await Dio().post("${Constants.uri}/returnpets/pets", data: data);
      // print(response);
      setState(() {
        pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
        if (pets.isEmpty) {
          setState(() {
            _isEmpty = true;
          });
          _showMaterialDialog("Empty", "No data to show");
        }
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

  // void _filterPets(String species) {
  //   setState(() {
  //     _selectedSpecies = species;

  //     if (species == 'All') {
  //       _filteredPets = pets;
  //     } else {
  //       _filteredPets = pets.where((pet) => pet.category == species).toList();
  //     }
  //   });
  // }

  final List listSpecies = [
    ListViewSpeciesModel('All', 'assets/icons/all_pets.png'),
    ListViewSpeciesModel('Dogs', 'assets/icons/dog_icon.png'),
    ListViewSpeciesModel('Cats', 'assets/icons/cat_icon.png'),
    ListViewSpeciesModel('Birds', 'assets/icons/bird_icon.png'),
    ListViewSpeciesModel('Others', 'assets/icons/other_pets.png'),
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[300],
      appBar: MyAppBar(
        urlImg: urlImageUser,
        context: context,
        scaffoldKey: scaffoldKey,
        title: "Cats",
      ),
      drawer: DrawerWidget(
        name: nameUser,
        image: urlImageUser,
        email: emailUser,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: constraints.maxHeight * 0.06,
                    width: constraints.maxWidth * 0.95,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            //color: Colors.red
                            height: 100,
                            width: constraints.maxWidth,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final ListViewSpeciesModel item =
                                    listSpecies[index];
                                return SpeciesButton(
                                  species: item.species,
                                  link: item.link,
                                  isSelected: index == selectedIndex,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      switch (index) {
                                        case 0:
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                          break;
                                        case 1:
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeDog()));
                                          break;
                                        case 2:
                                          refresh();
                                          break;
                                        case 3:
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeBirds()));
                                          break;
                                        case 4:
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeOthers()));
                                          break;
                                        default:
                                      }
                                    });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return LayoutBuilder(
                                    builder: (context, constraints) {
                                  return const SizedBox(
                                    width: 5,
                                  );
                                });
                              },
                              itemCount: listSpecies.length,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: constraints.maxHeight * 0.91,
                width: constraints.maxWidth * 0.9,
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _isEmpty
                          ? Center(child: DataNotFound())
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      height: 150,
                                      width: constraints.maxWidth * 0.95,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                      ),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Center(
                                          child: SizedBox(
                                            height:
                                                constraints.maxHeight * 0.85,
                                            width: constraints.maxWidth * 0.93,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CardPerfil(
                                                  height: constraints.maxWidth *
                                                      0.33,
                                                  width: constraints.maxWidth *
                                                      0.33,
                                                  color: Colors.blue.shade200,
                                                  link: pets[index].imageUrl,
                                                ),
                                                CardTexts(
                                                  widthA: constraints.maxWidth *
                                                      0.4,
                                                  name: pets[index].nickname,
                                                  race: pets[index].breed,
                                                  old: pets[index].age,
                                                  sex: pets[index].gender,
                                                  distance:
                                                      pets[index].location,
                                                ),
                                                CardIcon(
                                                  stars: pets[index].stars,
                                                  width: constraints.maxWidth *
                                                      0.13,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.4,
                                                  sizeIcon:
                                                      constraints.maxHeight *
                                                          0.24,
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
            ],
          );
        }),
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
