@tool
class_name Constants

enum GameplayStates {
  WAITING_ON_TAVERN,
  ENTERED_DUNGEON,
  ENTERED_BATTLE,
  DEFEAT,
  VICTORY,
}

static var GameplayStatesNames = {
  GameplayStates.WAITING_ON_TAVERN: "WAITING_ON_TAVERN",
  GameplayStates.ENTERED_DUNGEON: "ENTERED_DUNGEON",
  GameplayStates.ENTERED_BATTLE: "ENTERED_BATTLE",
  GameplayStates.DEFEAT: "DEFEAT",
  GameplayStates.VICTORY: "VICTORY",
}

enum BattleStates {
  ROUND_START,
  DRAG_A_CART,
  DROP_ON_REGION,
  PREVIEW_EFFECTS,
  CONFIRM_SELECTION,
  RUN_TIMELINE,
  END_BATTLE,
}

static var BattleStatesNames = {
  BattleStates.ROUND_START: "ROUND_START",
  BattleStates.DRAG_A_CART: "DRAG_A_CART",
  BattleStates.DROP_ON_REGION: "DROP_ON_REGION",
  BattleStates.PREVIEW_EFFECTS: "PREVIEW_EFFECTS",
  BattleStates.CONFIRM_SELECTION: "CONFIRM_SELECTION",
  BattleStates.RUN_TIMELINE: "RUN_TIMELINE",
  BattleStates.END_BATTLE: "END_BATTLE",
}
