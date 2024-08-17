part of 'add_delete_update_post_cubit.dart';

sealed class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

 
final class LoadingAddDeleteUpdateState extends AddDeleteUpdatePostState {}

final class FailureAddDeleteUpdateState extends AddDeleteUpdatePostState {
  final String errormessage;
  @override
  List<Object> get props => [errormessage];
  FailureAddDeleteUpdateState({required this.errormessage});
}

final class SucessAddDeleteUpdateState extends AddDeleteUpdatePostState {
  final String sucessmessage;
  @override
  List<Object> get props => [sucessmessage];
  SucessAddDeleteUpdateState({required this.sucessmessage});
  
}
