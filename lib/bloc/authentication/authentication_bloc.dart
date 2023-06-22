import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final FirebaseAuth _firebaseAuth;

  AuthenticationBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthenticationInitialState());

  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedEventToState();
    } else if (event is LoginEvent) {
      yield* _mapLoginEventToState();
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEventToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedEventToState() async* {
    // Check if the user is already authenticated
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      // User is authenticated
      yield AuthenticatedState(user: user);
    } else {
      // User is not authenticated
      yield UnauthenticatedState();
    }
  }

  Stream<AuthenticationState> _mapLoginEventToState() async* {
    try {
      // Sign in anonymously
      final userCredential = await _firebaseAuth.signInAnonymously();
      final user = userCredential.user;

      if (user != null) {
        // User is authenticated
        yield AuthenticatedState(user: user);
      } else {
        // User is not authenticated
        yield UnauthenticatedState();
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException cases
      if (e.code == 'user_disabled') {
        // Handle disabled account case
        // yield DisabledAccountState();
      } else {
        // Handle other FirebaseAuthException cases
        yield UnauthenticatedState();
      }
    } catch (_) {
      // Handle other generic exceptions
      yield UnauthenticatedState();
    }
  }

  Stream<AuthenticationState> _mapLogoutEventToState() async* {
    // Sign out the user
    await _firebaseAuth.signOut();
    yield UnauthenticatedState();
  }
}
