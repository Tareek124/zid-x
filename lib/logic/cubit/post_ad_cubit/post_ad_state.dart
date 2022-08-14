part of 'post_ad_cubit.dart';

abstract class PostAdState extends Equatable {
  const PostAdState();

  @override
  List<Object> get props => [];
}

class PostAdInitial extends PostAdState {}

class PostAdLoading extends PostAdState {}

class PostAdError extends PostAdState {
  final String error;
  const PostAdError({required this.error});
}

class PostAdSuccess extends PostAdState {}
