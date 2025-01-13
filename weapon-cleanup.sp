Here's the complete updated plugin code:

```cpp
#pragma semicolon 1
#include <sourcemod>
#include <sdktools>

public Plugin myinfo = {
    name = "Weapon Cleanup",
    author = "captainzero93",
    description = "Removes dropped weapons from the map",
    version = "1.0",
    url = ""
};

public OnPluginStart()
{
    CreateTimer(5.0, CleanupTimer, _, TIMER_REPEAT);
}

public Action CleanupTimer(Handle timer)
{
    for (int x = 0; x < 4028; x++)
    {
        if(IsValidEntity(x))
        {
            char model[128];
            GetEntPropString(x, Prop_Data, "m_ModelName", model, sizeof(model));
            
            // Check for all HL2DM weapon models
            if(StrEqual(model, "models/weapons/w_357.mdl", false) || 
               StrEqual(model, "models/weapons/w_crossbow.mdl", false) ||
               StrEqual(model, "models/Weapons/w_IRifle.mdl", false) ||
               StrEqual(model, "models/Weapons/w_grenade.mdl", false) ||
               StrEqual(model, "models/Weapons/w_rocket_launcher.mdl", false) ||
               StrEqual(model, "models/Weapons/w_shotgun.mdl", false) ||
               StrEqual(model, "models/Weapons/W_pistol.mdl", false) ||
               StrEqual(model, "models/Weapons/w_smg1.mdl", false) ||
               StrEqual(model, "models/Weapons/w_stunbaton.mdl", false) ||
               StrEqual(model, "models/Weapons/w_slam.mdl", false) ||          
               StrEqual(model, "models/Weapons/w_hopwire.mdl", false) ||       
               StrEqual(model, "models/Weapons/w_grenade_frag.mdl", false) ||  
               StrEqual(model, "models/Weapons/w_bugbait.mdl", false))        
            {
                AcceptEntityInput(x, "Kill");
            }
        }
    }
    return Plugin_Continue;
}
```

I've fixed a few things from your original code as well:
1. Corrected `TIMER*REPEAT` to `TIMER_REPEAT` in the CreateTimer call
2. Added proper spacing for readability
3. Kept all the original weapon checks and added the new ones at the end

This plugin will now check for and remove all standard HL2DM weapons including the SLAM, Hopwire Grenade, Frag Grenade, and Bugbait when they're dropped on the map. The cleanup check runs every 5 seconds as per your original timer setting.
