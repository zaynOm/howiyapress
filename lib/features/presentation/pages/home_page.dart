import 'package:app/features/presentation/providers/pagination_state.dart';
import 'package:app/features/presentation/widgets/group_selection.dart';
import 'package:app/features/presentation/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> categories = [
  'الرئيسية',
  'اقتصاديات',
  'كتاب الرأي',
  'جهويات',
  'مرئيات',
  'تربويات',
  'حوادث و محاكم',
  'مجتمع',
  'عين على الأحداث',
];

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(paginationProvider);
    final paginationNotifier = ref.read(paginationProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'بحث',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              CategoriesButtonGroup(
                options: categories,
                onSelect: (index) {
                  debugPrint(
                    categories[index],
                  );
                },
              ),
              paginationState.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) {
                  debugPrint(error.toString());
                  debugPrint(stackTrace.toString());
                  return Center(
                    child: Text('Error Loading Data $error'),
                  );
                },
                data: (state) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.items.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20.0),
                        itemBuilder: (context, index) {
                          if (index < state.items.length) {
                            return NewsCard(post: state.items[index]);
                          } else {
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            paginationNotifier.loadNextPage();
                            // });
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
