# robloxMultiplayerFramework
Allows multiplayer games give the speed and low latency of client-side while maintaining server-side security 

1.Where to put scripts:

inputController, playerClass, and weaponClass go in ReplicatedStorage.
  *inputController = modulescript which handles all player inputs and and camera tracking
  *playerClass = contains all variables needed for player to function in the game such as combat stats and state logic
  *weaponClass = create weapon objects with specified stats. can also create subclass weapons with additional abiilties 
