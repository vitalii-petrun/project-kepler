import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/entities/mission.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';
import 'package:project_kepler/presentation/cubits/launch_details/launch_details_page_cubit.dart';
import 'package:project_kepler/presentation/pages/ai_chat_page.dart';
import 'package:project_kepler/presentation/widgets/chat_fab.dart';
import 'package:project_kepler/presentation/widgets/countdown_timer.dart';
import 'package:project_kepler/presentation/widgets/titled_details_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/agency.dart';
import '../../domain/entities/launch.dart';
import '../cubits/launch_details/launch_details_page_state.dart';
import '../widgets/no_internet.dart';

@RoutePage()
class LaunchDetailsPage extends StatefulWidget {
  final String launchId;
  final Launch launch;

  const LaunchDetailsPage(
      {Key? key,
      @PathParam('launchId') required this.launchId,
      required this.launch})
      : super(key: key);

  @override
  State<LaunchDetailsPage> createState() => _LaunchDetailsPageState();
}

class _LaunchDetailsPageState extends State<LaunchDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LaunchDetailsPageCubit>().getLaunchDetails(widget.launchId);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pageContext = {
      'launch': LaunchEntityToDtoConverter().convert(widget.launch).toJson(),
    };

    return Scaffold(
      floatingActionButton: ChatFAB(
        child: AIChat(pageContext: pageContext),
      ),
      body: BlocBuilder<LaunchDetailsPageCubit, LaunchDetailsPageState>(
        builder: (context, state) {
          if (state is LaunchDetailsPageStateLoaded) {
            return _LoadedBody(launch: state.launch, agency: state.agency);
          } else if (state is LaunchDetailsPageStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LaunchDetailsPageStateError) {
            return _FailedBody(launchId: widget.launchId);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _FailedBody extends StatelessWidget {
  final String launchId;

  const _FailedBody({
    required this.launchId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<LaunchDetailsPageCubit>().getLaunchDetails(launchId),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NoInternet(),
                    TextButton(
                      onPressed: () => context.router.pop(),
                      child: Text(context.l10n.goBack),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadedBody extends StatefulWidget {
  final Launch launch;
  final Agency? agency;

  const _LoadedBody({
    required this.launch,
    required this.agency,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const expandedHeight = 460.0;
    const collapsedHeight = 60.0;
    final theme = context.theme;
    return RefreshIndicator(
      onRefresh: () async => context
          .read<LaunchDetailsPageCubit>()
          .getLaunchDetails(widget.launch.id),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            backgroundColor: theme.colorScheme.background,
            pinned: true,
            iconTheme: IconThemeData(
              color: context.theme.colorScheme.onBackground,
            ),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.3,
              collapseMode: CollapseMode.pin,
              title: Text(
                widget.launch.name,
                style: theme.textTheme.headlineSmall!
                    .copyWith(color: theme.colorScheme.onBackground),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              background:
                  _LaunchImage(launch: widget.launch, agency: widget.agency),
            ),
          ),
          SliverToBoxAdapter(
            child: _LaunchDetails(launch: widget.launch, agency: widget.agency),
          ),
        ],
      ),
    );
  }
}

class _LaunchImage extends StatelessWidget {
  final Launch launch;
  final Agency? agency;

  const _LaunchImage({
    required this.launch,
    this.agency,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const expandedHeight = 500.0;
    const collapsedHeight = 60.0;
    final theme = context.theme;

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: expandedHeight - collapsedHeight - 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.darken),
                image: CachedNetworkImageProvider(
                    agency?.imageUrl ?? launch.image ?? context.l10n.unknown),
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
        ),
        Positioned(
          bottom: collapsedHeight + 40,
          left: context.screenWidth / 2 - 50,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: theme.colorScheme.background,
              shape: const CircleBorder(),
            ),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(launch.image ?? context.l10n.unknown),
              radius: 45,
            ),
          ),
        ),
      ],
    );
  }
}

class _LaunchDetails extends StatelessWidget {
  final Launch launch;
  final Agency? agency;

