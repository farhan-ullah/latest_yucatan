import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yucatan/screens/activity_map/components/google_map_web.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/screens/hotelDetailes/hotel_details_dummy_data.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/models/activity_model.dart';
import 'package:yucatan/screens/activity_list_screen/components/activily_list_item_shimmer.dart';
import 'package:yucatan/screens/activity_list_screen/components/activity_list_item_view.dart';
import 'package:yucatan/services/activity_service.dart';
import 'package:yucatan/services/response/activity_multi_response.dart';
import 'package:yucatan/services/response/user_login_response.dart';
import 'package:yucatan/services/user_provider.dart';
import 'package:yucatan/services/user_service.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/Callbacks.dart';
import 'package:yucatan/utils/DialogUtils.dart';
import 'package:yucatan/utils/datefulWidget/DateStatefulWidget.dart';
import 'package:yucatan/utils/datefulWidget/GlobalDate.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class ActivityMapScreen extends DateStatefulWidget {
  @override
  _ActivityMapScreenState createState() => _ActivityMapScreenState();
}

class _ActivityMapScreenState extends DateState<ActivityMapScreen> {
  // Initial Map Position
  LatLng _initialcameraposition = LatLng(49.0083509, 13.2255874);

  // Maps
  // GoogleMapController _controller;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();
  bool zoomedToLocation = false;
  Uint8List? markerIconSmall /*,markerIconSmall1*/;

  Uint8List? markerIconLarge /*,markerIconLarge1*/;

  loc.Location _location = loc.Location();
  CarouselController carouselController = CarouselController();

  List<ActivityModel> activities = <ActivityModel>[];
  ActivityModel? currentlyLargeMarkerActivity;

  bool collapsed = false;
  DateTime selectedDate = DateTime.now();

  UserLoginModel? _user;
  List<String>? _favoriteActivities = [];
  bool? showAppBar;

  @override
  void initState() {
    showAppBar = true;
    _loadActivities();
    _loadMarkerIcons();
    _loadFavoriteActivities();

    // selectedDate = GlobalDate.current();

    super.initState();
  }

  @override
  void dispose() {
    eventBus.fire(OnMapClickCallback(true));
    super.dispose();
  }

  @override
  onDateChanged(DateTime dateTime) {
    if (mounted) {
      setState(() {
        selectedDate = dateTime;
      });
    }
  }

  _loadMarkerIcons() async {
    markerIconSmall = await getBytesFromAsset(
        'lib/assets/images/location_marker_small.png',
        Dimensions.getScaledSize(28.0).toInt());
    markerIconLarge = await getBytesFromAsset(
        'lib/assets/images/location_marker_large.png',
        Dimensions.getScaledSize(90.0).toInt());
  }

