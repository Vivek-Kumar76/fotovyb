import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'core/tokens/tokens.dart';

// ── Home Data & Domain Dependencies
import 'features/home/data/datasources/home_local_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';

// ── Professionals Data & Domain Dependencies
import 'features/professionals/data/datasources/professionals_local_data_source.dart';
import 'features/professionals/data/datasources/professionals_remote_data_source.dart';
import 'features/professionals/data/repositories/professionals_repository_impl.dart';
import 'features/professionals/domain/repositories/professionals_repository.dart';
import 'features/professionals/presentation/bloc/professionals_bloc.dart';
import 'features/professionals/presentation/bloc/professionals_event.dart';

// ── Opportunities Data & Domain Dependencies
import 'features/opportunities/data/datasources/opportunities_local_data_source.dart';
import 'features/opportunities/data/datasources/opportunities_remote_data_source.dart';
import 'features/opportunities/data/repositories/opportunities_repository_impl.dart';
import 'features/opportunities/domain/repositories/opportunities_repository.dart';
import 'features/opportunities/presentation/bloc/opportunities_bloc.dart';
import 'features/opportunities/presentation/bloc/opportunities_event.dart';

// ── GIGs Data & Domain Dependencies
import 'features/gigs/data/datasources/gigs_local_data_source.dart';
import 'features/gigs/data/datasources/gigs_remote_data_source.dart';
import 'features/gigs/data/repositories/gigs_repository_impl.dart';
import 'features/gigs/domain/repositories/gigs_repository.dart';
import 'features/gigs/presentation/bloc/gigs_bloc.dart';
import 'features/gigs/presentation/bloc/gigs_event.dart';

// ── Screen Imports
import 'features/auth/presentation/screens/login_page.dart';
import 'features/home/presentation/screens/home.dart';
import 'features/onboarding/presentation/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize local persistent storage for SWR caching
  final sharedPreferences = await SharedPreferences.getInstance();

  // 2. Initialize networking & repository layers
  final apiClient = ApiClient();

  final homeLocalDataSource =
      HomeLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final homeRemoteDataSource = HomeRemoteDataSourceImpl(apiClient: apiClient);
  final homeRepository = HomeRepositoryImpl(
    remoteDataSource: homeRemoteDataSource,
    localDataSource: homeLocalDataSource,
  );

  final professionalsLocalDataSource =
      ProfessionalsLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final professionalsRemoteDataSource =
      ProfessionalsRemoteDataSourceImpl(apiClient: apiClient);
  final professionalsRepository = ProfessionalsRepositoryImpl(
    remoteDataSource: professionalsRemoteDataSource,
    localDataSource: professionalsLocalDataSource,
  );

  final opportunitiesLocalDataSource =
      OpportunitiesLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final opportunitiesRemoteDataSource =
      OpportunitiesRemoteDataSourceImpl(apiClient: apiClient);
  final opportunitiesRepository = OpportunitiesRepositoryImpl(
    remoteDataSource: opportunitiesRemoteDataSource,
    localDataSource: opportunitiesLocalDataSource,
  );

  final gigsLocalDataSource =
      GigsLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final gigsRemoteDataSource = GigsRemoteDataSourceImpl(apiClient: apiClient);
  final gigsRepository = GigsRepositoryImpl(
    remoteDataSource: gigsRemoteDataSource,
    localDataSource: gigsLocalDataSource,
  );

  // 3. System UI status bar styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // 4. Run App wrapped with Global Repository & BLoC Providers
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>.value(value: homeRepository),
        RepositoryProvider<ProfessionalsRepository>.value(
          value: professionalsRepository,
        ),
        RepositoryProvider<OpportunitiesRepository>.value(
          value: opportunitiesRepository,
        ),
        RepositoryProvider<GigsRepository>.value(value: gigsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (_) => HomeBloc(homeRepository: homeRepository)
              ..add(const HomeLoadRequested()),
          ),
          BlocProvider<ProfessionalsBloc>(
            create: (_) => ProfessionalsBloc(
              professionalsRepository: professionalsRepository,
            )..add(const ProfessionalsLoadRequested()),
          ),
          BlocProvider<OpportunitiesBloc>(
            create: (_) => OpportunitiesBloc(
              repository: opportunitiesRepository,
            )..add(const OpportunitiesLoadRequested()),
          ),
          BlocProvider<GigsBloc>(
            create: (_) => GigsBloc(
              repository: gigsRepository,
            )..add(const GigsLoadRequested()),
          ),
        ],
        child: const FotoVybApp(),
      ),
    ),
  );
}

class FotoVybApp extends StatelessWidget {
  const FotoVybApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOTOVYB',
      debugShowCheckedModeBanner: false,

      // ── Light Theme
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        fontFamily: AppTypography.fontFamilySans,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accentNavy,
          surface: AppColors.surfaceLight,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        dividerColor: AppColors.borderLight,
        splashColor: AppColors.primary.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
      ),

      // ── Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        fontFamily: AppTypography.fontFamilySans,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          secondary: AppColors.primaryHover,
          surface: AppColors.surfaceDark,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        dividerColor: AppColors.borderDark,
        splashColor: AppColors.primaryDark.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
      ),

      themeMode: ThemeMode.light,

      // ── Route Table
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}