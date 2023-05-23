abstract class AuthenticationEvent {}

class AppStartedEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}
