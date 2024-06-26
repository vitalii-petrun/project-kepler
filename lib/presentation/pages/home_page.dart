import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_cubit.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_state.dart';
import 'package:project_kepler/presentation/cubits/launches/launches_state.dart';
import 'package:project_kepler/presentation/cubits/launches/upcoming_launches_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_cubit.dart';
import 'package:project_kepler/presentation/cubits/news_page/news_state.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';
import 'package:project_kepler/presentation/widgets/failed_body.dart';
import 'package:project_kepler/presentation/widgets/present_function_button.dart';

import 'package:project_kepler/presentation/widgets/event_card.dart';
import 'package:project_kepler/presentation/widgets/rounded_app_bar.dart';

import '../../domain/entities/article.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/launch.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../widgets/launch_card.dart';
import '../widgets/news_card.dart';

import '../widgets/shimmer_loading_body.dart';
import '../widgets/space_drawer.dart';
import '../widgets/space_greeting_card.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _fetchData() {
    context.read<UpcomingLaunchesCubit>().fetch();
    context.read<EventsCubit>().fetch();
    context.read<NewsCubit>().fetchRecentArticles();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(
        title: Text(context.l10n.home),
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
      drawer: const SpaceDrawer(),
      body: const SafeArea(child: _HomeBody()),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Fetch all data in parallel
        try {
          await Future.wait([
            context.read<UpcomingLaunchesCubit>().fetch(),
            context.read<EventsCubit>().fetch(),
            context.read<NewsCubit>().fetchRecentArticles(),
          ]);
        } catch (e) {
          logger.e('Failed to refresh home page data: $e');
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpaceGreetingCard(
                        user: state.user,
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpaceGreetingCard(),
                    );
                  }
                },
              ),
              const SizedBox(width: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PresentFunctionButton.animated(
                          title: context.l10n.aiChat,
                          route: '/ai_chat',
                          icon: Icons.auto_awesome),
                      const SizedBox(width: 8.0),
                      if (context.read<AuthenticationCubit>().state
                          is Unauthenticated)
                        PresentFunctionButton(
                          title: context.l10n.login,
                          route: '/login',
                          icon: Icons.login,
                        ),
                      const SizedBox(width: 8.0),
                      PresentFunctionButton(
                        title: context.l10n.news,
                        route: '/news',
                        icon: Icons.article,
                      ),
                    ],
                  ),
                ),
              ),
              _SpaceSectionTitle(
                title: context.l10n.upcomingLaunches,
                onPressed: () => context.router.pushNamed('/launches'),
                icon: Icons.rocket_rounded,
              ),
              BlocBuilder<UpcomingLaunchesCubit, LaunchesState>(
                builder: (context, state) {
                  if (state is LaunchesLoading) {
                    logger.d('[State] Loading launches...');
                    return _LaunchesSection.loading();
                  } else if (state is LaunchesLoaded) {
                    return _LaunchesSection(
                      launches: state.launches,
                    );
                  } else if (state is LaunchesError) {
                    logger.d(state.message);
                    return FailedBody(
                        message: context.l10n.failedToLoadLaunches);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _SpaceSectionTitle(
                  title: context.l10n.upcomingEvents,
                  onPressed: () => context.router.pushNamed('/events'),
                  icon: Icons.event,
                ),
              ),
              BlocBuilder<EventsCubit, EventsPageState>(
                builder: (context, state) {
                  if (state is EventsLoading) {
                    return _EventsSection.loading();
                  } else if (state is EventsLoaded) {
                    return _EventsSection(events: state.events);
                  } else {
                    return FailedBody(
                      message: context.l10n.failedToLoadEvents,
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _SpaceSectionTitle(
                  title: context.l10n.recentNewss,
                  onPressed: () => context.router.pushNamed('/news'),
                  icon: Icons.article,
                ),
              ),
              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return _ArticlesSection.loading();
                  } else if (state is RecentArticlesLoaded) {
                    return _ArticlesSection(articles: state.articles);
                  } else {
                    return const FailedBody();
                  }
                },
              ),
              const SizedBox(height: 22.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  final bool isLoading;

  const _ArticlesSection({
    Key? key,
    this.isLoading = false,
    required this.articles,
  }) : super(key: key);

  factory _ArticlesSection.loading() {
    return const _ArticlesSection(articles: [], isLoading: true);
  }

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLoading
            ? List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CompactCardPlaceholder(),
                ),
              )
            : articles
                .take(6)
                .map((article) => Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 4.0),
                      child: SizedBox(
                        width: 300.0,
                        child: NewsCard(article: article),
                      ),
                    ))
                .toList(),
      ),
    );
  }
}

class _EventsSection extends StatelessWidget {
  final List<Event> events;
  final bool isLoading;

  const _EventsSection({
    Key? key,
    this.isLoading = false,
    required this.events,
  }) : super(key: key);

  factory _EventsSection.loading() {
    return const _EventsSection(events: [], isLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLoading
            ? List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CompactCardPlaceholder(),
                ),
              )
            : events
                .take(4)
                .map((event) => Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 4.0),
                      child: SizedBox(
                        width: 300.0,
                        child: EventCard(event: event, eventId: event.id),
                      ),
                    ))
                .toList(),
      ),
    );
  }
}

class _LaunchesSection extends StatelessWidget {
  final List<Launch> launches;
  final bool isLoading;

  const _LaunchesSection({
    Key? key,
    required this.launches,
    this.isLoading = false,
  }) : super(key: key);

  factory _LaunchesSection.loading() {
    return const _LaunchesSection(launches: [], isLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLoading
            ? List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CompactCardPlaceholder(),
                ),
              )
            : launches
                .take(3)
                .map((launch) => Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 4.0),
                      child: SizedBox(
                        width: 330.0,
                        child: LaunchCard.compact(launch: launch),
                      ),
                    ))
                .toList(),
      ),
    );
  }
}

class _SpaceSectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;

  const _SpaceSectionTitle({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26.0,
            color: AppColors.spaceTitleColor,
          ),
          const SizedBox(width: 2.0),
          Text(
            title,
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: AppColors.spaceTitleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onPressed,
                child: Text(
                  context.l10n.viewAll,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.spaceTitleColor,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
                color: AppColors.spaceTitleColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
