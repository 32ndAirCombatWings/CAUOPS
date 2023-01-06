--CSAR Script by Andrea "Heater" Papaleo 32nd VFW Air Combat Wings

-- Instantiate and start a CSAR for the blue side, with template "Downed Pilot" and alias "Luftrettung"
   local my_csar = CSAR:New(coalition.side.BLUE,"Downed Pilot","Luftrettung")
   -- options
   my_csar.immortalcrew = true -- downed pilot spawn is immortal
   my_csar.invisiblecrew = false -- downed pilot spawn is visible
   -- start the FSM
   my_csar:__Start(5)
   
   
my_csar.allowDownedPilotCAcontrol = false -- Set to false if you don\'t want to allow control by Combined Arms.
my_csar.allowFARPRescue = true -- allows pilots to be rescued by landing at a FARP or Airbase. Else MASH only!
--my_csar.autosmoke = false -- automatically smoke a downed pilot\'s location when a heli is near.
--my_csar.autosmokedistance = 1000 -- distance for autosmoke
my_csar.coordtype = 2 -- Use Lat/Long DDM (0), Lat/Long DMS (1), MGRS (2), Bullseye imperial (3) or Bullseye metric (4) for coordinates.
my_csar.csarOncrash = false -- (WIP) If set to true, will generate a downed pilot when a plane crashes as well.
my_csar.enableForAI = false -- set to false to disable AI pilots from being rescued.
my_csar.pilotRuntoExtractPoint = true -- Downed pilot will run to the rescue helicopter up to self.extractDistance in meters. 
my_csar.extractDistance = 500 -- Distance the downed pilot will start to run to the rescue helicopter.
--self.immortalcrew = true -- Set to true to make wounded crew immortal.
my_csar.invisiblecrew = false -- Set to true to make wounded crew insvisible.
my_csar.loadDistance = 75 -- configure distance for pilots to get into helicopter in meters.
--self.mashprefix = {"MASH"} -- prefixes of #GROUP objects used as MASHes.
my_csar.max_units = 6 -- max number of pilots that can be carried if #CSAR.AircraftType is undefined.
my_csar.messageTime = 15 -- Time to show messages for in seconds. Doubled for long messages.
my_csar.radioSound = "beacon.ogg" -- the name of the sound file to use for the pilots\' radio beacons. 
my_csar.smokecolor = 3 -- Color of smokemarker, 0 is green, 1 is red, 2 is white, 3 is orange and 4 is blue.
my_csar.useprefix = true  -- Requires CSAR helicopter #GROUP names to have the prefix(es) defined below.
my_csar.csarPrefix = {"MEDEVAC"} -- #GROUP name prefixes used for useprefix=true - DO NOT use # in helicopter names in the Mission Editor! 
--self.verbose = 0 -- set to > 1 for stats output for debugging.
    -- (added 0.1.4) limit amount of downed pilots spawned by **ejection** events
my_csar.limitmaxdownedpilots = true
my_csar.maxdownedpilots = 10 
    -- (added 0.1.8) - allow to set far/near distance for approach and optionally pilot must open doors
--self.approachdist_far = 5000 -- switch do 10 sec interval approach mode, meters
--self.approachdist_near = 3000 -- switch to 5 sec interval approach mode, meters
my_csar.pilotmustopendoors = true -- switch to true to enable check of open doors

function my_csar:OnAfterPilotDown(From, Event, To, Group, Frequency, Leadername, CoordinatesText)
if CoordinatesText == nil then
    env.info("CoordinatesText is nil")
  else
    env.info(CoordinatesText)
  my_csar = {}
  my_csar.messageType= 6
  my_csar.messageString = ('**CSAR(CAUOPS): Pilot down | Coord '..CoordinatesText..'| Freq Radio '..Frequency..'.00 kHz ADF**')
                            --CSAR(CAUOPS): Pilot down | Coord MGRS 38T KM 95989 97144| Freq Radio 260.00 kHz ADF Lead _TEST_RANGE_Heater Test
  --local my_csar = ('**CSAR: Pilot  down | Coord '..coord..' | Test Radio**')
  -- CSAR: Pilot down | Coord: MGRS 37T GG 39613 01195 | Freq: 290.00
  --local playername = Group:GetUnit(1):GetPlayerName() or "none"
  --local mayday=MESSAGE:New(string.format("Player %s down!",playername),10,"CSAR"):ToAll()
  HypeMan.sendBotTable(my_csar)
 end 
 end

function my_csar:OnAfterBoarded(from, event, to, heliname, groupname)
if heliname == nil then
    env.info("heliname is nil")
  else
    env.info(heliname)
  my_csaronboard = {}
  my_csaronboard.messageType= 6
  my_csaronboard.messageString = ('**CSAR(CAUOPS): Pilota recuperato. | Portarlo al Medical Center piu vicino !!**')
  HypeMan.sendBotTable(my_csaronboard)
end
end

function my_csar:OnAfterRescued(from, event, to, heliunit, heliname, pilotssaved)
if pilotssaved == nil then
    env.info("pilotssaved is nil")
  else
    env.info(pilotssaved)
  pilotssaved = {}
  pilotssaved.messageType= 6
  pilotssaved.messageString = ('**CSAR(CAUOPS): Pilota salvato. | Ottimo lavoro ragazzo !**')
                            --CSAR(CAUOPS): Pilot down | Coord MGRS 38T KM 95989 97144| Freq Radio 260.00 kHz ADF Lead _TEST_RANGE_Heater Test
  --local my_csar = ('**CSAR: Pilot  down | Coord '..coord..' | Test Radio**')
  -- CSAR: Pilot down | Coord: MGRS 37T GG 39613 01195 | Freq: 290.00
  --local playername = Group:GetUnit(1):GetPlayerName() or "none"
  --local mayday=MESSAGE:New(string.format("Player %s down!",playername),10,"CSAR"):ToAll()
  HypeMan.sendBotTable(pilotssaved)
 end 
end    