import 'package:provider/provider.dart';
import 'package:yucatan/components/custom_app_bar.dart';
import 'package:yucatan/screens/vendor/order_overview/components/order_overview_screen_account_view.dart';
import 'package:yucatan/screens/vendor/order_overview/components/order_overview_screen_parameter.dart';
import 'package:yucatan/services/response/vendor_dashboard_response.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/utils/theme_model.dart';

class OrderOverviewScreen extends StatefulWidget {
  static const String route = '/orderoverview';
  @override
  _OrderOverviewState createState() => _OrderOverviewState();
}

class _OrderOverviewState extends State<OrderOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final OrderOverviewScreenParameter arguments = ModalRoute.of(context)!
        .settings
        .arguments as OrderOverviewScreenParameter;
    final VendorDashboardResponse vendorDashboardResponse =
        arguments.vendorDashboardResponse as VendorDashboardResponse;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColorVendor,
      body: OrderOverviewScreenAccountView(
        vendorDashboardResponse: vendorDashboardResponse,
      ),
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.vendor_orderOverview_title,
        backgroundColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        appBar: AppBar(),
        centerTitle: true,
      ),
    );
  }
}
