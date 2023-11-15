import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:tuncstore/blocs/auth/auth_bloc.dart";
import "package:tuncstore/blocs/blocs.dart";
import "package:tuncstore/config/config.dart";
import "package:tuncstore/cubits/cubits.dart";
import "package:tuncstore/firebase_options.dart";
import "package:tuncstore/models/models.dart";
import "package:tuncstore/repositories/repositories.dart";
import "package:tuncstore/screens/screens.dart";
import "package:tuncstore/simple_bloc_observer.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => CartBloc()
              ..add(
                LoadCart(),
              ),
          ),
          BlocProvider(
            create: (_) => WishlistBloc(localStorageRepository: LocalStorage())
              ..add(
                StartWishlist(),
              ),
          ),
          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(),
            )..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => ProductBloc(
              productRepository: ProductRepository(),
            )..add(
                LoadProducts(),
              ),
          ),
          BlocProvider(
            create: (context) => CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
              checkoutRepository: CheckoutRepository(),
              paymentBloc: PaymentBloc(),
            ),
          ),
          BlocProvider(
            create: (context) => PaymentBloc()
              ..add(
                LoadPaymentMethod(),
              ),
          ),
        ],
        child: MaterialApp(
          title: "TuncStore",
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
