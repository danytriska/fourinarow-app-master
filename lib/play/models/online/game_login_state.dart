import 'package:flutter/foundation.dart';
import 'package:four_in_a_row/connection/messages.dart';
import 'package:four_in_a_row/play/models/online/game_state_manager.dart';

abstract class GameLoginState with ChangeNotifier {
  final GameStateManager gsm;

  GameLoginState(this.gsm);

  GameLoginState? handleServerMessage(ServerMessage msg);

  GameLoginState? handlePlayerMessage(PlayerMessage msg);
}

class GameLoginLoggedOut extends GameLoginState {
  GameLoginLoggedOut(GameStateManager gsm) : super(gsm);

  @override
  GameLoginState? handleServerMessage(ServerMessage msg) {
    return null;
  }

  @override
  GameLoginState? handlePlayerMessage(PlayerMessage msg) {
    if (msg is PlayerMsgLogin) {
      return GameLoginWaitingForResponse(gsm);
    }
    return null;
  }
}

class GameLoginWaitingForResponse extends GameLoginState {
  GameLoginWaitingForResponse(GameStateManager gsm) : super(gsm);

  int messagesSinceListening = 0;

  @override
  GameLoginState? handleServerMessage(ServerMessage msg) {
    if (msg is MsgLoginResponse) {
      if (msg.success) {
        return GameLoginLoggedIn(gsm);
      } else {
        return GameLoginError(gsm);
      }
    } else {
      messagesSinceListening += 1;
      if (messagesSinceListening > 2) {
        return GameLoginError(gsm);
      }
      return null;
    }
  }

  @override
  GameLoginState? handlePlayerMessage(PlayerMessage msg) {
    if (msg is PlayerMsgLogout) {
      return GameLoginLoggedOut(gsm);
    }
    return null;
  }
}

class GameLoginError extends GameLoginState {
  GameLoginError(GameStateManager gsm) : super(gsm);

  @override
  GameLoginState? handlePlayerMessage(PlayerMessage msg) {
    return null;
  }

  @override
  GameLoginState? handleServerMessage(ServerMessage msg) {
    if (msg is PlayerMsgLogout) {
      return GameLoginLoggedOut(gsm);
    }
    return null;
  }
}

class GameLoginLoggedIn extends GameLoginState {
  GameLoginLoggedIn(GameStateManager gsm) : super(gsm);

  @override
  GameLoginState? handleServerMessage(ServerMessage msg) {
    return null;
  }

  @override
  GameLoginState? handlePlayerMessage(PlayerMessage msg) {
    if (msg is PlayerMsgLogout) {
      return GameLoginLoggedOut(gsm);
    }
    return null;
  }
}
