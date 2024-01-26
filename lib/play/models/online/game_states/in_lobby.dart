import 'package:four_in_a_row/connection/messages.dart';
import 'package:four_in_a_row/play/models/online/game_state_manager.dart';
import 'package:four_in_a_row/play/models/online/game_states/game_state.dart';

class InLobbyState extends GameState {
  final String? code;

  InLobbyState(GameStateManager gsm, this.code) : super(gsm);

  @override
  GameState? handlePlayerMessage(PlayerMessage msg) {
    return super.handlePlayerMessage(msg);
  }

  @override
  GameState? handleServerMessage(ServerMessage msg) {
    if (msg is MsgOppJoined) {
      return InLobbyReadyState(super.gsm);
    }
    return super.handleServerMessage(msg);
  }
}

class InLobbyReadyState extends GameState {
  InLobbyReadyState(GameStateManager gsm) : super(gsm);

  @override
  GameState? handlePlayerMessage(PlayerMessage msg) {
    return super.handlePlayerMessage(msg);
  }

  @override
  GameState? handleServerMessage(ServerMessage msg) {
    if (msg is MsgGameStart) {
      return PlayingState(
        super.gsm,
        myTurnToStart: msg.myTurn,
        opponentId: msg.opponentId,
      );
    }
    return super.handleServerMessage(msg);
  }
}
