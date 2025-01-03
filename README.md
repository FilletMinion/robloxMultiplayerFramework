# robloxMultiplayerFramework
Allows multiplayer games give the speed and low latency of client-side while maintaining server-side security 

1.Where to put scripts
 Replicated Storage:
   *inputController (module script) : modulescript which handles all player inputs and and camera tracking
   *playerClass (module script) : contains all variables needed for player to function in the game such as combat stats and state logic
   *weaponClass (module script) : create weapon objects with specified stats. can also create subclass weapons with additional abiilties 
 Server SCript Service:
  *sessionData (module script) : has tables to hold all player data
  *playerInit (Script) : initializses player objects and loads them into sessionData, also maintains security in event handling
 Starter Player Scripts:
  *localController: initializes the player's inputController, also ensures that additional inputControllers won't be valid for security

