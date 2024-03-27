part of 'app_cubit.dart';

sealed class AppState {
  const AppState();

  List<Object> get props => [];
}

final class AppCubitInitialState extends AppState {}

final class ChangeNavBarItemState extends AppState {}

final class SetDateState extends AppState {}

final class GetBoxState extends AppState {}

final class AddTodotoListSatte extends AppState {}

final class AllowNotification extends AppState {}

final class DenyNotification extends AppState {}
