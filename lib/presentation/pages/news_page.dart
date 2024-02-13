import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/presentation/cubits/articles/articles_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/widgets/news_card.dart';

import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../core/utils/shimmer_gradients.dart';

import '../cubits/articles/articles_state.dart';
import '../cubits/authentication/authentication_cubit.dart';

import '../widgets/shimmer.dart';
import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_drawer.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ArticlesCubit>().fetchArticlesUseCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.theme.brightness == Brightness.dark;

    final LinearGradient gradient =
        isDarkTheme ? nightShimmerGradient : dayShimmerGradient;

    return Shimmer(
      linearGradient: gradient,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.home),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                if (context.read<AuthenticationCubit>().state
                    is Authenticated) {
                  context.router.pushNamed('/profile');
                } else {
                  context.router.pushNamed('/login');
                }
              },
            ),
          ],
        ),
        drawer: const SpaceDrawer(),
        body: BlocBuilder<ArticlesCubit, ArticlesState>(
          builder: (context, state) {
            if (state is ArticlesLoaded) {
              return _LoadedBody(articles: state.articles);
            } else if (state is ArticlesError) {
              return const _FailedBody();
            } else {
              return const ShimmerLoadingBody();
            }
          },
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final List<Article> articles;

  const _LoadedBody({
    required this.articles,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ArticlesCubit>().fetchArticlesUseCase(),
      child: ListView.separated(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return NewsCard(article: article);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
    );
  }
}

class _FailedBody extends StatelessWidget {
  const _FailedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<ArticlesCubit>().fetchArticlesUseCase(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
                height: constraints.maxHeight,
                child: const Center(child: NoInternet())),
          ),
        );
      },
    );
  }
}
