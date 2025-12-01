import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/app_user.dart';
import '../../../providers.dart';
import '../../../utils/app_icons.dart';

class LeftPane extends ConsumerWidget {
  const LeftPane({super.key, required this.onRoomSelected});

  final void Function(String roomId, AppUser user) onRoomSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final userStream = ref.watch(userServiceProvider).searchUsers(query);

    return Container(
      width: 420,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1D2B53),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Text(
                  "People",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: "Logout",
                  splashRadius: 20,
                  icon: Image.asset(
                    AppIcons.settings,
                    height: 20,
                    width: 20,
                    color: Colors.white,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  onPressed: () async {
                    await ref.read(authServiceProvider).logout();
                    ref.read(selectedRoomProvider.notifier).state = null;
                    ref.read(selectedUserProvider.notifier).state = null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SearchField(
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: StreamBuilder<List<AppUser>>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                            ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final users = snapshot.data ?? [];

                    if (users.isEmpty) {
                      return const Center(
                        child: Text(
                          "No contacts yet",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return _UserTile(
                          user: user,
                          onTap: () async {
                            final roomId = await ref
                                .read(chatServiceProvider)
                                .findOrCreateDM(user.id);

                            onRoomSelected(roomId, user);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search people',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            AppIcons.search,
            height: 18,
            width: 18,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.2),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({
    required this.user,
    required this.onTap,
  });

  final AppUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: colorScheme.surface,
                  backgroundImage:
                      user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
                  child: user.photoUrl.isEmpty
                      ? Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _PresenceDot(isOnline: user.isOnline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PresenceDot extends StatelessWidget {
  const _PresenceDot({required this.isOnline});

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isOnline ? Colors.greenAccent : Colors.white30,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );
  }
}
 
