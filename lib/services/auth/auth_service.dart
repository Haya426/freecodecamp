import 'package:freecodecamp/services/auth/auth_user.dart';
import 'package:freecodecamp/services/auth/auth_provider.dart';
import 'package:freecodecamp/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);
 // Add firebase factory to Auth Service 
  factory AuthService.firebase()=> AuthService(FirebaseAuthProvider());
  
  @override
  Future<AuthUser> LogIn({
    required String email, 
    required String password}) => provider.LogIn(email: email, password: password);
  
  @override
  Future<void> LogOut() => provider.LogOut();
  
  @override
  Future<AuthUser> createUser({
    required String email, 
    required String password}) => provider.createUser(email: email, password: password);
    
  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;
  
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
  
  @override
  Future<void> initialize() =>provider.initialize();
}