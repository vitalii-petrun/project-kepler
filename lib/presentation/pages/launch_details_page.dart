import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/launch_details/launch_details_page_cubit.dart';
import 'package:project_kepler/presentation/widgets/countdown_timer.dart';
import 'package:project_kepler/presentation/widgets/titled_details_card.dart';
import '../../domain/entities/launch.dart';
import '../blocs/launch_details/launch_details_page_state.dart';

@RoutePage()
class LaunchDetailsPage extends StatefulWidget {
  final String launchId;

  const LaunchDetailsPage(
      {Key? key, @PathParam('launchId') required this.launchId})
      : super(key: key);

  @override
  State<LaunchDetailsPage> createState() => _LaunchDetailsPageState();
}

class _LaunchDetailsPageState extends State<LaunchDetailsPage> {
  @override
  void initState() {
    context.read<LaunchDetailsPageCubit>().getLaunchDetails(widget.launchId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LaunchDetailsPageCubit, LaunchDetailsPageState>(
        builder: (context, state) {
          if (state is LaunchDetailsPageStateLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context
                  .read<LaunchDetailsPageCubit>()
                  .getLaunchDetails(widget.launchId),
              child: _Body(launch: state.launch),
            );
          } else if (state is LaunchDetailsPageStateError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final Launch launch;
  const _Body({Key? key, required this.launch}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.launch.name),
            background: _LaunchImage(launch: widget.launch),
          ),
          elevation: 0,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _LaunchTabBar(tabController: _tabController),
            _LaunchTabView(
              launch: widget.launch,
              tabController: _tabController,
            ),
          ]),
        ),
      ],
    );
  }
}

class _LaunchImage extends StatelessWidget {
  final Launch launch;
  const _LaunchImage({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          launch.image,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class _LaunchTabBar extends StatelessWidget {
  final TabController tabController;

  const _LaunchTabBar({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(),
          TabBar(
            controller: tabController,
            indicatorColor: context.theme.colorScheme.surface,
            tabs: [
              Tab(text: context.l10n.details),
              Tab(text: context.l10n.mission),
            ],
          ),
        ],
      ),
    );
  }
}

class _LaunchTabView extends StatelessWidget {
  final TabController tabController;
  final Launch launch;

  const _LaunchTabView({
    required this.tabController,
    required this.launch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: TabBarView(
        controller: tabController,
        children: [
          _LaunchDetails(launch: launch),
          _LaunchMission(launch: launch),
        ],
      ),
    );
  }
}

class _LaunchMission extends StatelessWidget {
  final Launch launch;
  const _LaunchMission({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TitledDetailsCard(
            title: context.l10n.missionDetails,
            child: Text(
              launch.mission?.description ?? context.l10n.noDescriptionProvided,
              style: context.theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _LaunchDetails extends StatelessWidget {
  final Launch launch;
  const _LaunchDetails({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parsedTime = DateTime.parse(launch.net);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.about,
            style: context.theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _DetailsCard(
            child: Column(
              children: [
                CountdownTimer(
                  net: launch.net,
                  launchStatus: launch.status.name,
                ),
                _LaunchDateInfo(
                  launchDate: DateFormat('dd MMMM yyyy').format(parsedTime),
                  launchTime: DateFormat('HH:mm').format(parsedTime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LaunchDateInfo extends StatelessWidget {
  final String launchDate;
  final String launchTime;

  const _LaunchDateInfo({
    required this.launchDate,
    required this.launchTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.launchDate,
          style: context.theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          launchDate,
          style: context.theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.launchTime,
          style: context.theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          launchTime,
          style: context.theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final Widget child;
  const _DetailsCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(minWidth: context.screenWidth),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
