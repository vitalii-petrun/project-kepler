import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/widgets/no_internet.dart';
import '../../domain/entities/firestore_user.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/users_page/Users_page_state.dart';
import '../blocs/users_page/users_page_cubit.dart';
import '../widgets/space_drawer.dart';
import '../widgets/user_row.dart';

@RoutePage()
class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersPageCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(context.l10n.users),
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
      body: BlocBuilder<UsersPageCubit, UsersPageState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return _LoadedBody(users: state.users);
          } else if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersError) {
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
  final List<FirestoreUser> users;

  const _LoadedBody({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<UsersPageCubit>().fetchUsers(),
      child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserRow(
              user: users[index],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20)),
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
          onRefresh: () async => context.read<UsersPageCubit>().fetchUsers(),
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
