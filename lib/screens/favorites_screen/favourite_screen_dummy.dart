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
  List<String> imagePathList= <String>[
    'lib/assets/images/fav1.jpg',
    'lib/assets/images/fav2.jpg',
    'lib/assets/images/fav3.jpg',
    'lib/assets/images/fav4.jpg',
    'lib/assets/images/fav5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(
            Dimensions.getScaledSize(12.0),
          ),
          child: _favouriteData(context, imagePathList[index]),
        );
      },
      itemCount: 5,
      
    );
  }

   Container _favouriteData(BuildContext context, String imagePathValue) {
    return Container(
      width: Dimensions.getWidth(percentage: 100),
      height: Dimensions.getHeight(percentage: 12.0),
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
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                            Dimensions.getScaledSize(16.0))),
                  ),
                  width: Dimensions.getScaledSize(100),
                  height: Dimensions.getHeight(percentage: 12.0),
                  child: Image.asset(
                    imagePathValue,
                    fit: BoxFit.fill,
                  )),
              SizedBox(width: Dimensions.getScaledSize(5.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Indoor",
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Dimensions.getScaledSize(
                                    20.0),
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(percentage: 38),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: Dimensions.getScaledSize(
                              28.0),
                          width: Dimensions.getScaledSize(
                              28.0),
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
                                      21.0),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: Dimensions.getScaledSize(5.0)),
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
                      height: Dimensions.getScaledSize(5.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            SmoothStarRating(
                              isReadOnly: true,
                              allowHalfRating: true,
                              starCount: 1,
                              rating: 1,
                              size: Dimensions.getScaledSize(18.0),
                              color: CustomTheme.accentColor3,
                              borderColor: CustomTheme.primaryColor,
                            ),SizedBox(
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
                          ],
                        ),
                      ),
                      
                      SizedBox(
                          width: Dimensions.getWidth(percentage: 32)),
                      Container(
                        child: Row(
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
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
