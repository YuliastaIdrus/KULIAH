import 'package:flutter/material.dart';

void main() {
  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FOTO STORY (PASTI BISA DIAKSES)
    final List<Map<String, String>> stories = [
      {'name': 'Yuliasta', 'image': 'https://picsum.photos/id/1005/100/100'},
      {'name': 'Rahma', 'image': 'https://picsum.photos/id/1011/100/100'},
      {'name': 'Raka', 'image': 'https://picsum.photos/id/1012/100/100'},
      {'name': 'Budi', 'image': 'https://picsum.photos/id/1015/100/100'},
      {'name': 'Dewi', 'image': 'https://picsum.photos/id/1021/100/100'},
      {'name': 'Zahra', 'image': 'https://picsum.photos/id/1027/100/100'},
      {'name': 'Rani', 'image': 'https://picsum.photos/id/1033/100/100'},
      {'name': 'Putra', 'image': 'https://picsum.photos/id/1037/100/100'},
    ];

    // FOTO POSTINGAN (PASTI BISA DIAKSES)
    final List<Map<String, String>> posts = [
      {
        'profile': 'https://picsum.photos/id/1042/100/100',
        'username': 'yuliasta',
        'image': 'https://picsum.photos/id/1050/600/600',
        'liked': 'rahma',
        'description': 'Menikmati senja sore di pantai 🌅',
      },
      {
        'profile': 'https://picsum.photos/id/1049/100/100',
        'username': 'devgram',
        'image': 'https://picsum.photos/id/1062/600/600',
        'liked': 'dimas',
        'description': 'Belajar Flutter bikin semangat 🚀',
      },
      {
        'profile': 'https://picsum.photos/id/1074/100/100',
        'username': 'code_life',
        'image': 'https://picsum.photos/id/1084/600/600',
        'liked': 'putri',
        'description': 'Ngopi sambil debugging ☕💻',
      },
      {
        'profile': 'https://picsum.photos/id/1080/100/100',
        'username': 'flutter.dev',
        'image': 'https://picsum.photos/id/1081/600/600',
        'liked': 'budi',
        'description': 'UI dark mode favoritku! 😍',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Instagram',
          style: TextStyle(fontFamily: 'Roboto', fontSize: 24),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.favorite_border),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.send),
          ),
        ],
      ),

      // ======== BODY =========
      body: Column(
        children: [
          // ============= STORIES BAR =============
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // CIRCLE WITH RED BORDER
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.red, Colors.pinkAccent],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(story['image']!),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        story['name']!,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ============= FEED SECTION =============
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====== PROFILE INFO ======
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(post['profile']!),
                      ),
                      title: Text(
                        post['username']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),

                    // ====== IMAGE ======
                    Image.network(
                      post['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 350,
                    ),

                    // ====== ICONS ======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: const [
                          Icon(Icons.favorite_border, size: 28),
                          SizedBox(width: 15),
                          Icon(Icons.mode_comment_outlined, size: 28),
                          SizedBox(width: 15),
                          Icon(Icons.send, size: 28),
                          Spacer(),
                          Icon(Icons.bookmark_border, size: 28),
                        ],
                      ),
                    ),

                    // ====== LIKED TEXT ======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Disukai oleh ${post['liked']} dan 1 lainnya',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // ====== DESCRIPTION ======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${post['username']} ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            TextSpan(
                              text: post['description'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // ======== BOTTOM NAVIGATION =========
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
