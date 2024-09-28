import 'package:flutter/material.dart';
import 'package:rstsocial/core/model/ui_model/sample_data.dart';
import 'package:rstsocial/custom/post_tile.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          PostTile(
            model: SampleData.samplePosts[2],
            noComments: true,
          ),
          PostTile(
            model: SampleData.samplePosts[4],
            noComments: true,
          ),
          PostTile(
            model: SampleData.samplePosts[1],
            noComments: true,
          ),
        ],
      ),
    );
  }
}
