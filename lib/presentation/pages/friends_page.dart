import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../domain/entities/user.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/friends_page/friends_page_cubit.dart';
import '../blocs/friends_page/friends_page_state.dart';
import '../widgets/space_drawer.dart';

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
    context.read<FriendsPageCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(context.l10n.family), // TODO: replace text
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

class _LoadedBody extends StatelessWidget {
  final List<User> users;

  const _LoadedBody({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<FriendsPageCubit>().fetch(),
      child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserRow(
              user: users[index],
              onFollowPressed: () {
                // Handle the follow button press, e.g., add user to followers
                // You can replace this with your actual logic
                print('Follow button pressed for ${users[index].displayName}');
              },
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
    );
  }
}

class UserRow extends StatelessWidget {
  final User user;
  final VoidCallback onFollowPressed;

  const UserRow({
    Key? key,
    required this.user,
    required this.onFollowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle the tap, e.g., navigate to the user's profile page
        print('Tapped on ${user.displayName}\'s profile');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.photoURL ??
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onFollowPressed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(context.l10n.follow),
              ),
            ],
          ),
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
          onRefresh: () async => context.read<FriendsPageCubit>().fetch(),
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