  const _LaunchDetails({
    required this.launch,
    this.agency,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parsedTime = DateTime.parse(launch.net);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "🚀 ${context.l10n.about}",
                style: context.theme.textTheme.headlineLarge,
              ),
            ),
          ),
          _DetailsCard(
            child: Column(
              children: [
                CountdownTimer(
                  net: launch.net,
                  launchStatus: launch.status.name,
                ),
                const SizedBox(height: 12),
                _LaunchDateInfo(
                  launchDate: DateFormat('dd MMMM yyyy').format(parsedTime),
                  launchTime: DateFormat('HH:mm').format(parsedTime),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (launch.mission?.description != null)
            TitledDetailsCard(
              title: context.l10n.missionDetails,
              child: _MissionDetails(
                mission: launch.mission as Mission,
              ),
            ),
          TitledDetailsCard(
            title: context.l10n.rocketConfiguration,
            child: _RocketConfigurationTable(
              rocketConfiguration: launch.rocket.configuration,
            ),
          ),
          const SizedBox(height: 8),
          TitledDetailsCard(
            title: context.l10n.agencyInformaton,
            child: agency != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      agency?.logoUrl != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: agency!.logoUrl as String,
                                height: 80,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 12),
                      _InfoRow(
                          icon: Icons.location_on,
                          title: context.l10n.name,
                          value: agency?.name ?? context.l10n.unknown),
                      const SizedBox(height: 8),
                      Flexible(
                        child: Text(
                          agency?.description ??
                              context.l10n.noDescriptionProvided,
                          style: context.theme.textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                          icon: Icons.location_city,
                          title: context.l10n.counryCode,
                          value: agency?.countryCode ?? context.l10n.unknown),
                      _InfoRow(
                          icon: Icons.business_center,
                          title: context.l10n.type,
                          value: agency?.type ?? context.l10n.unknown),
                      _InfoRow(
                          icon: Icons.language,
                          title: context.l10n.abbrev,
                          value: agency?.abbrev ?? context.l10n.unknown),
                      _InfoRow(
                          icon: Icons.person,
                          title: context.l10n.administrator,
                          value: agency?.administrator ?? context.l10n.unknown),
                    ],
                  )
                : Text(context.l10n.noAgencyInformation),
          )
        ],
      ),
    );
  }
}

class _MissionDetails extends StatelessWidget {
  final Mission mission;

  const _MissionDetails({
    required this.mission,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(
          children: [
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.info,
              ),
            ),
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: SizedBox(width: 8),
            ),
            TextSpan(
              text: mission.description,
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _RocketConfigurationTable extends StatelessWidget {
  final RocketConfiguration rocketConfiguration;

  const _RocketConfigurationTable({
    required this.rocketConfiguration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rocketManufacturer = rocketConfiguration.manufacturer;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rocketManufacturer?.logoUrl != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          rocketManufacturer?.logoUrl ?? context.l10n.unknown,
                      height: 80,
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 8),
          _InfoRow(
              icon: Icons.confirmation_number,
              title: context.l10n.name,
              value: rocketConfiguration.fullName),
          _InfoRow(
              icon: Icons.code,
              title: context.l10n.family,
              value: rocketConfiguration.family),
          _InfoRow(
              icon: Icons.precision_manufacturing,
              title: context.l10n.manufacturer,
              value: rocketManufacturer?.name ?? context.l10n.unknown),
          Text(rocketManufacturer?.description ?? context.l10n.unknown),
          const SizedBox(height: 4),
          _InfoRow(
              icon: Icons.location_city,
              title: context.l10n.counryCode,
              value: rocketManufacturer?.countryCode ?? context.l10n.unknown),
          InkWell(
            child: _InfoRow(
              icon: Icons.link,
              title: context.l10n.wiki,
              value: rocketConfiguration.wikiUrl ?? context.l10n.noWikiProvided,
            ),
            onTap: () => launchUrl(
              Uri.parse(rocketConfiguration.wikiUrl ?? context.l10n.unknown),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String value;

  const _InfoRow({
    required this.title,
    this.icon,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: context.theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: context.theme.textTheme.bodyLarge,
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
