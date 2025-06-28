import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as latLng;
import 'package:latlong2/latlong.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yogivida_mobile/services/api/models/preference_model.dart';

import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';

class LocalisationContact extends StatefulWidget {
  const LocalisationContact({super.key});

  @override
  _LocalisationContactState createState() => _LocalisationContactState();
}

class _LocalisationContactState extends State<LocalisationContact> {
  final LatLng _yogivida =
      const LatLng(14.692, -17.4474); // Coordonnées approximatives de Dakar
  final LatLng _center = const LatLng(14.666975928704844,
      -17.43435979326502); // Coordonnées approximatives de Dakar
  final LatLng _center_2 = const LatLng(14.677245788373606,
      -17.434475128246397); // Coordonnées approximatives de Dakar
  late DataBloc<List<Preference>> dataBloc;
  Map<String, dynamic> globalFilter = {"count": 10};
  final String phoneNumber = "00221774567890"; // Remplace par ton numéro

  @override
  void initState() {
    dataBloc = DataBloc<List<Preference>>(
        (response) => Preference.fromJsonList(response),
        Preference.getEndpoint(isPagination: false),
        isGraphQl: true,
        isPagination: false,
        attributeToGet: Preference.shrinkedAttributs());

    super.initState();
  }

  // Fonction pour lancer un appel téléphonique
  void _launchCaller(String phone) async {
    final Uri callUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Impossible de lancer $phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 70,
                    height: 70,
                    rotate: true,
                    child:
                        const Icon(Icons.pin_drop, color: Colors.red, size: 55),
                  ),
                  Marker(
                    point: _center_2,
                    width: 70,
                    height: 70,
                    rotate: true,
                    child:
                        const Icon(Icons.pin_drop, color: Colors.red, size: 55),
                  ),
                  Marker(
                    point: _yogivida,
                    width: 70,
                    height: 70,
                    rotate: true,
                    child:
                        const Icon(Icons.pin_drop, color: Colors.red, size: 55),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 40.0,
            left: 10.0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Floating contact info card
          Positioned(
            bottom: spacingConstant,
            left: spacingConstant,
            right: spacingConstant,
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBasedWidget<List<Preference>>(
                    customDataBloc: dataBloc,
                    filter: {},
                    useInfiniteScroller: true,
                    customWidget: (state) {
                      List<Preference> preferences = state.data;
                      print("PREFERENCES $preferences");
                      Preference? numPref =
                          preferences.firstWhere((Preference element) {
                        return element.parametre == "Contact";
                      });
                      Preference? emailPref = preferences.firstWhere(
                          (Preference element) => element.parametre == "Email");
                      Preference? adressePref = preferences.firstWhere(
                          (Preference element) =>
                              element.parametre == "Adresse");
                      dynamic numTel;
                      dynamic email;
                      dynamic adresse;
                      if (numPref != null) {
                        numTel = numPref.valeurText ?? numPref.valeur;
                      }
                      if (emailPref != null) {
                        email = emailPref.valeurText ?? emailPref.valeur;
                      }
                      if (adressePref != null) {
                        adresse = adressePref.valeurText ?? adressePref.valeur;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('YOGI VIDA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: spacingConstant,
                                    )),
                                IntrinsicWidth(
                                    child: ButtonFiled(
                                  text: 'Appeler',
                                  handlerPress: () => {_launchCaller(numTel)},
                                ))
                              ]),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: primaryColor),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  "${adresse ?? 'Non renseigné'}",
                                  style: const TextStyle(color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: primaryColor),
                              const SizedBox(width: 8.0),
                              Text(
                                "${numTel ?? 'Non renseigné'}",
                                style: const TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.email, color: primaryColor),
                              const SizedBox(width: 8.0),
                              Text(
                                "${email ?? 'Non renseigné'}",
                                style: const TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
