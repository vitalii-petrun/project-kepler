import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

import '../../domain/entities/event.dart';

import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/events_page/events_cubit.dart';
import '../cubits/events_page/events_state.dart';

import '../widgets/event_card.dart';

import '../widgets/rounded_app_bar.dart';

import '../widgets/shimmer_loading_body.dart';

@RoutePage()
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    //context.read<EventsCubit>().fetch();
    //It's already being fetched on the Home Page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(
        title: Text(context.l10n.astroEvents),
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
        child: BlocConsumer<EventsCubit, EventsPageState>(
          listener: (context, state) {
            debugPrint('EventsPageState: $state');
            if (state is EventsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  action: SnackBarAction(
                    label: context.l10n.retry,
                    onPressed: () => context.read<EventsCubit>().fetch(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is EventsLoading || state is EventsInit) {
              return const ShimmerLoadingBody();
            } else if (state is EventsLoaded) {
              return _LoadedBody(events: state.events);
            } else if (state is EventsError) {
              return const _FailedBody(message: 'Failed to load events');
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final List<Event> events;

  const _LoadedBody({
    required this.events,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<EventsCubit>().fetch(),
      child: ListView.separated(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: EventCard(event: event, eventId: event.id),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
    );
  }
}

class _FailedBody extends StatelessWidget {
  final String message;

  const _FailedBody({Key? key, this.message = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async => context.read<EventsCubit>().fetch(),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Center(
                    child: Text(message,
                        style: context.theme.textTheme.titleLarge)),
              )),
        );
      },
    );
  }
}
