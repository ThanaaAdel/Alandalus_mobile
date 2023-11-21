
import 'package:alandalos/screens/auth/login/auth_provider.dart';
import 'package:alandalos/screens/children/child_details/child_details_provider.dart';
import 'package:alandalos/screens/children/child_details/tab/detailsItems/details_Item_provider.dart';
import 'package:alandalos/screens/children/children_provider.dart';
import 'package:alandalos/screens/notification/notification_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'api_service/connectivity/connectivity_status.dart';
import 'injection.dart';

class GenerateMultiProvider extends StatelessWidget {
  final Widget child;

  const GenerateMultiProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ConnectivityProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<StudentsProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<NotificationProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ChildDetailsProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<DetailsItemProvider>()),
      ],
      child: child,
    );
  }
}
