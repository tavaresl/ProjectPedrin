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
