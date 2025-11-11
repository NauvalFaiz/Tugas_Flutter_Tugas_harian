import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderSection(),

              // Search Bar
              _buildSearchBar(),

              // Main Menu Grid
              _buildMenuGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),

          // User Name
          const Text(
            'Nauval Faiz',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    final List<MenuItems> menuItems = [
      MenuItems('Academics', Icons.school, Colors.blue),
      MenuItems('Students', Icons.people, Colors.green),
      MenuItems('Teachers', Icons.person, Colors.orange),
      MenuItems('Attendance', Icons.check_circle, Colors.purple),
      MenuItems('Syllabus', Icons.menu_book, Colors.red),
      MenuItems('Time Table', Icons.schedule, Colors.teal),
      MenuItems('Assignments', Icons.assignment, Colors.indigo),
      MenuItems('Exams', Icons.quiz, Colors.amber),
      MenuItems('Results', Icons.assessment, Colors.deepOrange),
      MenuItems('Fees', Icons.payment, Colors.brown),
      MenuItems('Events', Icons.event, Colors.pink),
      MenuItems('Inbox', Icons.inbox, Colors.cyan),
      MenuItems('Ask Doubt', Icons.help, Colors.lightGreen),
      MenuItems('E-Learning', Icons.computer, Colors.deepPurple),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(menuItems[index]);
      },
    );
  }

  Widget _buildMenuItem(MenuItems item) {
    return GestureDetector(
      onTap: () {
        // Handle menu item tap
        print('${item.title} tapped');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItems {
  final String title;
  final IconData icon;
  final Color color;

  MenuItems(this.title, this.icon, this.color);
}
