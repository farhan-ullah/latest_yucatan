import 'package:provider/provider.dart';
import 'package:yucatan/components/black_divider.dart';
import 'package:yucatan/components/colored_divider.dart';
import 'package:yucatan/components/custom_app_bar.dart';
import 'package:yucatan/models/activity_model.dart';
import 'package:yucatan/screens/booking/components/booking_screen_selected_date.dart';
import 'package:yucatan/screens/booking/components/booking_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yucatan/screens/booking/components/customCalendar.dart';
import 'package:yucatan/screens/payment_credit_card_screen/components/credit_card_dummy.dart';
import 'package:yucatan/screens/payment_credit_card_screen/components/payment_card_dummy.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:yucatan/utils/widget_dimensions.dart';

class BookingScreenDummy extends StatefulWidget {
  const BookingScreenDummy({super.key});

  @override
  State<BookingScreenDummy> createState() => _BookingScreenDummyState();
}

class _BookingScreenDummyState extends State<BookingScreenDummy> {
  DateTime? _selectedDate;
  BookingStep? _bookingStep;
  List<DateTime> _closedDates = [];
  List<DateTime> _notAvailableDates = [];

  @override
  void initState() {
    _bookingStep = BookingStep.SelectSubCategory;
    super.initState();
  }

  var maxDate = DateTime(
    DateTime.now().year + 2,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: WillPopScope(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: (Dimensions.getScaledSize(65.0)),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bookingStep == BookingStep.SelectTime
                            ? Container()
                            : SizedBox(
                                height: Dimensions.getScaledSize(20.0),
                              ),
                        _bookingStep == BookingStep.SelectTime
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.getScaledSize(24.0),
                                  right: Dimensions.getScaledSize(24.0),
                                ),
                                child: Text(
                                  // widget.activity!.title!,
                                  'Outdoor',
                                  style: TextStyle(
                                    fontSize: Dimensions.getScaledSize(18.0),
                                    fontWeight: FontWeight.bold,
                                    color: Provider.of<ThemeModel>(context,
                                            listen: true)
                                        .primaryMainColor,
                                  ),
                                ),
                              ),
                        _bookingStep == BookingStep.ShowItems
                            ? SizedBox(
                                height: Dimensions.getScaledSize(10.0),
                              )
                            : Container(),
                        _bookingStep == BookingStep.ShowItems
                            ? BookingScreenSelectedDate(
                                date: _selectedDate,
                              )
                            : Container(),
                        _bookingStep == BookingStep.SelectTime
                            ? Container()
                            : SizedBox(
                                height: Dimensions.getScaledSize(10.0),
                              ),
                        _bookingStep == BookingStep.ShowItems
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.getScaledSize(5.0),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.getScaledSize(24.0),
                                      right: Dimensions.getScaledSize(24.0),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .bookingScreen_yourChoice,
                                      style: TextStyle(
                                        fontSize:
                                            Dimensions.getScaledSize(16.0),
                                        fontWeight: FontWeight.bold,
                                        color: Provider.of<ThemeModel>(context,
                                                listen: true)
                                            .primaryMainColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.getScaledSize(5.0),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.getScaledSize(24.0),
                                      right: Dimensions.getScaledSize(24.0),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .bookingScreen_noProductsSelectedError,
                                      style: TextStyle(
                                        fontSize:
                                            Dimensions.getScaledSize(16.0),
                                        color: CustomTheme.disabledColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                        'lib/assets/images/booking_empty.png'),
                                  ),
                                ],
                              )
                            : Container(),
                        // _bookingStep == BookingStep.SelectSubCategory
                        //     ? _getSelectProductSubCategoryUi()
                        //     : Container(),
                        // _bookingStep == BookingStep.SelectProduct
                        //     ? _getSelectProductUi()
                        //     : Container(),
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).padding.bottom -
                                MediaQuery.of(context).padding.bottom -
                                AppBar().preferredSize.height -
                                Dimensions.getScaledSize(65),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.getScaledSize(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.getScaledSize(2),
                                ),
                                CustomCalendarView(
                                  initialDate: DateTime.now(),
                                  minimumDate: DateTime.now(),
                                  maximumDate: maxDate,
                                  startEndDateChange: (DateTime dateData) {
                                    // _onDateSelected(dateData, true);
                                  },
                                  closedDates: _closedDates,
                                  notAvailableDates: _notAvailableDates,
                                  usedForVendor: false,
                                ),
                                SizedBox(
                                  height: Dimensions.getScaledSize(20),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.getScaledSize(14),
                                    right: Dimensions.getScaledSize(14),
                                  ),
                                  child: Text(
                                    // _selectedDate == null
                                    //     ?
                                    AppLocalizations.of(context)!
                                        .bookingScreen_chooseDate,
                                    // : widget.product.timeSlots != null &&
                                    //         widget.product.timeSlots!
                                    //             .hasTimeSlots!
                                    //     ? _timeSlotsForDate.length > 0 &&
                                    //             _timeSlotsForDate[0]
                                    //                     .timeString ==
                                    //                 null
                                    //         ? DateFormat(
                                    //                 'EEEE, dd. LLLL yyyy',
                                    //                 'de-DE')
                                    //             .format(_selectedDate!)
                                    //         : AppLocalizations.of(context)!
                                    //             .bookingScreen_chooseTime
                                    //     : DateFormat('EEEE, dd. LLLL yyyy',
                                    //             'de-DE')
                                    //         .format(_selectedDate!),
                                    style: TextStyle(
                                      fontSize: Dimensions.getScaledSize(14),
                                      color: Provider.of<ThemeModel>(context,
                                              listen: true)
                                          .primaryMainColor,
                                    ),
                                  ),
                                ),
                                // widget.product.timeSlots != null &&
                                //         widget
                                //             .product.timeSlots!.hasTimeSlots! &&
                                //         _timeSlotsForDate.length > 0
                                //     ?
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                      top: Dimensions.getScaledSize(5),
                                      left: Dimensions.getScaledSize(14),
                                      right: Dimensions.getScaledSize(14),
                                      bottom: MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          Dimensions.getScaledSize(15),
                                    ),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      // if (_hideTimeSelection(index)) {
                                      return Container(
                                        color: Colors.red,
                                      );
                                      // }

                                      // return BookingScreenTimeSlotItem(
                                      //   timeSlotItemModel:
                                      //       _timeSlotsForDate[index],
                                      //   hasTime: _timeSlotsForDate[index]
                                      //               .timeString ==
                                      //           null
                                      //       ? false
                                      //       : true,
                                      //   onSelected: (
                                      //     BookingScreenTimeSlotItemModel
                                      //         timeSlotItemModel,
                                      //   ) {
                                      //     _onTimeSlotSelected(
                                      //         timeSlotItemModel);
                                      //   },
                                      // );
                                    },
                                  ),
                                )
                                // : Padding(
                                //     padding: EdgeInsets.symmetric(
                                //       vertical: Dimensions.getScaledSize(5),
                                //       horizontal:
                                //           Dimensions.getScaledSize(14),
                                //     ),
                                //     child: _selectedDate != null
                                //         ? BookingScreenTimeSlotItem(
                                //             timeSlotItemModel:
                                //                 BookingScreenTimeSlotItemModel(
                                //               dateTime: _selectedDate!,
                                //               timeString: "",
                                //               remainingQuota:
                                //                   BookingTimeQuotaUtil
                                //                       .getDailyAvailableQuota(
                                //                 widget.product,
                                //                 _selectedDate!,
                                //                 "",
                                //                 widget.category,
                                //                 widget.subCategory,
                                //               )!,
                                //             ),
                                //             hasTime: false,
                                //             onSelected: (
                                //               BookingScreenTimeSlotItemModel
                                //                   timeSlotItemModel,
                                //             ) {
                                //               _onTimeSlotSelected(
                                //                   timeSlotItemModel);
                                //             },
                                //           )
                                //         : Container(),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Dimensions.getScaledSize(65.0) +
                    MediaQuery.of(context).padding.bottom,
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.getScaledSize(10.0),
                    ),
                    BlackDivider(
                      height: Dimensions.getScaledSize(1.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        // nextBookingStep();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.getScaledSize(15.0),
                          bottom: Dimensions.getScaledSize(15.0),
                          left: Dimensions.getScaledSize(24.0),
                          right: Dimensions.getScaledSize(24.0),
                        ),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.bookingScreen_add,
                            style: TextStyle(
                              fontSize: Dimensions.getScaledSize(20.0),
                              fontWeight: FontWeight.bold,
                              color:
                                  Provider.of<ThemeModel>(context, listen: true)
                                      .primaryMainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    ColoredDivider(
                      height: Dimensions.getScaledSize(3.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: Dimensions.getScaledSize(60.0) +
                          MediaQuery.of(context).padding.bottom,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                      color: Provider.of<ThemeModel>(context, listen: true)
                          .primaryMainColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.getScaledSize(20.0),
                          right: Dimensions.getScaledSize(20.0),
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
                                    AppLocalizations.of(context)!
                                        .bookingScreen_total,
                                    style: TextStyle(
                                      fontSize: Dimensions.getScaledSize(15.0),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '20.0',
                                    style: TextStyle(
                                      fontSize: Dimensions.getScaledSize(21.0),
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
                                  // widget.onTap();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => CreditCardPage()),
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
                                            .bookingScreen_pay,
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.getScaledSize(20),
                                          fontWeight: FontWeight.bold,
                                          color: Provider.of<ThemeModel>(
                                                  context,
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
              /*BookingScreenDiscardPopup(
            showDiscardContainer: _showDiscardContainer,
            onCancel: () {
              setState(() {
                _showDiscardContainer = false;
              });
            },
          ),*/
            ],
          ),
          onWillPop: () {
            return Future.sync(() {
              //   if (_bookingStep == BookingStep.SelectSubCategory &&
              //       orderProducts.isEmpty) {
              //     return true;
              //   } else if (_bookingStep == BookingStep.SelectSubCategory ||
              //       _bookingStep == BookingStep.SelectProduct ||
              //       _bookingStep == BookingStep.SelectTime) {
              //     _previousBookingStep();
              //     return false;
              //   } else if (orderProducts.isNotEmpty) {
              //     showDialog(
              //         context: context,
              //         builder: (context) => DiscardDialog(
              //               () {
              //                 Navigator.of(context).pop();
              //               },
              //               () {},
              //               false,
              //             ));
              //     /* setState(() {
              //   _showDiscardContainer = true;
              // });*/
              //     return false;
              //   } else
              return true;
            });
          },
        ),
      ),
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.bookingScreen_title,
        backgroundColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        appBar: AppBar(),
        centerTitle: true,
      ),
    );
  }
}
