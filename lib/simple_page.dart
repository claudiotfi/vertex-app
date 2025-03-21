import 'package:flutter/material.dart';
import 'package:vertex/main_layout.dart';

class SimplePage extends StatelessWidget {
  const SimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( // Permite rolagem
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lorem ipsum dolor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent volutpat, turpis et interdum eleifend, sem dolor dictum orci, quis viverra felis nulla ornare metus. Pellentesque posuere posuere urna ut auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at velit turpis. Donec eu rutrum mauris. Maecenas lobortis mauris sed turpis euismod feugiat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed eget libero ipsum. ',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ut porta arcu at',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ut porta arcu at sapien condimentum, vel pellentesque mi eleifend. In hac habitasse platea dictumst. Aliquam a volutpat ex, ac efficitur nibh. Integer luctus leo ut leo lobortis, a condimentum velit tempor. Sed tristique rhoncus gravida. Nullam blandit metus volutpat felis posuere placerat. Mauris tortor turpis, fermentum laoreet leo et, viverra blandit tellus. Sed blandit, mauris eget consectetur lacinia, erat urna faucibus diam, sit amet convallis elit ipsum sed tellus. Praesent metus lorem, consectetur quis fermentum at, mollis id erat. ',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
