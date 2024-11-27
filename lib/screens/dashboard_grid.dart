import 'package:flutter/material.dart';

import 'dashboard_tile.dart';

class DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.2, // Adjust for square or rectangular tiles
        ),
        itemCount: 6, // Example number of tiles
        itemBuilder: (context, index) {
          return DashboardTile(
            title: 'Tile $index',
            icon: Icons.dashboard,
            onTap: () {
              print('Tile $index tapped');
            },
          );
        },
      ),
    );
  }
}
