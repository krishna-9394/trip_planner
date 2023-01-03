import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_providers/firebase_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late User user;
  late FirebaseServices _firebase;
  AuthBloc() : super(InitializingAuthState()) {
    on<GoogleAuthenticationEvent>((event, emit) async {
      emit(InitializingAuthState());
      emit(GoogleAuthentication());
      _firebase = FirebaseServices();
      try {
        await _firebase.signInWithGoogle();
        emit(GoogleAuthenticationComplete(
            name: user.displayName.toString(), emailId: user.email.toString(), url: user.photoURL!));
      } catch (error) {
        emit(GoogleAuthenticationFailed(error: error as Error));
      }
    });
  }
}
