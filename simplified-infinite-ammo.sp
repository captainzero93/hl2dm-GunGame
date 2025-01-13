#include <sourcemod>
 
#define PLUGIN_VERSION "1.0"

public Plugin:myinfo = {
    name = "Infinite Ammo",
    author = "Modified for GunGame",
    description = "Gives all players infinite ammo",
    version = PLUGIN_VERSION,
    url = ""
};

new activeoffset;
new clipoffset;
new secondclipoffset;
new maxclients;

public OnPluginStart()
{
    // Get weapon offsets
    activeoffset = FindSendPropInfo("CAI_BaseNPC", "m_hActiveWeapon");
    clipoffset = FindSendPropInfo("CBaseCombatWeapon", "m_iClip1");
    secondclipoffset = FindSendPropInfo("CBaseCombatWeapon", "m_iSecondaryAmmoType");
    
    // Create timer for infinite ammo checks
    CreateTimer(0.1, AmmoTimer, _, TIMER_REPEAT);
}

public OnMapStart() {
    maxclients = MaxClients;
}

public Action:AmmoTimer(Handle:timer)
{
    new iWeapon;
    new iSecondAmmo;
    
    for(new iClient = 1; iClient <= maxclients; iClient++)
    {
        if(IsClientInGame(iClient) && IsPlayerAlive(iClient))
        {
            iWeapon = GetEntDataEnt2(iClient, activeoffset);
            if(IsValidEntity(iWeapon)) {
                // Set primary ammo
                SetEntData(iWeapon, clipoffset, 50, 4, true);
                
                // Set secondary ammo
                iSecondAmmo = GetEntData(iWeapon, secondclipoffset, 1);
                if (iSecondAmmo != 255)
                    SetEntProp(iClient, Prop_Send, "m_iAmmo", 5, _, iSecondAmmo);
            }
        }
    }
    return Plugin_Continue;
}