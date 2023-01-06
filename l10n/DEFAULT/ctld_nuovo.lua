--CTLD Script by Andrea "Heater" Papaleo 32nd VFW Air Combat Wings

-- Instantiate and start a CTLD for the blue side, using helicopter groups named "Helicargo" and alias "Lufttransportbrigade I"
local my_ctld = CTLD:New(coalition.side.BLUE,{"Helicargo"},"Lufttransportbrigade I")
my_ctld:__Start(5)
   
   -- add infantry unit called "Anti-Tank Small" using template "ATS", of type TROOP with size 3
   -- infantry units will be loaded directly from LOAD zones into the heli (matching number of free seats needed)
my_ctld:AddTroopsCargo("Anti-Tank Small",{"ATS"},CTLD_CARGO.Enum.TROOPS,3)

   -- add infantry unit called "Anti-Tank" using templates "AA" and "AA"", of type TROOP with size 4
my_ctld:AddTroopsCargo("Anti-Air",{"AA"},CTLD_CARGO.Enum.TROOPS,4)

   -- add vehicle called "Humvee" using template "Humvee", of type VEHICLE, size 2, i.e. needs two crates to be build
   -- vehicles and FOB will be spawned as crates in a LOAD zone first. Once transported to DROP zones, they can be build into the objects
my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2)

   -- add infantry unit called "Forward Ops Base" using template "FOB", of type FOB, size 4, i.e. needs four crates to be build:
my_ctld:AddCratesCargo("Forward Ops Base",{"FOB"},CTLD_CARGO.Enum.FOB,4)
   
   -- Add a zone of type LOAD to our setup. Players can load troops and crates.
   -- "Loadzone" is the name of the zone from the ME. Players can load, if they are inside of the zone.
   -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
my_ctld:AddCTLDZone("Loadzone_1",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("Loadzone_2",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("Loadzone_3",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)

   -- Add a zone of type DROP. Players can drop crates here.
   -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
   -- NOTE: Troops can be unloaded anywhere, also when hovering in parameters.
my_ctld:AddCTLDZone("Dropzone_1",CTLD.CargoZoneType.DROP,SMOKECOLOR.Red,true,true)
my_ctld:AddCTLDZone("Dropzone_2",CTLD.CargoZoneType.DROP,SMOKECOLOR.Red,true,true)
my_ctld:AddCTLDZone("Dropzone_3",CTLD.CargoZoneType.DROP,SMOKECOLOR.Red,true,true)

   -- Add two zones of type MOVE. Dropped troops and vehicles will move to the nearest one. See options.
   -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
--my_ctld:AddCTLDZone("Movezone",CTLD.CargoZoneType.MOVE,SMOKECOLOR.Orange,false,false)

--my_ctld:AddCTLDZone("Movezone2",CTLD.CargoZoneType.MOVE,SMOKECOLOR.White,true,true)
   
my_ctld.useprefix = true -- (DO NOT SWITCH THIS OFF UNLESS YOU KNOW WHAT YOU ARE DOING!) Adjust **before** starting CTLD. If set to false, *all* choppers of the coalition side will be enabled for CTLD.
my_ctld.CrateDistance = 30 -- List and Load crates in this radius only.
my_ctld.dropcratesanywhere = false -- Option to allow crates to be dropped anywhere.
my_ctld.maximumHoverHeight = 15 -- Hover max this high to load.
my_ctld.minimumHoverHeight = 4 -- Hover min this low to load.
my_ctld.forcehoverload = true -- Crates (not: troops) can only be loaded while hovering.
my_ctld.hoverautoloading = true -- Crates in CrateDistance in a LOAD zone will be loaded automatically if space allows.
my_ctld.smokedistance = 2000 -- Smoke or flares can be request for zones this far away (in meters).
my_ctld.movetroopstowpzone = true -- Troops and vehicles will move to the nearest MOVE zone...
my_ctld.movetroopsdistance = 5000 -- .. but only if this far away (in meters)
my_ctld.smokedistance = 2000 -- Only smoke or flare zones if requesting player unit is this far away (in meters)
my_ctld.suppressmessages = false -- Set to true if you want to script your own messages.

   
function my_ctld:OnAfterTroopsPickedUp(From, Event, To, Group, Unit, Cargo)

if Unit == nil then
    env.info("Unit is nil")
  else
    env.info(Unit)
  troopepickup_to_discord = {}
  troopepickup_to_discord.messageType= 6
  troopepickup_to_discord.messageString = ('**CTLD(CAUOPS): Truppe a bordo, via via via !**')
  --local my_csar = ('**CSAR: Pilot  down | Coord '..coord..' | Test Radio**')
  -- CSAR: Pilot down | Coord: MGRS 37T GG 39613 01195 | Freq: 290.00
  --local playername = Group:GetUnit(1):GetPlayerName() or "none"
  --local mayday=MESSAGE:New(string.format("Player %s down!",playername),10,"CSAR"):ToAll()
  HypeMan.sendBotTable(troopepickup_to_discord)
 end 
 end
   
   
   
