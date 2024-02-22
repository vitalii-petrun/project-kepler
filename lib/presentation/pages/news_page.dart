import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/news_page/blogs_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/nasa_news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';
import 'package:project_kepler/presentation/cubits/news_page/spacex_news_cubit.dart';
import 'package:project_kepler/presentation/widgets/news_card.dart';

import '../cubits/authentication/authentication_cubit.dart';

import '../widgets/failed_body.dart';
import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_tab_bar.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void fetchArticles() {
    context.read<NewsCubit>().fetchRecentArticles();
    context.read<SpaceXNewsCubit>().fetchSpaceXArticles();
    context.read<NasaNewsCubit>().fetchNasaArticles();
    context.read<BlogsCubit>().fetchBlogs();
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(context.l10n.news),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (context.read<AuthenticationCubit>().state is Authenticated) {
                context.router.pushNamed('/profile');
              } else {
                context.router.pushNamed('/login');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SpaceTabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: SpaceTabBarItem(label: context.l10n.recent),
                ),
                Tab(
                  child: SpaceTabBarItem(label: context.l10n.spaceXNews),
                ),
                Tab(
                  child: SpaceTabBarItem(label: context.l10n.nasaNews),
                ),
                Tab(
                  child: SpaceTabBarItem(label: context.l10n.blogs),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<NewsCubit, NewsState>(
                    builder: (context, state) => _buildContent(
                        context,
                        state,
                        (context, state) => _LoadedBody(
                            articles: state is RecentArticlesLoaded
                                ? state.articles
                                : [])),
                  ),
                  BlocBuilder<SpaceXNewsCubit, NewsState>(
                    builder: (context, state) => _buildContent(
                        context,
                        state,
                        (context, state) => _LoadedBody(
                            articles: state is SpaceXArticlesLoaded
                                ? state.articles
                                : [])),
                  ),
                  BlocBuilder<NasaNewsCubit, NewsState>(
                    builder: (context, state) => _buildContent(
                        context,
                        state,
                        (context, state) => _LoadedBody(
                            articles: state is NasaArticlesLoaded
                                ? state.articles
                                : [])),
                  ),
                  BlocBuilder<BlogsCubit, NewsState>(
                    builder: (context, state) => _buildContent(
                        context,
                        state,
                        (context, state) => _LoadedBody(
                            articles: state is BlogsLoaded ? state.blogs : [])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildContent<T>(
  BuildContext context,
  NewsState state,
  BlocWidgetBuilder<T> loadedStateBuilder,
) {
  if (state is NewsLoading) {
    return const ShimmerLoadingBody(); // Placeholder during loading
  } else if (state is NewsError) {
    return FailedBody(message: state.message);
  } else if (state is T) {
    return loadedStateBuilder(context, state as T);
  } else {
    return Center(child: Text(context.l10n.unknownError));
  }
}

class _LoadedBody extends StatefulWidget {
  final List<Article> articles;

  const _LoadedBody({
    required this.articles,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    debugPrint('LoadedBodyState: initState  $hashCode');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('LoadedBodyState: dispose $hashCode');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      itemCount: widget.articles.length,
      itemBuilder: (context, index) {
        final article = widget.articles[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NewsCard(article: article),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 20),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
