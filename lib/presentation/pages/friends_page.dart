import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/entities/firestore_user.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/friends_page/friends_page_cubit.dart';
import '../cubits/friends_page/friends_page_state.dart';
import '../widgets/space_drawer.dart';
import '../widgets/user_row.dart';

@RoutePage()
class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    super.initState();
    handleFetch();
  }

  void handleFetch() {
    var state = context.read<AuthenticationCubit>().state;
    if (state is Authenticated) {
      final String id = state.user.uid;
      context.read<FriendsPageCubit>().fetchFriends(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(context.l10n.friends),
        actions: [
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
      body: BlocBuilder<FriendsPageCubit, FriendsPageState>(
        builder: (context, state) {
          if (state is FriendsLoaded) {
            return _LoadedBody(users: state.users);
          } else if (state is FriendsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FriendsError) {
            return const _FailedBody();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _GuidancePanel extends StatelessWidget {
  const _GuidancePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.group, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          const Text(
            'Connect with Others!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore the users page to find new friends and connections.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.router.pushNamed('/users'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Discover Users'),
          ),
        ],
      ),
    );
  }
}

class _LoadedBody extends StatefulWidget {
  final List<FirestoreUser> users;

  const _LoadedBody({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody> {
  late List<FirestoreUser> users;

  @override
  void initState() {
    super.initState();
    users = widget.users;
  }

  void handleFetch() {
    var state = context.read<AuthenticationCubit>().state;
    if (state is Authenticated) {
      final String id = state.user.uid;
      context.read<FriendsPageCubit>().fetchFriends(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => handleFetch(),
      child: Column(
        children: [
          const _GuidancePanel(),
          Expanded(
            child: ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserRow(
                    user: users[index],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 20)),
          ),
        ],
      ),
    );
  }
}

class _FailedBody extends StatefulWidget {
  const _FailedBody({Key? key}) : super(key: key);

  @override
  State<_FailedBody> createState() => _FailedBodyState();
}

class _FailedBodyState extends State<_FailedBody> {
  void handleFetch() {
    var state = context.read<AuthenticationCubit>().state;
    if (state is Authenticated) {
      final String id = state.user.uid;
      context.read<FriendsPageCubit>().fetchFriends(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async => handleFetch(),
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
