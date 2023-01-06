-----------------Tactical Menu----------------
--mainMenu = MENU_MISSION:New( "Tactical Menu" )
A2A = MENU_MISSION:New( "Air to Air Spawns")
BVR = MENU_MISSION:New( "BVR (Missles) ", A2A)
ACM = MENU_MISSION:New("ACM (Guns Only)", A2A)
Bombers = MENU_MISSION:New("Bomber Intercepts)", A2A)

A2G = MENU_MISSION:New( "Air to Ground Spawns")
SAM = MENU_MISSION:New("SAM Range", A2G)
AR_menu_root = MENU_MISSION:New("Armed Recon",A2G)
RANGE.MenuF10Root=MENU_MISSION:New("Basic Ranges",A2G).MenuPath
menuJTAC = MENU_MISSION:New("JTAC Refresh", A2G)
naval_menu = MENU_MISSION:New("Naval Ops", A2G)

menuFox=MENU_MISSION:New("Fox Trainer")
adminMenu = MENU_MISSION:New( "Admin")

----------------spawn zones------------------
zoneTable= { ZONE:New("DogfightZone"), ZONE:New("BomberZone")}

-------------------BVR aircraft - with missiles -------------------------
bvrTable = {"F-4 BVR", "F-5 BVR","F-15 BVR", "F-16 BVR", "F-18 BVR", "Mig21 BVR","Mig29 BVR" }
numberOfBVRAircraft = 7
redBVR = {}
for i=1,numberOfBVRAircraft do
  redBVR[i] = SPAWN:New(bvrTable[i]):InitLimit(3,0)
end

