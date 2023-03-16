import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yucatan/screens/hotelDetailes/hotel_details_dummy_data.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreenDummy extends StatefulWidget {
  const FavouriteScreenDummy({super.key});

  @override
  State<FavouriteScreenDummy> createState() => _FavouriteScreenDummyState();
}

class _FavouriteScreenDummyState extends State<FavouriteScreenDummy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.getHeight(percentage: 10)),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.getScaledSize(12.0),
            ),
            child: _favouriteData(context),
          );
        },
        itemCount: 5,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
          left: Dimensions.getScaledSize(12.0),
          top: Dimensions.getScaledSize(12.0),
        ),
      ),
    );
  }

  Container _favouriteData(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.getScaledSize(12.0)),
      child: Row(
        children: [
          Container(
            width: Dimensions.getWidth(percentage: 90),
            height: Dimensions.getHeight(percentage: 15.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.getScaledSize(16.0))),
                                ),
                                width: Dimensions.getScaledSize(150),
                                height: Dimensions.getHeight(percentage: 15.0),
                                child: Image.asset(
                                  'lib/assets/images/homescreen3.jpg',
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(width: Dimensions.getScaledSize(5.0)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Indoor",
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.getScaledSize(
                                                      30.0),
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.getScaledSize(120)),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: Dimensions.getScaledSize(
                                                  32.0),
                                              width: Dimensions.getScaledSize(
                                                  32.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                        .getScaledSize(48.0)),
                                                color: CustomTheme.accentColor1,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size:
                                                      Dimensions.getScaledSize(
                                                          24.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: Dimensions.getScaledSize(15.0)),
                                Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: Dimensions.getScaledSize(18.0),
                                      color: CustomTheme.primaryColorDark,
                                    ),
                                    SizedBox(
                                      width: Dimensions.getScaledSize(5.0),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Dimensions.getScaledSize(3),
                                      ),
                                      child: Text(
                                        'Germany',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.getScaledSize(18.0),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: Dimensions.getScaledSize(15.0)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SmoothStarRating(
                                      isReadOnly: true,
                                      allowHalfRating: true,
                                      starCount: 1,
                                      rating: 1,
                                      size: Dimensions.getScaledSize(18.0),
                                      color: CustomTheme.accentColor3,
                                      borderColor: CustomTheme.primaryColor,
                                    ),
                                    SizedBox(
                                      width: Dimensions.getScaledSize(5.0),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "4",
                                          style: TextStyle(
                                            fontSize:
                                                Dimensions.getScaledSize(13.0),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "20",
                                          style: TextStyle(
                                            fontSize:
                                                Dimensions.getScaledSize(13.0),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        width: Dimensions.getScaledSize(120)),
                                    Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.activityScreen_from} ",
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.getScaledSize(
                                                      13.0),
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          '8.0',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.getScaledSize(
                                                      21.0),
                                              color:
                                                  CustomTheme.primaryColorDark),
                                        ),
                                        Text(
                                          "€",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.getScaledSize(
                                                      18.0),
                                              color:
                                                  CustomTheme.primaryColorDark),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Positioned(
                            //   top: Dimensions.getScaledSize(8.0),
                            //   right: Dimensions.getScaledSize(8.0),
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: Container(
                            //       height: Dimensions.getScaledSize(32.0),
                            //       width: Dimensions.getScaledSize(32.0),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(
                            //             Dimensions.getScaledSize(48.0)),
                            //         color: Colors.white,
                            //       ),
                            //       child: Center(
                            //         child: Icon(
                            //           Icons.favorite_border,
                            //           size: Dimensions.getScaledSize(24.0),
                            //           color: CustomTheme.accentColor1,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(
                    //         Dimensions.getScaledSize(16.0),
                    //       ),
                    //       bottomRight: Radius.circular(
                    //         Dimensions.getScaledSize(16.0),
                    //       ),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: Container(
                    //           child: Padding(
                    //             padding: EdgeInsets.all(
                    //               Dimensions.getScaledSize(8.0),
                    //             ),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: <Widget>[
                    //                 Stack(
                    //                   children: [
                    //                     Column(
                    //                       children: [
                    //                         SizedBox(
                    //                           height:
                    //                               Dimensions.getScaledSize(5.0),
                    //                         ),
                    //                         Row(
                    //                           textBaseline:
                    //                               TextBaseline.alphabetic,
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.start,
                    //                           children: <Widget>[
                    //                             Icon(
                    //                               Icons.location_on_outlined,
                    //                               size:
                    //                                   Dimensions.getScaledSize(
                    //                                       16.0),
                    //                               color: CustomTheme
                    //                                   .primaryColorDark,
                    //                             ),
                    //                             SizedBox(
                    //                               width:
                    //                                   Dimensions.getScaledSize(
                    //                                       5.0),
                    //                             ),
                    //                             Expanded(
                    //                               child: Padding(
                    //                                 padding: EdgeInsets.only(
                    //                                   top: Dimensions
                    //                                       .getScaledSize(3),
                    //                                 ),
                    //                                 child: Text(
                    //                                   'Germany',
                    //                                   overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                   style: TextStyle(
                    //                                     fontSize: Dimensions
                    //                                         .getScaledSize(
                    //                                             13.0),
                    //                                     color: Colors.grey,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         Padding(
                    //                           padding: EdgeInsets.only(
                    //                             top: Dimensions.getScaledSize(
                    //                                 4.0),
                    //                           ),
                    //                           child: Row(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.end,
                    //                             children: <Widget>[
                    //                               SmoothStarRating(
                    //                                 isReadOnly: true,
                    //                                 allowHalfRating: true,
                    //                                 starCount: 1,
                    //                                 rating: 1,
                    //                                 size: Dimensions
                    //                                     .getScaledSize(18.0),
                    //                                 color: CustomTheme
                    //                                     .accentColor3,
                    //                                 borderColor: CustomTheme
                    //                                     .primaryColor,
                    //                               ),
                    //                               Row(
                    //                                 children: [
                    //                                   Text(
                    //                                     "4",
                    //                                     style: TextStyle(
                    //                                       fontSize: Dimensions
                    //                                           .getScaledSize(
                    //                                               13.0),
                    //                                       color: Colors.grey,
                    //                                     ),
                    //                                   ),
                    //                                   Text(
                    //                                     "20",
                    //                                     style: TextStyle(
                    //                                       fontSize: Dimensions
                    //                                           .getScaledSize(
                    //                                               13.0),
                    //                                       color: Colors.grey,
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               )
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Positioned(
                    //                       bottom: -5,
                    //                       right: 0,
                    //                       child: Row(
                    //                         textBaseline:
                    //                             TextBaseline.alphabetic,
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.baseline,
                    //                         children: [
                    //                           Text(
                    //                             "Calling",
                    //                             style: TextStyle(
                    //                                 fontSize: Dimensions
                    //                                     .getScaledSize(13.0),
                    //                                 color: Colors.grey),
                    //                           ),
                    //                           Text(
                    //                             '8.0',
                    //                             textAlign: TextAlign.left,
                    //                             style: TextStyle(
                    //                                 fontWeight: FontWeight.bold,
                    //                                 fontSize: Dimensions
                    //                                     .getScaledSize(21.0),
                    //                                 color: CustomTheme
                    //                                     .primaryColorDark),
                    //                           ),
                    //                           Text(
                    //                             "€",
                    //                             textAlign: TextAlign.left,
                    //                             style: TextStyle(
                    //                                 fontWeight: FontWeight.bold,
                    //                                 fontSize: Dimensions
                    //                                     .getScaledSize(18.0),
                    //                                 color: CustomTheme
                    //                                     .primaryColorDark),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
