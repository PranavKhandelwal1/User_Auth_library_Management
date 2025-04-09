import 'package:flutter/material.dart';
import 'package:library_management/constants/app_colors.dart';
import 'package:library_management/modals/user_model.dart';
import 'package:library_management/screens/login_screen.dart';
import 'package:library_management/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of widget pages that will be displayed when bottom nav items are selected
    final List<Widget> widgetOptions = <Widget>[
      _buildDashboardContent(),
      const Center(child: Text('Books')),
      const Center(child: Text('Search')),
      const Center(child: Text('Profile')),
    ];

    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog
        return await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library Management'),
        ),
        drawer: _buildDrawer(context),
        body: SafeArea(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize:  const Size.square(64.0),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                widget.user.fullName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 32.0,
                  color: AppColors.primary,
                ),
              ),
            ),
            accountName: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.user.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.email),
                const SizedBox(height: 2),
                Text(
                  widget.user.phoneNumber,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
            isSelected: _selectedIndex == 0,
          ),
          _buildDrawerItem(
            icon: Icons.library_books,
            title: 'My Books',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.history,
            title: 'Borrowing History',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.favorite,
            title: 'Favorites',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(context),
            textColor: Colors.red,
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : (iconColor ?? Colors.grey[700]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : (textColor ?? Colors.black87),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              widget.user.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildStatCard(),
            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  'Browse Books',
                  Icons.menu_book,
                  Colors.blue.shade100,
                      () {},
                ),
                _buildActionCard(
                  'Borrow Book',
                  Icons.library_add,
                  Colors.green.shade100,
                      () {},
                ),
                _buildActionCard(
                  'Return Book',
                  Icons.assignment_return,
                  Colors.orange.shade100,
                      () {},
                ),
                _buildActionCard(
                  'My Fines',
                  Icons.attach_money,
                  Colors.red.shade100,
                      () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Books\nBorrowed', '3'),
            _verticalDivider(),
            _buildStatItem('Books\nDue', '1'),
            _verticalDivider(),
            _buildStatItem('Total\nFines', '\$0'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildActionCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                // Perform logout
                await AuthService.logout();
                if (mounted) {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false, // Remove all previous routes
                  );
                }
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(color: Colors.redAccent,),
              ),
            ),
          ],
        );
      },
    );
  }
}
//show a confirmation dialog
Future<bool> _showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Don't exit
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Exit
            },
            child: const Text(
              'EXIT',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  ) ?? false; // Return false if dialog is dismissed
}