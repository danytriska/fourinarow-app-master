import 'package:flutter/material.dart';
import 'package:four_in_a_row/play/models/online/game_states/game_state.dart';

class IdleViewer extends StatelessWidget {
  final IdleState state;

  IdleViewer(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('An error occurred. Please restart the app.'));
  }
}
