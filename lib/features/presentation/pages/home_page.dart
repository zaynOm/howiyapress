import 'package:app/features/data/repositories/post_repo_impl.dart';
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
    final postRepo = ref.watch(postRepoImplProvider);
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
              FutureBuilder(
                future: postRepo.getPosts(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      heightFactor: 15,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    debugPrint(snapshot.toString());
                    return const Center(
                      child: Text("Error Loading Data"),
                    );
                  }
                  if (data == null) return const Center(child: Text("No Data"));
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: data.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20.0,
                        ),
                        itemBuilder: (context, index) {
                          return NewsCard(post: data[index]);
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
