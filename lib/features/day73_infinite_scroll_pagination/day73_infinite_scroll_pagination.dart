import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const _accent = Color(0xFF6C5CE7);

class Day73InfiniteScrollPagination extends StatefulWidget {
  const Day73InfiniteScrollPagination({super.key});

  @override
  State<Day73InfiniteScrollPagination> createState() =>
      _Day73InfiniteScrollPaginationState();
}

/// Simple model
class Course {
  final String title;

  Course(this.title);
}

class _Day73InfiniteScrollPaginationState
    extends State<Day73InfiniteScrollPagination> {
  /// Maximum number of pages
  static const int _maxPages = 5;

  /// Latest API (v5.1.1)
  late final PagingController<int, Course> _pagingController =
      PagingController<int, Course>(
        getNextPageKey: (state) {
          if (state.pages?.length == _maxPages) {
            return null; // No more pages
          }

          return (state.keys?.last ?? 0) + 1;
        },

        fetchPage: _fetchPage,
      );

  /// Fake API
  Future<List<Course>> _fetchPage(int pageKey) async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      10,
      (index) => Course('Flutter Package ${(pageKey - 1) * 10 + index + 1}'),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget _infoCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        'Infinite Scroll Pagination automatically loads the next page when you reach the bottom of the list. '
        'This example uses dummy data so you can easily understand how pagination works.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 73 - Infinite Scroll',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          _infoCard(),

          Expanded(
            child: PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) {
                return PagedListView<int, Course>(
                  state: state,
                  fetchNextPage: fetchNextPage,

                  builderDelegate: PagedChildBuilderDelegate<Course>(
                    animateTransitions: true,

                    itemBuilder: (context, item, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _accent,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Automatically loaded'),
                        ),
                      );
                    },

                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),

                    newPageProgressIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    ),

                    noMoreItemsIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          '🎉 No More Courses',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    firstPageErrorIndicatorBuilder: (_) =>
                        const Center(child: Text('Something went wrong')),

                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('No Data Found')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
