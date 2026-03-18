import 'package:flutter/material.dart';
import '../widgets/particle_background.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  Widget infoItem(IconData icon, String text) {
    return Row(
      children: [

        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.orange),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    Color c1 = Color.lerp(Colors.orange, Colors.pink, _controller.value)!;
    Color c2 = Color.lerp(Colors.pink, Colors.purple, _controller.value)!;
    Color c3 = Color.lerp(Colors.purple, Colors.orange, _controller.value)!;

    return Scaffold(
      body: Stack(
        children: [

          /// Animated Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [c1, c2, c3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// Floating particles
          ParticleBackground(),

          /// Top navigation buttons
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: [

                KeyButton(
                  title: "Notice",
                  icon: Icons.campaign,
                  onTap: () {
                    Navigator.pushNamed(context, "/announcements");
                  },
                ),

                const SizedBox(width: 8),

                KeyButton(
                  title: "Activities",
                  icon: Icons.photo_library,
                  onTap: () {
                    Navigator.pushNamed(context, "/activities");
                  },
                ),

                const SizedBox(width: 8),

                KeyButton(
                  title: "Links",
                  icon: Icons.link,
                  onTap: () {
                    Navigator.pushNamed(context, "/links");
                  },
                ),
              ],
            ),
          ),

          /// White info card
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "बाल संस्कार वर्गाबद्दल",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 4,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [

                          Icon(Icons.favorite, color: Colors.orange),

                          SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              "नमस्कार 🙏\n\n"
                                  "मुलांसाठी काम करणे ही काळाची गरज ओळखून "
                                  "मनशक्ती लोणावळा केंद्र प्रेरित आणि पिंपरी चिंचवड "
                                  "स्थानिक केंद्र यांच्या साह्याने आम्ही गेल्या "
                                  "काही वर्षांपासून संस्कार वर्ग चालवत आहोत.",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    infoItem(Icons.video_call,
                        "संस्कार वर्ग आता ऑनलाईन पद्धतीने घेतला जातो"),

                    const SizedBox(height: 12),

                    infoItem(Icons.link,
                        "वर्गाची कायमस्वरूपी लिंक उपलब्ध आहे"),

                    const SizedBox(height: 12),

                    infoItem(Icons.people,
                        "कोणीही विद्यार्थी विनामूल्य सहभागी होऊ शकतो"),

                    const SizedBox(height: 12),

                    infoItem(Icons.schedule,
                        "दिलेल्या वेळेत लिंकवर क्लिक करून जॉईन करता येईल"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class KeyButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const KeyButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<KeyButton> {

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            pressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            pressed = false;
          });
          widget.onTap();
        },
        onTapCancel: () {
          setState(() {
            pressed = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
            boxShadow: pressed
                ? []
                : [
              const BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 4,
              )
            ],
          ),
          transform: pressed
              ? Matrix4.translationValues(0, 4, 0)
              : Matrix4.translationValues(0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(widget.icon, color: Colors.white),

              const SizedBox(width: 6),

              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
