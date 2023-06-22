// Base class for authentication events
abstract class AuthenticationEvent {}

// Event triggered when the app is started
class AppStartedEvent extends AuthenticationEvent {}

// Event triggered when a login is requested
class LoginEvent extends AuthenticationEvent {}

// Event triggered when a logout is requested
class LogoutEvent extends AuthenticationEvent {}
