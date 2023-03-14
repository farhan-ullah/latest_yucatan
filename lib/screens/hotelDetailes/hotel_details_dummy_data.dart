import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/screens/booking/booking_screen.dart';
import 'package:yucatan/screens/booking/booking_screen_dummy.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/theme_model.dart';
import '../../theme/custom_theme.dart';
import '../../utils/widget_dimensions.dart';

class HotelDetailsDummy extends StatefulWidget {
  const HotelDetailsDummy({super.key});

  @override
  State<HotelDetailsDummy> createState() => _HotelDetailsDummyState();
}

class _HotelDetailsDummyState extends State<HotelDetailsDummy> {
  var bookingBarHeight = 0.0;
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var imageHeight = 0.0;
  @override
  Widget build(BuildContext context) {
    bookingBarHeight =
        Dimensions.getScaledSize(60.0) + MediaQuery.of(context).padding.bottom;
    imageHeight = MediaQuery.of(context).size.height - bookingBarHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/homescreen3.jpg'),
                    fit: BoxFit.cover)),
            child: ListView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              padding: EdgeInsets.only(top: imageHeight),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.getScaledSize(32.0),
                        left: Dimensions.getScaledSize(24.0),
                        right: Dimensions.getScaledSize(24.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Hotel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.getScaledSize(20),
                                    color: CustomTheme.primaryColorDark,
                                    height: Dimensions.getScaledSize(1.4),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Dimensions.getScaledSize(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SmoothStarRating(
                                      allowHalfRating: true,
                                      starCount: 5,
                                      rating: 5,
                                      size: Dimensions.getScaledSize(20.0),
                                      color: CustomTheme.accentColor3,
                                      borderColor: CustomTheme.accentColor3,
                                      isReadOnly: true,
                                    ),
                                    SizedBox(
                                      width: Dimensions.getScaledSize(5),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Dimensions.getScaledSize(3),
                                      ),
                                      child: Text(
                                        "11",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.getScaledSize(14.0),
                                            color: CustomTheme.dividerColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {},
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.getScaledSize(24.0),
                            top: Dimensions.getScaledSize(20.0),
                            right: Dimensions.getScaledSize(24.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: Dimensions.getScaledSize(5.0),
                              bottom: Dimensions.getScaledSize(5.0),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: Dimensions.getScaledSize(22.0),
                                  width: Dimensions.getScaledSize(22.0),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: Dimensions.getScaledSize(22.0),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.getScaledSize(10.0),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("42000 Germany"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.getScaledSize(24.0),
                              right: Dimensions.getScaledSize(24.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: Dimensions.getScaledSize(5.0),
                              bottom: Dimensions.getScaledSize(5.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Dimensions.getScaledSize(22.0),
                                  width: Dimensions.getScaledSize(22.0),
                                  child: Icon(
                                    Icons.details,
                                    size: Dimensions.getScaledSize(22.0),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.getScaledSize(10.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: Dimensions.getScaledSize(3),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          'How are you',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'I am fine',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.getScaledSize(15.0),
                      left: Dimensions.getScaledSize(16.0),
                      right: Dimensions.getScaledSize(16.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // _showDescriptionView();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.getScaledSize(6),
                          ),
                          border: Border.all(
                            width: 1,
                            color: CustomTheme.accentColor1.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: Dimensions.getScaledSize(5.0),
                            left: Dimensions.getScaledSize(8.0),
                            right: Dimensions.getScaledSize(8.0),
                            bottom: Dimensions.getScaledSize(5.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: Dimensions.getScaledSize(22.0),
                                width: Dimensions.getScaledSize(22.0),
                                child: Icon(
                                  Icons.coronavirus_outlined,
                                  size: Dimensions.getScaledSize(22.0),
                                  color: CustomTheme.accentColor1,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.getScaledSize(10.0),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.getScaledSize(5),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .hotelDetailesScreen_covidMeasures,
                                    style: TextStyle(
                                      color: CustomTheme.accentColor1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(30.0),
                  ),
                ),
                // _buildVideoPlayer(),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(30.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.getScaledSize(24),
                      right: Dimensions.getScaledSize(24),
                    ),
                    child: Text('Hi this is best One'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(15.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                            Radius.circular(CustomTheme.borderRadius),
                          ),
                          onTap: () {
                            setState(() {
                              // _showDescriptionView();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Dimensions.getScaledSize(8.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!
                                      .hotelDetailesScreen_description,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: Dimensions.getScaledSize(14.0),
                                    color: Provider.of<ThemeModel>(context,
                                            listen: true)
                                        .primaryMainColor,
                                  ),
                                ),
                                Container(
                                  width: Dimensions.getScaledSize(22.0),
                                  height: Dimensions.getScaledSize(22.0),
                                  margin: EdgeInsets.fromLTRB(
                                      Dimensions.getScaledSize(10.0),
                                      0,
                                      Dimensions.getScaledSize(20.0),
                                      0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: CustomTheme.primaryColorDark),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: Dimensions.getScaledSize(16.0),
                                    color: Provider.of<ThemeModel>(context,
                                            listen: true)
                                        .primaryMainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(30.0),
                  ),
                ),
                // Container(
                //   color: CustomTheme.grey,
                //   child: HotelRoomeList(
                //     activity: widget.hotelData!,
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.getScaledSize(24.0),
                      right: Dimensions.getScaledSize(24.0),
                      top: Dimensions.getScaledSize(8.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              Dimensions.getScaledSize(5.0),
                              Dimensions.getScaledSize(10.0)),
                          child: SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 1,
                            rating: 1.0,
                            size: Dimensions.getScaledSize(40.0),
                            color: CustomTheme.accentColor3,
                            borderColor: CustomTheme.accentColor3,
                            isReadOnly: true,
                          ),
                        ),
                        Text(
                          '22',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.getScaledSize(20.0),
                            color:
                                Provider.of<ThemeModel>(context, listen: true)
                                    .primaryMainColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.getScaledSize(10),
                        ),
                        Text(
                          "33",
                          // AppLocalizations.of(context)!
                          //     .hotelDetailesScreen_reviewCountHandlePlural(
                          //         widget.hotelData.reviewCount!),
                          style: TextStyle(
                            fontSize: Dimensions.getScaledSize(14.0),
                            color:
                                Provider.of<ThemeModel>(context, listen: true)
                                    .primaryMainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // widget.hotelData!.reviewCount != null &&
                //         widget.hotelData!.reviewCount! > 0
                //     ?
                //     Container(
                //         height: Dimensions.getScaledSize(180.0),
                //         child: ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           padding: EdgeInsets.only(
                //             right: Dimensions.getScaledSize(19.0),
                //           ),
                //           itemCount:
                //               widget.hotelData!.activityDetails!.reviews != null
                //                   ? widget.hotelData!.activityDetails!.reviews!
                //                               .length <=
                //                           5
                //                       ? widget.hotelData!.activityDetails!
                //                           .reviews!.length
                //                       : 5
                //                   : 0,
                //           itemBuilder: (BuildContext context, int index) {
                //             return Container(
                //               width: MediaQuery.of(context).size.width,
                //               constraints: BoxConstraints(
                //                   maxWidth:
                //                       MediaQuery.of(context).size.width - 40),
                //               child: ReviewsView(
                //                 isComingFromHotelDetails: true,
                //                 review: widget.hotelData!.activityDetails!
                //                     .reviews![index],
                //                 animation: animationController!,
                //                 animationController: animationController!,
                //                 callback: () {
                //                   openReviewsListScreen(widget.hotelData!);
                //                 },
                //               ),
                //             );
                //           },
                //         ),
                //       )
                //     :
                Container(
                  color: Colors.white,
                  child: Container(
                    height: Dimensions.getScaledSize(180),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.getScaledSize(24),
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.getScaledSize(12),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomTheme.hintText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.getScaledSize(10.0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: Dimensions.getScaledSize(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                'lib/assets/images/homescreen3.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.getScaledSize(10),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .hotelDetailesScreen_noReviewsTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.getScaledSize(16.0),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.getScaledSize(10),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .hotelDetailesScreen_noReviewsDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Dimensions.getScaledSize(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // widget.hotelData!.reviewCount != null &&
                //         widget.hotelData!.reviewCount! > 0
                //     ? SizedBox(
                //         height: Dimensions.getScaledSize(20.0),
                //       )
                //     : Container(),
                // widget.hotelData!.reviewCount != null &&
                //         widget.hotelData!.reviewCount! > 0
                //     ?
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(CustomTheme.borderRadius)),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ReviewsListScreen(
                            //             activity: widget.hotelData!,
                            //           ),
                            //       fullscreenDialog: true),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!
                                      .hotelDetailesScreen_showAllReviews,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: Dimensions.getScaledSize(14.0),
                                    color: CustomTheme.primaryColorDark,
                                  ),
                                ),
                                Container(
                                  width: Dimensions.getScaledSize(22.0),
                                  height: Dimensions.getScaledSize(22.0),
                                  margin: EdgeInsets.fromLTRB(
                                      Dimensions.getScaledSize(10.0),
                                      0,
                                      Dimensions.getScaledSize(20.0),
                                      0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: CustomTheme.primaryColorDark,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: Dimensions.getScaledSize(16.0),
                                    color: CustomTheme.primaryColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // : Container(),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                ),
                Container(
                  height: Dimensions.getScaledSize(300.0),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child:
                      // isNotNullOrEmpty(widget.hotelData!.location!.lat!)
                      //     ? GoogleMap(
                      //         mapType: MapType.normal,
                      //         myLocationButtonEnabled: false,
                      //         zoomControlsEnabled: false,
                      //         compassEnabled: false,
                      //         mapToolbarEnabled: false,
                      //         zoomGesturesEnabled: false,
                      //         scrollGesturesEnabled: false,
                      //         tiltGesturesEnabled: false,
                      //         rotateGesturesEnabled: false,
                      //         onTap: (coordinates) {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => GoogleMapsFullscreen(
                      //                   location: widget.hotelData!.location,
                      //                   destinationTitle: widget.hotelData!.title),
                      //             ),
                      //           );
                      //         },
                      //         initialCameraPosition: CameraPosition(
                      //           target: LatLng(
                      //             double.parse(widget.hotelData!.location!.lat!),
                      //             double.parse(widget.hotelData!.location!.lon!),
                      //           ),
                      //           zoom: 14,
                      //         ),
                      //         markers: [
                      //           Marker(
                      //             markerId: MarkerId('0'),
                      //             position: LatLng(
                      //               double.parse(widget.hotelData!.location!.lat!),
                      //               double.parse(widget.hotelData!.location!.lon!),
                      //             ),
                      //           ),
                      //         ].toSet(),
                      //       )
                      //     :
                      Center(
                    child: Text(AppLocalizations.of(context)!
                        .hotelDetailesScreen_locationNotAvailable),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(
                //     top: Dimensions.getScaledSize(25.0),
                //     left: Dimensions.getScaledSize(24.0),
                //     bottom: Dimensions.getScaledSize(25.0),
                //     right: Dimensions.getScaledSize(24.0),
                //   ),
                //   color: CustomTheme.grey,
                //   child: Column(
                //     children: [
                //       Text(
                //         'Angeboten von',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: Provider.of<ThemeModel>(context, listen: true)
                // .primaryMainColor,
                //         ),
                //       ),
                //       Text(
                //         widget.hotelData.vendor.name,
                //         textAlign: TextAlign.center,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             widget.hotelData.vendor.location.street,
                //             textAlign: TextAlign.center,
                //           ),
                //           Text(' '),
                //           Text(
                //             widget.hotelData.vendor.location.housenumber,
                //             textAlign: TextAlign.center,
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             widget.hotelData.vendor.location.zipcode.toString(),
                //             textAlign: TextAlign.center,
                //           ),
                //           Text(' '),
                //           Text(
                //             widget.hotelData.vendor.location.city,
                //             textAlign: TextAlign.center,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: Dimensions.getScaledSize(30.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.getScaledSize(24),
                      right: Dimensions.getScaledSize(24),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!
                          .hotelDetailesScreen_otherRecommendations,
                      style: TextStyle(
                        fontSize: Dimensions.getScaledSize(18.0),
                        fontWeight: FontWeight.bold,
                        color: Provider.of<ThemeModel>(context, listen: true)
                            .primaryMainColor,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: Dimensions.getScaledSize(20.0),
                // ),
                // RecommendedActivities(activityId: widget!.hotelData!.sId!),
                // SizedBox(
                //   height: bookingBarHeight + Dimensions.getScaledSize(20),
                // ),
              ],
            ),
          ),
          // _backgraoundImageUI(widget.hotelData!),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: bookingBarHeight,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  color: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.getScaledSize(20),
                      right: Dimensions.getScaledSize(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.commonWords_from} ",
                                style: TextStyle(
                                  fontSize: Dimensions.getScaledSize(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "444",
                                style: TextStyle(
                                  fontSize: Dimensions.getScaledSize(21),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "€",
                                style: TextStyle(
                                  fontSize: Dimensions.getScaledSize(18),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              // _onTapBook();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => BookingScreenDummy()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: Dimensions.getScaledSize(12.0),
                                bottom: Dimensions.getScaledSize(12.0),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    CustomTheme.borderRadius,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.getScaledSize(2.0),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .hotelDetailesScreen_bookNow,
                                    style: TextStyle(
                                      fontSize: Dimensions.getScaledSize(20),
                                      fontWeight: FontWeight.bold,
                                      color: Provider.of<ThemeModel>(context,
                                              listen: true)
                                          .primaryMainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.getScaledSize(8.0),
                          left: Dimensions.getScaledSize(8.0)),
                      child: Container(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.4),
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(CustomTheme.iconRadius),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ShareUtils.createFirebaseDynamicLink(
                      //     widget.hotelData!.sId!);
                    },
                    child: SizedBox(
                      height: AppBar().preferredSize.height,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.getScaledSize(8.0),
                            right: Dimensions.getScaledSize(8.0)),
                        child: Container(
                          height: AppBar().preferredSize.height - 8,
                          width: AppBar().preferredSize.height - 8,
                          decoration: BoxDecoration(
                              //color: Theme.of(context).disabledColor.withOpacity(0.4),
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.4),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding:
                                EdgeInsets.all(Dimensions.getScaledSize(8.0)),
                            child: Icon(
                              Icons.ios_share,
                              // size: getProportionateScreenHeight(24),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // _onFavoriteButtonPressed(widget.hotelData!.sId!);
                    },
                    child: SizedBox(
                      height: AppBar().preferredSize.height,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.getScaledSize(8.0),
                            right: Dimensions.getScaledSize(8.0)),
                        child: Container(
                          height: AppBar().preferredSize.height - 8,
                          width: AppBar().preferredSize.height - 8,
                          decoration: BoxDecoration(
                              //color: Theme.of(context).disabledColor.withOpacity(0.4),
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.4),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding:
                                EdgeInsets.all(Dimensions.getScaledSize(8.0)),
                            child: Icon(
                              Icons.favorite_border,
                              // size: getProportionateScreenHeight(24),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
