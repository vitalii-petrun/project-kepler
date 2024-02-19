import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:project_kepler/presentation/widgets/events_card.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import 'package:project_kepler/presentation/widgets/rounded_app_bar.dart';
import '../../core/utils/shimmer_gradients.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/launch.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/home_page/home_page_state.dart';
import '../widgets/launch_card.dart';
import '../widgets/news_card.dart';
import '../widgets/shimmer.dart';
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
    final isDarkTheme = context.theme.brightness == Brightness.dark;

    final LinearGradient gradient =
        isDarkTheme ? nightShimmerGradient : dayShimmerGradient;

    return Shimmer(
      linearGradient: gradient,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: RoundedAppBar(
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
        body: SafeArea(
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return const ShimmerLoadingBody();
              } else if (state is HomePageLoaded) {
                return _LoadedBody(
                    launches: state.launches,
                    events: state.events,
                    articles: state.articles);
              } else if (state is HomePageError) {
                return const _FailedBody();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final List<Launch> launches;
  final List<Event> events;
  final List<Article> articles;

  const _LoadedBody({
    Key? key,
    required this.launches,
    required this.events,
    required this.articles,
  }) : super(key: key);

  Widget _buildLaunchesSection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: launches
            .take(3)
            .map((launch) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300.0,
                    child: LaunchCard.compact(launch: launch),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildEventsSection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: events
            .take(3)
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

  Widget _buildArticlesSection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: articles
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomePageCubit>().fetch(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                  accentColor: Colors.deepPurpleAccent),
            ),
            _buildLaunchesSection(context),
            const SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SpaceSectionTitle(
                title: context.l10n.upcomingEvents,
                accentColor: Colors.deepOrangeAccent,
              ),
            ),
            _buildEventsSection(context),
            const SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SpaceSectionTitle(
                title: context.l10n.recentNewss,
                accentColor: Colors.blue,
              ),
            ),
            _buildArticlesSection(context),
          ],
        ),
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.theme.colorScheme.background.withOpacity(0.5),
            accentColor,
          ],
          stops: const [0.6, 1],
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: context.theme.textTheme.titleLarge,
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
