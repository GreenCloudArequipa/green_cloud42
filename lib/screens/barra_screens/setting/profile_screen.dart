import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cloud/models/store_model.dart';
import 'package:green_cloud/models/user.dart';
import 'package:green_cloud/models/achievements_model.dart';
import 'package:green_cloud/screens/barra_screens/setting/statistics_screen.dart';
import 'package:green_cloud/screens/barra_screens/setting/settings_screen.dart';
import 'package:green_cloud/screens/barra_screens/setting/friends_screen.dart';
import 'package:green_cloud/screens/barra_screens/setting/global_screen.dart';
import 'package:green_cloud/screens/barra_screens/Rank/rank.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StoreModel, UserModel>(
        builder: (context, storeModel, userModel, child) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            _buildProfileHeader(storeModel, userModel, context),
            _buildTabBar(),
            _buildTabBarView(),
          ],
        ),
      );
    });
  }

  Widget _buildProfileHeader(
      StoreModel storeModel, UserModel userModel, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icono de estadísticas
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatisticsScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.analytics, color: Colors.blue),
                ),
              ),

              // Avatar de usuario con monedas
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(userModel.profileImage),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${storeModel.coins}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        const Icon(Icons.monetization_on,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ],
              ),

              // Icono de ajustes
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.settings, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            userModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Nivel ${userModel.level}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${userModel.experiencePoints}/${userModel.experienceToNextLevel} EXP',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('${(userModel.experienceProgress * 100).toInt()}%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: userModel.experienceProgress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.green,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          _buildStoreItemsSection(storeModel),
          const SizedBox(height: 10),
          _buildAchievementsSection(context),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.green,
      tabs: const [
        Tab(text: 'Amigos'),
        Tab(text: 'Global'),
      ],
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildFriendsTab(),
          _buildGlobalTab(),
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mis amigos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FriendsScreen()),
                      );
                    },
                    child: Text(
                      'Ver más',
                      style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: userModel.friends.length,
                  itemBuilder: (context, index) {
                    final friend = userModel.friends[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(friend.profileImage),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.monetization_on,
                                  color: Colors.white, size: 10),
                            ),
                          ],
                        ),
                        title: Text(friend.name),
                        subtitle: LinearProgressIndicator(
                          value: friend.experienceProgress,
                          backgroundColor: Colors.grey[300],
                          color: Colors.green,
                        ),
                        trailing: Text('Nivel ${friend.level}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlobalTab() {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ranking global',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: UserSearchDelegate(userModel),
                          );
                        },
                        child: const Icon(Icons.search, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GlobalScreen()),
                          );
                        },
                        child: Text(
                          'Ver más',
                          style:
                              TextStyle(fontSize: 12, color: Colors.blue[700]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: userModel.globalUsers.length,
                  itemBuilder: (context, index) {
                    final user = userModel.globalUsers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(user.profileImage),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.monetization_on,
                                  color: Colors.white, size: 10),
                            ),
                          ],
                        ),
                        title: Text(user.name),
                        subtitle: LinearProgressIndicator(
                          value: user.experienceProgress,
                          backgroundColor: Colors.grey[300],
                          color: Colors.green,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Nivel ${user.level}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            if (!user.isFriend)
                              IconButton(
                                icon: const Icon(Icons.person_add, size: 18),
                                onPressed: () {
                                  // Lógica para añadir amigo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Solicitud de amistad enviada a ${user.name}')),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoreItemsSection(StoreModel storeModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItemCategory(
              'Fondos',
              storeModel.getPurchasedCountByCategory('Fondos'),
              Icons.wallpaper),
          _buildItemCategory(
              'Macetas',
              storeModel.getPurchasedCountByCategory('Macetas'),
              Icons.featured_play_list),
          _buildItemCategory('Pets',
              storeModel.getPurchasedCountByCategory('Pets'), Icons.pets),
          _buildItemCategory(
              'Accesorios',
              storeModel.getPurchasedCountByCategory('Accesorios'),
              Icons.category),
        ],
      ),
    );
  }

  Widget _buildItemCategory(String title, String count, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.teal),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Consumer<AchievementsModel>(
      builder: (context, achievementsModel, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Logros',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogrosScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAchievementCategory(
                    'Medallas',
                    achievementsModel.getMedalsProgress(),
                    Icons.emoji_events,
                    Colors.pink[200]!,
                  ),
                  _buildAchievementCategory(
                    'Plantas',
                    achievementsModel.getPlantsProgress(),
                    Icons.eco,
                    Colors.green[300]!,
                  ),
                  _buildAchievementCategory(
                    'Criaturas',
                    achievementsModel.getCreaturesProgress(),
                    Icons.pets,
                    Colors.orange[300]!,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementCategory(
      String title, String progress, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          progress,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final UserModel userModel;

  UserSearchDelegate(this.userModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = userModel.searchUsers(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(user.profileImage),
          ),
          title: Text(user.name),
          subtitle: Text(user.username),
          trailing: Text('Nivel ${user.level}'),
        );
      },
    );
  }
}
