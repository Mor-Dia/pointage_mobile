import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalisationContact extends StatefulWidget {
  const LocalisationContact({super.key});

  @override
  _LocalisationContactState createState() => _LocalisationContactState();
}

class _LocalisationContactState extends State<LocalisationContact> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(14.692, -17.4474); // Coordonnées approximatives de Dakar

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final String phoneNumber = "+221774567890"; // Remplace par ton numéro

  // Fonction pour lancer un appel téléphonique
  void _launchCaller(String phone) async {
    final Uri callUri = Uri(scheme: 'tel', path: phone);

    // Vérifie si le lancement est possible avant d'essayer
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
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('yogi_vida'),
                position: _center,
                infoWindow: const InfoWindow(
                  title: 'YOGI VIDA',
                  snippet: '137 rue Moussè Diop x rue Jules Ferry',
                ),
              ),
            },
          ),
          // Back button
          Positioned(
            top: 40.0,
            left: 10.0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: primaryColor),
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
                child: Column(
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
                            handlerPress: () => {_launchCaller(phoneNumber)},
                          ))
                        ]),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryColor),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            '137 rue Moussè Diop x rue Jules Ferry',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.phone, color: primaryColor),
                        const SizedBox(width: 8.0),
                        Text(
                          '+221 33 822 60 35',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.email, color: primaryColor),
                        const SizedBox(width: 8.0),
                        Text(
                          'yogivida18@gmail.com',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
