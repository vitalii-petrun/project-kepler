import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';
import 'package:project_kepler/presentation/widgets/events_card.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import 'package:project_kepler/presentation/widgets/rounded_app_bar.dart';

import '../../domain/entities/article.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/launch.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/home_page/home_page_state.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().fetch();
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
      body: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading) {
              return _HomeBody.loading();
            } else if (state is HomePageLoaded) {
              return _HomeBody(
                  launches: state.launches,
                  events: state.events,
                  articles: state.articles);
              // return _HomeBody.loading();
            } else if (state is HomePageError) {
              return const _FailedBody();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final List<Launch> launches;
  final List<Event> events;
  final List<Article> articles;
  final bool isLoading;

  const _HomeBody({
    Key? key,
    required this.launches,
    required this.events,
    required this.articles,
    this.isLoading = false,
  }) : super(key: key);

  factory _HomeBody.loading() {
    return const _HomeBody(
      launches: [],
      events: [],
      articles: [],
      isLoading: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomePageCubit>().fetch(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SpaceGreetingCard(),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SpaceSectionTitle(
                  title: context.l10n.upcomingLaunches,
                  accentColor: AppColors.launchCardColor),
            ),
            if (isLoading)
              _LaunchesSection.loading()
            else
              _LaunchesSection(launches: launches),
            const SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SpaceSectionTitle(
                  title: context.l10n.upcomingEvents,
                  accentColor: AppColors.eventCardColor),
            ),
            if (isLoading)
              _EventsSection.loading()
            else
              _EventsSection(events: events),
            const SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SpaceSectionTitle(
                title: context.l10n.recentNewss,
                accentColor: AppColors.newsCardColor,
              ),
            ),
            if (isLoading)
              _ArticlesSection.loading()
            else
              _ArticlesSection(articles: articles),
            const SizedBox(height: 22.0),
          ],
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
      physics: const BouncingScrollPhysics(),
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
            : articles
                .take(3)
                .map((article) => Padding(
                      padding: const EdgeInsets.all(8.0),
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
      physics: const BouncingScrollPhysics(),
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
                .take(5)
                .map((event) => Padding(
                      padding: const EdgeInsets.all(8.0),
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
      physics: const BouncingScrollPhysics(),
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
                      padding: const EdgeInsets.all(8.0),
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
  final Color accentColor;

  const _SpaceSectionTitle({
    Key? key,
    required this.title,
    this.accentColor = Colors.deepOrangeAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: context.theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(1, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.theme.brightness == Brightness.dark
                ? accentColor
                : accentColor.withOpacity(0.6),
            accentColor,
          ],
          stops: const [0.6, 1],
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: context.theme.textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
      ),
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
          onRefresh: () async => context.read<HomePageCubit>().fetch(),
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
