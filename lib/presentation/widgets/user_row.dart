import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../../domain/entities/firestore_user.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/authentication/authentication_state.dart';

class UserRow extends StatelessWidget {
  final FirestoreUser user;

  const UserRow({
    Key? key,
    required this.user,
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
              _UserAvatar(photoURL: user.photoURL),
              const SizedBox(width: 10),
              Expanded(
                child: _UserInfo(
                  displayName: user.displayName,
                  email: user.email,
                ),
              ),
              _FollowButton(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final String? photoURL;

  const _UserAvatar({
    Key? key,
    required this.photoURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(photoURL ??
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String displayName;
  final String email;

  const _UserInfo({
    Key? key,
    required this.displayName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          email,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _FollowButton extends StatelessWidget {
  final FirestoreUser user;

  const _FollowButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return _FollowButtonLogic(user: user);
        } else {
          return Container(); // Placeholder, you might want to handle this case differently
        }
      },
    );
  }
}

class _FollowButtonLogic extends StatelessWidget {
  final FirestoreUser user;

  const _FollowButtonLogic({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return Container();
        } else if (state is Authenticated) {
          return _FollowButtonWidget(
            user: user,
            currentUserUid: state.user.uid,
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _FollowButtonWidget extends StatefulWidget {
  final FirestoreUser user;
  final String currentUserUid;

  const _FollowButtonWidget({
    Key? key,
    required this.user,
    required this.currentUserUid,
  }) : super(key: key);

  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<_FollowButtonWidget> {
  late bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    handleCheckIfFollowing();
  }

  handleCheckIfFollowing() async {
    await checkIfFollowing();
  }

  Future<void> checkIfFollowing() async {
    try {
      DocumentReference currentUserDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserUid);

      // Check if the user is already following
      DocumentSnapshot followDoc = await currentUserDocRef
          .collection('user_friends')
          .doc(widget.user.uid)
          .get();

      setState(() {
        isFollowing = followDoc.exists;
      });
    } catch (e) {
      print('Error checking if user is following: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          DocumentReference currentUserDocRef = FirebaseFirestore.instance
              .collection('users')
              .doc(widget.currentUserUid);

          if (isFollowing) {
            // Unfollow logic
            await currentUserDocRef
                .collection('user_friends')
                .doc(widget.user.uid)
                .delete();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Unfollowed ${widget.user.displayName}'),
            ));
          } else {
            // Follow logic
            await currentUserDocRef
                .collection('user_friends')
                .doc(widget.user.uid)
                .set({
              'friend_id': widget.user.uid,
              'friend_display_name': widget.user.displayName,
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Followed ${widget.user.displayName}'),
            ));
          }

          setState(() {
            isFollowing = !isFollowing;
          });
        } catch (e) {
          print('Error following/unfollowing user: $e');
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        isFollowing ? context.l10n.unfollow : context.l10n.follow,
      ),
    );
  }
}
