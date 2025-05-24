abstract class SearchUserEvent {}

class SearchUserbyUID extends SearchUserEvent {
  final String uid;
  
  SearchUserbyUID({required this.uid});
}