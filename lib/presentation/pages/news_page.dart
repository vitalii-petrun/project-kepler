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
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import 'package:project_kepler/presentation/widgets/rounded_app_bar.dart';
import 'package:project_kepler/presentation/widgets/shimmer.dart';
import '../../core/utils/shimmer_gradients.dart';
import '../../domain/entities/blog.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../widgets/blog_card.dart';
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
    final isDarkTheme = context.theme.brightness == Brightness.dark;
    final LinearGradient gradient =
        isDarkTheme ? nightShimmerGradient : dayShimmerGradient;

    return Shimmer(
      linearGradient: gradient,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: Text(context.l10n.news),
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
        body: SafeArea(
          child: Column(
            children: [
              SpaceTabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: context.l10n.recentNews),
                  Tab(text: context.l10n.spaceXNews),
                  Tab(text: context.l10n.nasaNews),
                  Tab(text: context.l10n.blogs),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<NewsCubit, NewsState>(
                      builder: (context, state) {
                        return _LoadedBody(
                            articles: state is RecentArticlesLoaded
                                ? state.articles
                                : []);
                      },
                    ),
                    BlocBuilder<SpaceXNewsCubit, NewsState>(
                      builder: (context, state) {
                        return _LoadedBody(
                            articles: state is SpaceXArticlesLoaded
                                ? state.articles
                                : []);
                      },
                    ),
                    BlocBuilder<NasaNewsCubit, NewsState>(
                      builder: (context, state) {
                        return _LoadedBody(
                            articles: state is NasaArticlesLoaded
                                ? state.articles
                                : []);
                      },
                    ),
                    BlocBuilder<BlogsCubit, NewsState>(
                      builder: (context, state) {
                        return _LoadedBlogsBody(
                            blogs: state is BlogsLoaded ? state.blogs : []);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        return NewsCard(article: article);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 20),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _LoadedBlogsBody extends StatefulWidget {
  final List<Blog> blogs;

  const _LoadedBlogsBody({
    required this.blogs,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBlogsBody> createState() => _LoadedBlogsBodyState();
}

class _LoadedBlogsBodyState extends State<_LoadedBlogsBody>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    debugPrint('LoadedBlogsBodyState: initState');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('LoadedBlogsBodyState: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      itemCount: widget.blogs.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            context.l10n.blogs,
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
        final blog = widget.blogs[index];
        return BlogCard(blog: blog);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 20),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FailedBody extends StatelessWidget {
  const _FailedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: const Center(child: NoInternet()),
          ),
        );
      },
    );
  }
}
