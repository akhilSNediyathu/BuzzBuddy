part of 'fetch_followers_bloc.dart';

@immutable
sealed class FetchFollowersEvent {}
final class OnfetchAllFollowersEvent extends FetchFollowersEvent{}
