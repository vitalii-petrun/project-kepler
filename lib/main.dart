import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/core/di/configuration.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/core/utils/notification_service.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/data/repositories/chat_repository_impl.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'core/utils/connectivity_service.dart';
import 'data/repositories/firestore_user_repository.dart';
import 'domain/use_cases/sign_in_with_google_use_case.dart';
import 'domain/use_cases/sign_out_use_case.dart';
import 'firebase_options.dart';

late final AppRouter appRouter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Notification-related services
  await _initializeTimezone();
  await NotificationService().init();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load .env file with project configurations
  await dotenv.load(fileName: ".env");

  // Initialize the locator
  configureDependencies();

  // Register the ChatRepository (AI Chatbot)
  final chatRepository = await ChatRepositoryImpl.create();
  locator.registerSingleton<ChatRepository>(chatRepository);

  appRouter = AppRouter();
  Dio httpClient = Dio();

  ApiClient apiClient = ApiClient(
    httpClient,
    dotenv.env['CORE_API_URL']!,
  );

  ApiClient newsApiClient = ApiClient(
    httpClient,
    dotenv.env['NEWS_API_URL']!,
  );

  runApp(
    Application(
      appRouter: appRouter,
      apiClient: apiClient,
      newsApiClient: newsApiClient,
      authenticationCubit: AuthenticationCubit(
        signOutUseCase: SignOutUseCase(firebaseAuth: FirebaseAuth.instance),
        signInWithGoogleUseCase: SignInWithGoogleUseCase(
          firebaseAuth: FirebaseAuth.instance,
          googleSignIn: GoogleSignIn(),
          userRepository: FirestoreUserRepository(),
        ),
        connectivityService: ConnectivityService(connectivity: Connectivity()),
      ),
    ),
  );
}

Future<void> _initializeTimezone() async {
  tz.initializeTimeZones(); // loads the timezone database
  var locations = tz.timeZoneDatabase.locations;
  logger.d("Timezone locations loaded: ${locations.length}");
}
