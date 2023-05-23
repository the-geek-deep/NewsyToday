import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;

  AuthenticationBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(AuthenticationInitialState());

  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedEventToState();
    } else if (event is LoginEvent) {
      yield* _mapLoginEventToState();
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEventToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedEventToState() async* {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      yield AuthenticatedState(user: user);
    } else {
      yield UnauthenticatedState();
    }
  }

  Stream<AuthenticationState> _mapLoginEventToState() async* {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      final user = userCredential.user;

      if (user != null) {
        yield AuthenticatedState(user: user);
      } else {
        yield UnauthenticatedState();
      }
    } catch (e) {
      yield UnauthenticatedState();
    }
  }

  Stream<AuthenticationState> _mapLogoutEventToState() async* {
    await _firebaseAuth.signOut();
    yield UnauthenticatedState();
  }
}
