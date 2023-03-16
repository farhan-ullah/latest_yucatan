import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yucatan/components/custom_error_screen.dart';
import 'package:yucatan/models/booking_detailed_model.dart';
import 'package:yucatan/screens/authentication/login/login_screen.dart';
import 'package:yucatan/screens/booking_list_screen/components/booking_list_card_type.dart';
import 'package:yucatan/screens/booking_list_screen/offline_components/booking_list_offline_tabview.dart';
import 'package:yucatan/screens/booking_list_screen/offline_components/booking_list_view_item_skeleton.dart';
import 'package:yucatan/screens/favorites_screen/favourite_screen_dummy.dart';
import 'package:yucatan/screens/hotelDetailes/hotel_details_dummy_data.dart';
import 'package:yucatan/screens/main_screen/components/main_screen_parameter.dart';
import 'package:yucatan/screens/main_screen/main_screen.dart';
import 'package:yucatan/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:yucatan/services/database/database_service.dart';
import 'package:yucatan/services/notification_service/navigatable_by_notification.dart';
import 'package:yucatan/services/notification_service/notification_actions.dart';
import 'package:yucatan/services/response/api_error.dart';
import 'package:yucatan/services/response/booking_detailed_multi_response.dart';
import 'package:yucatan/services/response/user_login_response.dart';
import 'package:yucatan/services/status_service.dart';
import 'package:yucatan/services/user_provider.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListScreenOffline extends StatefulWidget {
  static const String route = '/bookinglist';

  final Function? refresh;
  final NotificationActions? notificationAction;
  final dynamic notificationData;
  final bool? isBookingRequestType;

  BookingListScreenOffline({
    this.refresh,
    this.notificationAction,
    this.notificationData,
    this.isBookingRequestType,
  });

  @override
  _BookingListScreenOfflineState createState() =>
      _BookingListScreenOfflineState();
}

