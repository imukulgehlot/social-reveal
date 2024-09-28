import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:rstsocial/core/basic_features.dart';

class CustomLikeReactionButton extends StatelessWidget {
  const CustomLikeReactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactionButton<String>(
      onReactionChanged: (Reaction<String>? reaction) {
        debugPrint('Selected value: ${reaction?.value}');
      },
      reactions: const <Reaction<String>>[
        Reaction<String>(
          value: 'like',
          icon: Icon(Icons.add),
        ),
        Reaction<String>(
          value: 'love',
          icon: Icon(Icons.back_hand),
        ),
        Reaction<String>(
          value: 'love',
          icon: Icon(Icons.catching_pokemon),
        ),
      ],
      selectedReaction: const Reaction<String>(
        value: 'like_fill',
        icon: Icon(Icons.add),
      ),
      itemSize: Size(Dimensions.w20, Dimensions.h20),
    );
  }
}
