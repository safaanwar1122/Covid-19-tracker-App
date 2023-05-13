import 'package:covid_app_tracker_rest_api_unit_ten/Services/states_services.dart';
import 'package:covid_app_tracker_rest_api_unit_ten/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//https://docs.flutter.dev/cookbook/networking/background-parsing
//https://www.flutterbeads.com/renderbox-was-not-laid-out/
class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String nameOfCountry =
                              snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(
                                                  name: snapshot.data![index]['country'],
                                                  image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                                  totalCases:snapshot.data![index]['cases'],
                                                  todayRecovered: snapshot.data![index]['recovered'],
                                                  totalDeaths:snapshot.data![index]['deaths'],
                                                  active: snapshot.data![index]['active'],
                                                  test: snapshot.data![index]['tests'],
                                                  totalRecovered: snapshot.data![index]['todayRecovered'],
                                                  critical:snapshot.data![index]['critical'],

                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (nameOfCountry
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap:()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(
                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                            totalCases:snapshot.data![index]['cases'],
                                            todayRecovered: snapshot.data![index]['recovered'],
                                            totalDeaths:snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            test: snapshot.data![index]['tests'],
                                            totalRecovered: snapshot.data![index]['todayRecovered'],
                                            critical:snapshot.data![index]['critical'],

                                          )));
                            },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
