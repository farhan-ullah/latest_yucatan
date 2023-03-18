import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;
import 'package:location/location.dart' as loc;

class GoogleMapDummy extends StatefulWidget {
  @override
  State<GoogleMapDummy> createState() => _GoogleMapDummyState();
}

class _GoogleMapDummyState extends State<GoogleMapDummy> {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";
    

    Future<LatLng> getCurrentData() async {
      loc.LocationData location = await loc.Location().getLocation();
      print('==================1111111 ${LatLng(location.latitude, location.longitude)}');
      return LatLng(location.latitude, location.longitude);
    }

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      var myLatlng = LatLng(19.432608, -99.133209);
      getCurrentData().then((value){
        setState(() {
          
        myLatlng = value;
        });
        print('=====================================$myLatlng');
      }
        );
      // another location
      var myLatlng2 = LatLng(19.432608, -99.133209);
      getCurrentData().then((value){
       setState(() {
          
        myLatlng2 = value;
        });
        print('=====================================$myLatlng2');
      }
        );

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = LatLng(19.432608, -99.133209);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      final marker = Marker(MarkerOptions()
        ..position = myLatlng
        ..map = map
        ..title = 'Hello World!'
        ..label = 'h'
        ..icon =
            'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png');

      // Another marker
      Marker(
        MarkerOptions()
          ..position = myLatlng2
          ..map = map,
      );

      final infoWindow =
          InfoWindow(InfoWindowOptions()..content = contentString);
      marker.onClick.listen((event) => infoWindow.open(map, marker));
      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}

var contentString = '<div id="content">' +
    '<div id="siteNotice">' +
    '</div>' +
    '<h1 id="firstHeading" class="firstHeading">Uluru</h1>' +
    '<div id="bodyContent">' +
    '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
    'sandstone rock formation in the southern part of the ' +
    'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) ' +
    'south west of the nearest large town, Alice Springs; 450&#160;km ' +
    '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major ' +
    'features of the Uluru - Kata Tjuta National Park. Uluru is ' +
    'sacred to the Pitjantjatjara and Yankunytjatjara, the ' +
    'Aboriginal people of the area. It has many springs, waterholes, ' +
    'rock caves and ancient paintings. Uluru is listed as a World ' +
    'Heritage Site.</p>' +
    '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">' +
    'https://en.wikipedia.org/w/index.php?title=Uluru</a> ' +
    '(last visited June 22, 2009).</p>' +
    '</div>' +
    '</div>';