  void _loadFavoriteActivities() async {
    // _user = await UserProvider.getUser();
    _user = null;

    if (_user == null) return;

    _favoriteActivities =
        await UserService.getFavoriteActivitiesForUser(_user!.sId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: Dimensions.getHeight(percentage: 100),
                  width: Dimensions.getWidth(percentage: 100),
                  child: GoogleMapDummy(),
                ),
                // GoogleMap(
                //   initialCameraPosition:
                //       CameraPosition(target: _initialcameraposition, zoom: 8),
                //   mapType: MapType.normal,
                //   onMapCreated: _onMapCreated,
                //   myLocationEnabled: true,
                //   markers: markers,
                //   mapToolbarEnabled: false,
                //   zoomControlsEnabled: false,
                //   myLocationButtonEnabled: false,
                //   zoomGesturesEnabled: true,
                //   tiltGesturesEnabled: false,
                //   onTap: (LatLng latLng) {
                //     showAppBar = !showAppBar!;
                //     eventBus.fire(OnMapClickCallback(showAppBar!));
                //   },
                // ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: new EdgeInsets.all(
                                  Dimensions.getScaledSize(10.0)),
                              child: Container(
                                height: Dimensions.getScaledSize(50.0),
                                width: Dimensions.getScaledSize(50.0),
                                child: FloatingActionButton(
                                  heroTag: "activity_map_screen_1",
                                  onPressed: _currentLocation,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.gps_fixed,
                                    color: Provider.of<ThemeModel>(context,
                                            listen: true)
                                        .primaryMainColor,
                                    size: Dimensions.getScaledSize(30.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: Padding(
                          //     padding: new EdgeInsets.all(
                          //         Dimensions.getScaledSize(10.0)),
                          //     child: Container(
                          //       height: Dimensions.getScaledSize(50.0),
                          //       width: Dimensions.getScaledSize(50.0),
                          //       child: DateSelector(onDateSelected: (date) {
                          //         _onDateSelected(date);
                          //       }),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: Dimensions.getHeight(percentage: 29.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _dataActivityListViewItem('Outdoor');
                              },
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                  left: Dimensions.getScaledSize(12.0)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _dataActivityListViewItem(String textTitle) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.getScaledSize(12.0)),
      child: Column(
        children: [
          Container(
            width: Dimensions.getScaledSize(280),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimensions.getScaledSize(16.0),
                ),
              ),
              color: CustomTheme.backgroundColor,
              boxShadow: CustomTheme.shadow,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HotelDetailsDummy(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.getScaledSize(16.0))),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.getScaledSize(16.0))),
                                ),
                                width: Dimensions.getScaledSize(280),
                                height: Dimensions.getHeight(percentage: 20.0),
                                child: Image.asset(
                                  'lib/assets/images/homescreen3.jpg',
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                              bottom: Dimensions.getScaledSize(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        Dimensions.getScaledSize(10.0),
                                        0,
                                        0,
                                        0),
                                    height: Dimensions.getScaledSize(40.0),
                                    width: Dimensions.getScaledSize(280) -
                                        Dimensions.getScaledSize(135.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        textTitle,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.getScaledSize(17.0),
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.getScaledSize(3.0)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: Dimensions.getScaledSize(8.0),
                          right: Dimensions.getScaledSize(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: Dimensions.getScaledSize(32.0),
                              width: Dimensions.getScaledSize(32.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.getScaledSize(48.0)),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.favorite_border,
                                  size: Dimensions.getScaledSize(24.0),
                                  color: CustomTheme.accentColor1,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Dimensions.getScaledSize(16.0),
                          ),
                          bottomRight: Radius.circular(
                            Dimensions.getScaledSize(16.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  Dimensions.getScaledSize(8.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  Dimensions.getScaledSize(5.0),
                                            ),
                                            Row(
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size:
                                                      Dimensions.getScaledSize(
                                                          16.0),
                                                  color: CustomTheme
                                                      .primaryColorDark,
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.getScaledSize(
                                                          5.0),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions
                                                          .getScaledSize(3),
                                                    ),
                                                    child: Text(
                                                      'Germany',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: Dimensions
                                                            .getScaledSize(
                                                                13.0),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: Dimensions.getScaledSize(
                                                    4.0),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  SmoothStarRating(
                                                    isReadOnly: true,
                                                    allowHalfRating: true,
                                                    starCount: 1,
                                                    rating: 1,
                                                    size: Dimensions
                                                        .getScaledSize(18.0),
                                                    color: CustomTheme
                                                        .accentColor3,
                                                    borderColor: CustomTheme
                                                        .primaryColor,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "4",
                                                        style: TextStyle(
                                                          fontSize: Dimensions
                                                              .getScaledSize(
                                                                  13.0),
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        "20",
                                                        style: TextStyle(
                                                          fontSize: Dimensions
                                                              .getScaledSize(
                                                                  13.0),
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          bottom: -5,
                                          right: 0,
                                          child: Row(
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            children: [
                                              Text(
                                                "${AppLocalizations.of(context)!.activityScreen_from} ",
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .getScaledSize(13.0),
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '8.0',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .getScaledSize(21.0),
                                                    color: CustomTheme
                                                        .primaryColorDark),
                                              ),
                                              Text(
                                                "€",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .getScaledSize(18.0),
                                                    color: CustomTheme
                                                        .primaryColorDark),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller.complete(_cntlr);
    _location.onLocationChanged.listen((l) async {
      if (zoomedToLocation == false) {
        zoomedToLocation = true;
        final GoogleMapController controller = await _controller.future;
        if (mounted) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!, l.longitude!), zoom: 8),
            ),
          );
        }
      }
    });
  }

  /*void updateMarkerIconOnZoom(bool isSmallMarker){
    Set<Marker> localMarkers = Set<Marker>();
    if (activities  != null) {
      activities.forEach(
            (element) async {
          if (element.location.lat != null && element.location.lon != null) {
            localMarkers.add(
              Marker(
                markerId: MarkerId(element.sId),
                icon: isSmallMarker
                    ? BitmapDescriptor.fromBytes(markerIconSmall1)
                    : BitmapDescriptor.fromBytes(markerIconSmall),
                position: LatLng(
                  double.parse(element.location.lat),
                  double.parse(element.location.lon),
                ),
                onTap: () {
                  setState(() {
                    collapsed = false;
                  });
                  _setLargeIconForActivity(element);
                  _animateToActivity(element);
                },
              ),
            );
          }
        },
      );
    }
    setState(() {
      markers = localMarkers;
    });
  }*/

  void _loadActivities() async {
    ActivityMultiResponse? result = await ActivityService.getAll();

    Set<Marker> localMarkers = Set<Marker>();

    if (result!.errors == null) {
      activities = result.data!;
      result.data!.forEach(
        (element) async {
          if (element.location!.lat != null && element.location!.lon != null) {
            localMarkers.add(
              Marker(
                markerId: MarkerId(element.sId!),
                icon: BitmapDescriptor.fromBytes(markerIconSmall!),
                position: LatLng(
                  double.parse(element.location!.lat!),
                  double.parse(element.location!.lon!),
                ),
                onTap: () {
                  if (mounted) {
                    setState(() {
                      collapsed = false;
                    });
                  }
                  _setLargeIconForActivity(element);
                  _animateToActivity(element);
                },
              ),
            );
          }
        },
      );
    }

    if (mounted) {
      setState(() {
        markers = localMarkers;
      });
    }
  }

  List<Widget> _buildRecommendedActivities(List<ActivityModel> activities) {
    List<Widget> widgets = [];

    activities.forEach(
      (element) {
        widgets.add(
          ActivityListViewItem(
            isComingFromFullMapScreen: true,
            activityModel: element,
            isFavorite: _favoriteActivities!.contains(element.sId),
            width: Dimensions.getWidth(percentage: 75.0),
            onFavoriteChangedCallback: (String activityId) {
              if (mounted) {
                setState(() {
                  if (_favoriteActivities!.contains(activityId))
                    _favoriteActivities!.remove(activityId);
                  else
                    _favoriteActivities!.add(activityId);
                });
              }
            },
          ),
        );
      },
    );

    if (widgets.isEmpty) {
      widgets.add(ActivityListViewShimmer(
        width: Dimensions.getWidth(percentage: 75.0),
        isComingFromFullMapScreen: true,
      ));
    }

    return widgets;
  }

  void _animateToActivity(ActivityModel activity) {
    if (collapsed == false) {
      var index = activities.indexOf(activity);
      carouselController.jumpToPage(
        index,
      );
    }
  }

  void _adjustMapsCamera(int index) async {
    var activity = activities[index];
    if (activity.location!.lat != null && activity.location!.lon != null) {
      final GoogleMapController controller = await _controller.future;
      var zoom = await controller.getZoomLevel();
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                double.parse(activity.location!.lat!),
                double.parse(activity.location!.lon!),
              ),
              zoom: zoom),
        ),
      );
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _setMarkerIconForMarker(ActivityModel activity, Uint8List icon) {
    if (activity.location!.lat != null && activity.location!.lon != null) {
      markers.removeWhere((element) => element.markerId.value == activity.sId);
      markers.add(
        Marker(
          markerId: MarkerId(activity.sId!),
          icon: BitmapDescriptor.fromBytes(icon),
          position: LatLng(
            double.parse(activity.location!.lat!),
            double.parse(activity.location!.lon!),
          ),
          onTap: () {
            if (mounted) {
              setState(() {
                collapsed = false;
              });
            }
            _setLargeIconForActivity(activity);
            _animateToActivity(activity);
          },
        ),
      );
    }
  }

  void _setLargeIconForActivity(ActivityModel activity) {
    if (mounted) {
      setState(() {
        if (currentlyLargeMarkerActivity != null) {
          _setMarkerIconForMarker(
              currentlyLargeMarkerActivity!, markerIconSmall!);
        }
        currentlyLargeMarkerActivity = activity;
        _setMarkerIconForMarker(activity, markerIconLarge!);
      });
    }
  }

  void _currentLocation() async {
    if (Platform.isIOS) {
      PermissionStatus permissionStatus =
          await requestPermission(Permission.location);
      //print("PermissionStatus=${permissionStatus}");
      if (permissionStatus == PermissionStatus.granted) {
        //print('Permission granted');
      } else if (permissionStatus == PermissionStatus.denied) {
        //print('Denied. Show a dialog with a reason and again ask for the permission.');
        PermissionStatus permissionStatus =
            await requestPermission(Permission.location);
        if (permissionStatus != PermissionStatus.granted) {
          //print("permission not granted");
          return;
        }
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        //Take the user to the settings page.
        var result = await DialogUtils.displayDialog(
            context,
            AppLocalizations.of(context)!
                .location_permission_denied_alert_title,
            AppLocalizations.of(context)!.location_permission_denied_alert_body,
            AppLocalizations.of(context)!.actions_cancel,
            AppLocalizations.of(context)!.commonWords_ok,
            showCancelButton: true,
            showOKButton: true);
        if (result == true) {
          await openAppSettings();
          return;
        }
      }
    }

    loc.Location _location = new loc.Location();
    loc.LocationData? location;

    try {
      location = await _location.getLocation();
    } on PlatformException catch (e) {
      print(e.message);
      location = null;
    }
    if (location == null) {
      print("location is null");
      return;
    }
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude!, location.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  PermissionStatus? permissionStatus;
  Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await permission.request();
    permissionStatus = status;
    return permissionStatus!;
  }
}
