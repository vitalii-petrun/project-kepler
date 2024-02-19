import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: context.theme.textTheme.headline6),
    );
  }

  Widget _buildLaunchesSection(BuildContext context) {
    return Column(
      children: launches
          .take(3) // Assuming you want to show only the first 3 items
          .map((launch) => LaunchCard(launch: launch))
          .toList(),
    );
  }

  Widget _buildEventsSection(BuildContext context) {
    return Column(
      children: events
          .take(3) // Assuming you want to show only the first 3 items
          .map((event) => EventCard(event: event, eventId: event.id))
          .toList(),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    return Column(
      children: articles
          .take(3) // Assuming you want to show only the first 3 items
          .map((article) => NewsCard(article: article))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomePageCubit>().fetch(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, context.l10n.launches),
            _buildLaunchesSection(context),
            _buildSectionTitle(context, context.l10n.eventDetails),
            _buildEventsSection(context),
            _buildSectionTitle(context, context.l10n.news),
            _buildArticlesSection(context),
          ],
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