SpawnBVR = {}
function newBVR(grpname, grpspawn)
  SpawnBVR[grpname] = grpspawn:SpawnInZone(zoneTable[1],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New(text.." spawned.",15,Info):ToAll()
end

local function destroyBVR(grpspawn)
for k, v in pairs(SpawnBVR) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfBVRAircraft do
  MENU_MISSION_COMMAND:New (bvrTable[i], BVR, newBVR, bvrTable[i], redBVR[i])
end
MENU_MISSION_COMMAND:New ("Remove BVR Spawns", BVR, destroyBVR)

--------------------ACM Aircraft - no missiles -------------------
acmTable = {"F-4 ACM", "F-5 ACM", "F-15 ACM" , "F-16 ACM", "F-18 ACM", "Mig21 ACM", "Mig29 ACM"}
numberOfACMAircraft = 7
redACM = {}
for i=1,numberOfACMAircraft do
  redACM[i] = SPAWN:New(acmTable[i]):InitLimit(3,0)
end

SpawnACM = {}
function newACM(grpname, grpspawn)
  SpawnACM[grpname] = grpspawn:SpawnInZone(zoneTable[1],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New(text.." spawned.",15,Info):ToAll()
end

local function destroyACM(grpspawn)
for k, v in pairs(SpawnACM) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfACMAircraft do
  MENU_MISSION_COMMAND:New (acmTable[i], ACM, newACM, acmTable[i], redACM[i])
end
MENU_MISSION_COMMAND:New ("Remove ACM Spawns", ACM, destroyACM)

----------------Bombers--------------------
bombTable = {"TU-22 Blinder", "TU-95 Bear" , "TU-160 Blackjack" , "B-1B", "B-52" }
numberOfBombers = 5
redBomb = {}
for i=1,numberOfBombers do
  redBomb[i] = SPAWN:New(bombTable[i]):InitLimit(3,0)
end

SpawnBomb = {}
function newBomber(grpname, grpspawn)
  SpawnBomb[grpname] = grpspawn:SpawnInZone(zoneTable[2],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New("Scramble fighters, "..text.." detected, BRA 320 for 135 at 22,000 from the Anapa TCN",15,Info):ToAll()
end

local function destroyBombers(grpspawn)
for k, v in pairs(SpawnBomb) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfBombers do
  MENU_MISSION_COMMAND:New (bombTable[i], Bombers, newBomber, bombTable[i], redBomb[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned Bombers", Bombers, destroyBombers)

------------------SAM Sites----------------------
samTable = { "SA-2", "SA-6", "SA-8", "SA-10", "SA-11", "SA-15"}
--samZoneTable = {ZONE:New("Sam_Zone_2"),ZONE:New("Sam_Zone_3"), ZONE:New("Sam_Zone_4")}
samZoneTable = {ZONE:New("Sam_Zone")}

redSAM = {}
for i=1,6 do
  redSAM[i] = SPAWN:New(samTable[i]):InitLimit(50,0):InitAIOn():InitRandomizeZones(samZoneTable)
end

SAMSpawn = {}
function newSAMSite(grpname, grpspawn)
  SAMSpawn[grpname] = grpspawn:Spawn():OptionAlarmStateRed()
  text = grpname
  MESSAGE:New(text.." Group Spawned",15,Info):ToAll()
end

local function destroySAM(grpspawn)
for k, v in pairs(SAMSpawn) do
  v:Destroy()
  k = nil
end
end

for i=1,6 do
  MENU_MISSION_COMMAND:New (samTable[i], SAM, newSAMSite, samTable[i], redSAM[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned SAM Sites", SAM, destroySAM)

--------------ACMI Pods-----------------
-- trainerRunning = false

-- function trainerOnOff()
-- if not trainerRunning then
-- local acmiTrainer = MISSILETRAINER
-- acmiTrainer:New( 200, "ACMI pods now active" )
-- acmiTrainer:InitMessagesOnOff(true)
-- acmiTrainer:InitAlertsToAll(true)
-- acmiTrainer:InitAlertsHitsOnOff(true)
-- acmiTrainer:InitAlertsLaunchesOnOff(false)
-- acmiTrainer:InitBearingOnOff(false)
-- acmiTrainer:InitRangeOnOff(false)
-- acmiTrainer:InitTrackingOnOff(false)
-- acmiTrainer:InitTrackingToAll(false)
-- acmiTrainer:InitMenusOnOff(false)
-- acmiTrainer:InitAlertsToAll(true)
-- acmiTrainer"Start()
-- podOn:Remove()
-- end
-- end
-- podOn = MENU_MISSION_COMMAND:New ("Turn On ACMI", A2A, trainerOnOff )

---Launch Event
-- local alert5Flag = USERFLAG:New("20")
-- function launchEvent()
-- alert5Flag:Set(true)
-- MESSAGE:New("99, Launch Aircraft",15,Info):ToAll()
-- alertLaunch:Remove()
-- end
-- alertLaunch = MENU_MISSION_COMMAND:New ("Launch the Alert Aircraft", mainMenu, launchEvent )

-------JTAC respawn------------
function launchJTAC1()
  Spawn_JTAC1 = SPAWN:New("JTAC1")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC1", menuJTAC, launchJTAC1 )

function launchJTAC2()
  Spawn_JTAC2 = SPAWN:New("JTAC2")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC2", menuJTAC, launchJTAC2 )

function launchJTAC3()
  Spawn_JTAC3 = SPAWN:New("JTAC3")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC3", menuJTAC, launchJTAC3 )

------------------Fox Missile Trainer-------------
-- Protect all blue AI.

FoxRunning = false
function FoxOn()
  if not FoxRunning then
	local blueset=SET_GROUP:New():FilterCoalitions("blue"):FilterActive():FilterStart()
	foxTrainer = FOX:New()
	foxTrainer:SetProtectedGroupSet(blueset)
	--foxTrainer:AddSafeZone(ZONE:New("Zone_1"))
	--foxTrainer:AddSafeZone(ZONE:New("Zone_2"))
	foxTrainer:SetExplosionDistance(500)
	foxTrainer:SetExplosionPower(.1)
    foxTrainer:Start()
    MESSAGE:New("Fox Trainer On",15,Info):ToAll()
    FoxRunning = true
	env.info(FoxRunning)
	env.info("FoxRunning")
  end
end
MENU_MISSION_COMMAND:New("Fox On", menuFox,FoxOn)

function FoxOff()
  foxTrainer:__Stop(1)
  MESSAGE:New("Fox Trainer Off",15,Info):ToAll()
  FoxRunning = false
  env.info(FoxRunning)
  env.info("FoxOff")
end
MENU_MISSION_COMMAND:New("Fox Off", menuFox,FoxOff)

function SmokeOn()
  foxTrainer:SetDebugOn()
  foxTrainer:SetDefaultLaunchAlerts(true)
  foxTrainer:SetDefaultLaunchMarks(true)
  MESSAGE:New("Smoke and Launch Information On",15,Info):ToAll()
end
MENU_MISSION_COMMAND:New("Smoke and Launch Alerts On", menuFox,SmokeOn)

function SmokeOff()
  foxTrainer:SetDebugOff()
  foxTrainer:SetDefaultLaunchAlerts(false)
  foxTrainer:SetDefaultLaunchMarks(false)
  MESSAGE:New("Smoke and Launch Information Off",15,Info):ToAll()
end
MENU_MISSION_COMMAND:New("Smoke and Launch Alerts Off", menuFox,SmokeOff)

-------------Ranges---------------------------------
--Range 5 Ships--
local function range_5_Ships()
  range_5_menu_Ships:Remove()
  trigger.action.setUserFlag(21500,true)
end

range_5_menu_Ships = MENU_MISSION_COMMAND:New("Activate Naval Targets Poti",naval_menu,range_5_Ships)

--Range 6 Ships--
local function range_6_Ships()
  range_6_menu_Ships:Remove()
  trigger.action.setUserFlag(21600,true)
end

range_6_menu_Ships = MENU_MISSION_COMMAND:New("Activate Naval Targets South",naval_menu,range_6_Ships)

