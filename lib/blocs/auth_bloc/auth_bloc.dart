import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'User not found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errMessage: 'Wrong password'));
          }
        } catch (e) {
          emit(LoginFailure(errMessage: 'Something went wrong.'));
        }
      }

      if (event is RegisterEvent) {
        emit(RegiterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegiterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegiterFailure(
                errMessage: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegiterFailure(
                errMessage: 'The account already exists for that email.'));
          }
        } catch (e) {
          emit(RegiterFailure(errMessage: 'Something went wrong'));
        }
      }
    });
  }
}
