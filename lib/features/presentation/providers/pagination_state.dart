import 'package:app/features/data/repositories/post_repo_impl.dart';
import 'package:app/features/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class PaginationState {
  final List<Post> items;
  final int currentPage;
  final bool hasMore;

  PaginationState({
    required this.items,
    required this.currentPage,
    this.hasMore = true,
  });

  PaginationState copyWith({
    List<Post>? items,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
  }) {
    return PaginationState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

@riverpod
class PaginationNotifier extends AsyncNotifier<PaginationState> {
  bool _isLoading = false;

  @override
  Future<PaginationState> build() async {
    return _fetchPage(1);
  }

  Future<void> loadNextPage() async {
    if (_isLoading || !state.hasValue || !state.value!.hasMore) return;

    _isLoading = true;

    try {
      // Load the next page based on current state
      final nextPage = state.value!.currentPage + 1;
      final newState = await _fetchPage(nextPage);

      // Update state with the next page of items
      state = AsyncData(newState);
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    } finally {
      _isLoading = false;
    }
  }

  Future<PaginationState> _fetchPage(int page) async {
    final postRepo = ref.watch(postRepoImplProvider);

    final result = await postRepo.getPosts(page);
    final hasMore = page < result.totalPages;

    // Append new items to current state items
    final newItems = [
      ...state.value?.items ?? [],
      ...result.posts,
    ];

    // return state.value?.copyWith(
    //       items: newItems.cast<Post>(),
    //       currentPage: page,
    //       hasMore: hasMore,
    //     ) ??
    //     PaginationState(
    //       items: newItems.cast<Post>(),
    //       currentPage: page,
    //       hasMore: hasMore,
    //     );

    return PaginationState(
      // the cast is required to make sure that the items are of type Post
      items: newItems.cast<Post>(),
      currentPage: page,
      hasMore: hasMore,
    );
  }
}

final paginationProvider =
    AsyncNotifierProvider<PaginationNotifier, PaginationState>(
        PaginationNotifier.new);
