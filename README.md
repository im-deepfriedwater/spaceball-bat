# spaceball-bat
be the baseball bat you've always wanted to be



# Discord Rich Presence Integration 

Spaceball Bat shows up on a user's profile in Discord if they have Discord activity status enabled in their settings. We achieve this through a third party Godot Discord SDK plugin [(by samsface),](https://github.com/samsface) Discord's SDK, and a singleton that initializes the Discord status, and then also subscribes to events to update the status based on score. 

## Building/Running Discord Rich Presence

We do not include Discord's SDK on the repository as it's not open source. While it's included on released builds, in order for to do local builds or have it running in development you need to separately [download the latest SDK from Discord](https://discord.com/developers/docs/game-sdk/sdk-starter-guide) and extract the .DLLs, .lib, .dylib, and .so of the specific platform (like the contents of Discord_game_sdk\lib\x86_64)  into src\addons\discord_game_sdk. There are also instructions included in the [Godot Discord SDK plugin](https://github.com/samsface/godot-discord-game-sdk) repository with a helpful YouTube tutorial for a visual reference and there's an example scene included on the de

### Additional required setup on Discord's Developer Console

In addition to the aforementioned setup, we need to create an application on Discord's own developer portal. Through here, we're able to specify our application ID (which is safe to share) within the plugin and also upload visual assets so we can have icons show up on the Discord status. With the application ID, we have to pass into to the Godot Discord plugin at src\addons\discord_game_sdk on line 263. 

### How it works 

The plugin introduces a new Discord singleton handles initialization and exposes helper methods to call for us to make calls to Discord's SDK. We call methods from this Discord singleton from our own new singleton called src\scripts\singletons\DiscordRichPresenceSingleton.gd which initializes and subscribes to various events to update the score automatically.