class _BookingListScreenOfflineState extends State<BookingListScreenOffline>
    with NavigatableByNotifcation, TickerProviderStateMixin {
  Future<UserLoginModel>? user;
  Future<BookingDetailedMultiResponseEntity>? bookings;
  List<BookingDetailedModel> used = [];
  List<BookingDetailedModel> usable = [];
  List<BookingDetailedModel> requested = [];
  Future<bool>? onlineStatus;
  TabController? _tabController;
  bool offlineBookings = true;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void removeDeniedBooking(bookingId) async {
    // for now use delete booking

    bool response = await BookingService.deleteBooking(bookingId);
    if (response != null && response) {
      HiveService.updateDatabase();
      BookingDetailedMultiResponseEntity newBookings =
          BookingDetailedMultiResponseEntity();
      requested.removeWhere((element) => element.id == bookingId);
      newBookings.data = [...used, ...usable, ...requested];
      newBookings.status = 200;
      // newBookings.errors = ApiError;
      setState(() {
        bookings = Future.value(newBookings);
      });
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.commonWords_error);
    }
  }

  void refresh() {
    setState(() {
      onlineStatus = null;
      onlineStatus = StatusService.isConnected();
      offlineBookings = true;
    });
  }

  @override
  void initState() {
    //Log firebase event
    if (kReleaseMode) {
      analytics.logEvent(
        name: 'view_booking_list',
        parameters: <String, dynamic>{
          'time': DateTime.now().toIso8601String(),
        },
      );
    }

    offlineBookings = true;
    onlineStatus = StatusService.isConnected();

    if (widget.notificationAction != null && widget.notificationData != null) {
      handleNavigation(widget.notificationAction!, widget.notificationData);
    } else {
      _tabController = TabController(
          length: 3,
          initialIndex: widget.isBookingRequestType! ? 2 : 0,
          vsync: this);
    }

    super.initState();
  }

  @override
  void handleNavigation(
      NotificationActions notificationAction, dynamic notificationData) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    bool handleNotifications = sharedPreferences.getBool('handleNotification')!;

    if (handleNotifications == false) {
      _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
      return;
    }

    switch (notificationAction) {
      case NotificationActions.USER_SHOW_USABLE_BOOKING:
        _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
        break;
      case NotificationActions.USER_SHOW_DENIED_REQUEST:
        _tabController = TabController(length: 3, initialIndex: 2, vsync: this);
        break;
      case NotificationActions.USER_SHOW_REFUNDED_BOOKING:
        _tabController = TabController(length: 3, initialIndex: 1, vsync: this);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Scaffold.of(context).appBarMaxHeight!;
    return FutureBuilder<bool>(
      builder: (context, snapshotConnected) {
        if (snapshotConnected.hasData) {
          // if there is no connectionn, get from SharedPrefs
          if (snapshotConnected.data!) {
            user = UserProvider.getUser();
          } else {
            user = UserProvider.getOfflineUser();
          }
          return Column(
            children: [
              Container(
                height: Dimensions.getScaledSize(60),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, height, 0, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CustomTheme.mediumGrey,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                  labelColor: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                  labelStyle: TextStyle(
                    fontSize: Dimensions.getScaledSize(18.0),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AcuminProWide',
                  ),
                  unselectedLabelColor: CustomTheme.darkGrey.withOpacity(0.5),
                  unselectedLabelStyle: TextStyle(
                    fontSize: Dimensions.getScaledSize(18.0),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AcuminProWide',
                  ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.commonWords_usable),
                    Tab(text: AppLocalizations.of(context)!.commonWords_used),
                    Tab(
                        text:
                            AppLocalizations.of(context)!.commonWords_request),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<UserLoginModel>(
                  future: user,
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData) {
                      if (offlineBookings || !snapshotConnected.data!) {
                        offlineBookings = true;
                        bookings = HiveService.getBookingResponse();
                      }

                      if (snapshotConnected.data! && offlineBookings) {
                        BookingService.getAllForUserDetailed(
                                userSnapshot.data!.sId!)
                            .then((value) {
                          if (value != null &&
                              value.status == 200 &&
                              value.data != null) {
                            if (mounted) {
                              setState(() {
                                offlineBookings = false;
                                bookings = Future.value(value);
                              });
                            }
                          }
                        });
                      }
                      return FutureBuilder<BookingDetailedMultiResponseEntity>(
                        future: bookings,
                        builder: (context, bookingsSnapshot) {
                          if (snapshotConnected.data! &&
                              bookingsSnapshot.hasData &&
                              bookingsSnapshot.data!.data != null) {
                            HiveService.storeBooking(
                                bookingsSnapshot.data!.data!);
                          }
                          if (bookingsSnapshot.hasData &&
                              bookingsSnapshot.data!.data == null) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: Dimensions.getScaledSize(10),
                                  left: Dimensions.getScaledSize(20),
                                  bottom: Dimensions.getScaledSize(20),
                                  right: Dimensions.getScaledSize(20)),
                              child: Text(AppLocalizations.of(context)!
                                  .commonWords_error),
                            );
                          }

                          if (bookingsSnapshot.hasData &&
                              bookingsSnapshot.data!.data != null) {
                            bookingsSnapshot.data!.data!.sort((a, b) =>
                                a.bookingDate!.compareTo(b.bookingDate!));
                            _separateBookings(bookingsSnapshot.data!.data!);

                            return Container(
                              // height: MediaQuery.of(context).size.height -
                              //     60 -
                              //     getProportionateScreenHeight(80) -
                              //     AppBar().preferredSize.height -
                              //     MediaQuery.of(context).padding.top -
                              //     MediaQuery.of(context).padding.bottom,
                              width: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  BookingListOfflineView(
                                    bookingListCardType:
                                        BookingListCardType.USABLE,
                                    noBookingsTitle:
                                        AppLocalizations.of(context)!
                                            .bookingListScreen_noActiveBookings,
                                    bookings: usable,
                                    refresh: refresh,
                                    online: !offlineBookings,
                                    notificationAction:
                                        widget.notificationAction,
                                    notificationData: widget.notificationData,
                                  ),
                                  BookingListOfflineView(
                                    bookingListCardType:
                                        BookingListCardType.USED,
                                    noBookingsTitle:
                                        AppLocalizations.of(context)!
                                            .bookingListScreen_noUsedBookings,
                                    bookings: used,
                                    refresh: refresh,
                                    online: !offlineBookings,
                                    notificationAction:
                                        widget.notificationAction,
                                    notificationData: widget.notificationData,
                                  ),
                                  BookingListOfflineView(
                                    //  key: Key(requested.length.toString()),
                                    bookingListCardType:
                                        BookingListCardType.REQUESTED,
                                    noBookingsTitle: AppLocalizations.of(
                                            context)!
                                        .bookingListScreen_noRequestedBookings,
                                    bookings: requested,
                                    refresh: refresh,
                                    online: !offlineBookings,
                                    notificationAction:
                                        widget.notificationAction,
                                    notificationData: widget.notificationData,
                                    removeDeniedRequest: removeDeniedBooking,
                                  )
                                ],
                              ),
                            );
                          } else if (bookingsSnapshot.hasError) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: Dimensions.getScaledSize(10),
                                  bottom: Dimensions.getScaledSize(20),
                                  left: Dimensions.getScaledSize(20),
                                  right: Dimensions.getScaledSize(20)),
                              child: Text('${bookingsSnapshot.error}'),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.only(
                                top: Dimensions.getScaledSize(20.0),
                                bottom: Dimensions.getScaledSize(16.0),
                                left: Dimensions.getScaledSize(16.0),
                                right: Dimensions.getScaledSize(16.0)),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return BookingListViewItemSkeleton();
                            },
                          );
                        },
                      );
                    } else if (userSnapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.getScaledSize(10),
                            bottom: Dimensions.getScaledSize(20),
                            left: Dimensions.getScaledSize(20),
                            right: Dimensions.getScaledSize(20)),
                        child: Text('${userSnapshot.error}'),
                      );
                    } else if (userSnapshot.data == null) {
                      return ListView.builder(
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
                      );
                      // CustomErrorEmptyScreen(
                      //   title:
                      //       AppLocalizations.of(context)!.commonWords_mistake,
                      //   description: AppLocalizations.of(context)!
                      //       .bookingListScreen_loginToSee,
                      //   rive: RiveAnimation(
                      //     riveFileName: 'tickets_animiert_loop.riv',
                      //     riveAnimationName: 'Animation 1',
                      //     placeholderImage:
                      //         'lib/assets/images/booking_list_empty.png',
                      //     startAnimationAfterMilliseconds: 0,
                      //   ),
                      //   customButtonText:
                      //       AppLocalizations.of(context)!.loginSceen_login,
                      //   callback: _navigateToLogin,
                      // );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          );
        } else if (snapshotConnected.hasError) {
          return Padding(
            padding: EdgeInsets.only(
                top: Dimensions.getScaledSize(10),
                bottom: Dimensions.getScaledSize(20),
                left: Dimensions.getScaledSize(20),
                right: Dimensions.getScaledSize(20)),
            child: Text('${snapshotConnected.error}'),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
      future: onlineStatus,
    );
  }

  _separateBookings(List<BookingDetailedModel> bookings) {
    List<BookingDetailedModel> usedBookings = [];
    List<BookingDetailedModel> usableBookings = [];
    List<BookingDetailedModel> requestedBookings = [];
    bookings.forEach((booking) {
      if (_isBookingUsable(booking)) usableBookings.add(booking);
      if (_isBookingUsed(booking)) usedBookings.add(booking);
      if (_isBookingRequested(booking)) requestedBookings.add(booking);
    });
    used = usedBookings;
    usable = usableBookings;
    requested = requestedBookings;
  }

  _isBookingUsable(booking) {
    return ((booking.status == 'SUCCESS' ||
            booking.status == 'REQUEST_ACCEPTED') &&
        booking.tickets.any((element) => element.status == "USABLE"));
  }

  _isBookingUsed(booking) {
    return booking.status == 'REFUNDED' ||
        booking.tickets.every((element) =>
            element.status == "USED" || element.status == "REFUNDED");
  }

  _isBookingRequested(booking) {
    return (booking.status == 'REQUEST' || booking.status == "REQUEST_DENIED");
  }

  _navigateToLogin() {
    Navigator.of(context).pushNamed(LoginScreen.route).then(
      (value) {
        Navigator.of(context).pushReplacementNamed(
          MainScreen.route,
          arguments: MainScreenParameter(
            bottomNavigationBarIndex: 1,
          ),
        );
      },
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
