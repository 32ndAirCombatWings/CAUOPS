BASE:E("Loading AI Dispatcher")

-- -- Constants -- --
BASE:E("Loading AI Dispatcher: Constants")
REDAIRSPACE = ZONE_POLYGON:New("Red Airspace",GROUP:FindByName("REDAS"))   -- Create our RED airspace (Border)
REDCAP1 = ZONE_POLYGON:New("RED CAP1",GROUP:FindByName("Western Enemy CAP Engagement Zone"))         -- Create our Aircap1 space
REDCAP2 = ZONE_POLYGON:New("RED CAP2",GROUP:FindByName("Central Enemy CAP Engagement Zone"))         -- Create our Aircap2 space  
REDCAP3 = ZONE_POLYGON:New("RED CAP3",GROUP:FindByName("Eastern Enemy CAP Engagement Zone"))                                                                             
REDAWAC = GROUP:FindByName("Enemy AWACS")
CAPTIMEMININTERVAL = (60*15)
CAPTIMEMAXINTERVAL = (60*20)
CAPINTERVALMIN = (15)
CAPINTERVALMAX = (60*1)
-- -- END Constants -- --


-- RED AI CAP CODE --
do
BASE:E("Loading AI Dispatcher: AI CAP")
-- Set up RED Detection groups for AWACS and RADAR
-- This is for the enemy be able to see you and to start the whole process 
REDDetSetGroup = SET_GROUP:New()
REDDetSetGroup:FilterPrefixes({"Enemy AWACS","Enemy RADAR"})
REDDetSetGroup:FilterStart()

-- Set up our Detection Area grid for the dispatcher
REDDet = DETECTION_AREAS:New(REDDetSetGroup,UTILS.NMToMeters(20))

-- Our dispatcher
REDA2ADisp = AI_A2A_DISPATCHER:New(REDDet)

-- Created our settings and Zones for Dispatcher
REDA2ADisp:SetBorderZone(REDAIRSPACE)              
REDA2ADisp:SetEngageRadius(UTILS.NMToMeters(60))    -- if you are within 60nm they will engage (depending on border settings)
REDA2ADisp:SetDefaultDamageThreshold(0.4)
REDA2ADisp:SetDefaultFuelThreshold(0.4)
REDA2ADisp:SetDefaultTanker(REDTANKER)     
REDA2ADisp:SetDefaultGrouping(2)                    -- Flying with 2 at the same time
REDA2ADisp:SetDefaultLandingAtRunway()
REDA2ADisp:SetDefaultTakeoffFromRunway()
--REDA2ADisp:SetDefaultCapTimeInterval(CAPTIMEMININTERVAL,CAPTIMEMAXINTERVAL) 


BASE:E("Loading AI Dispatcher: SQNs")
-- Western defence sqn setup
REDA2ADisp:SetSquadron("Western Defense SQN",AIRBASE.Caucasus.Krasnodar_Center,{"Enemy_29SA_Temp","Enemy_29SB_Temp"},8)        --Your Sqn, check airbase (as i do not know where to take off, check templates and that airfield has 10 planes ready to take off
REDA2ADisp:SetSquadronCap("Western Defense SQN",REDCAP1,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(25000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("Western Defense SQN",2,CAPINTERVALMIN,CAPINTERVALMAX,1.0)                                       --How many sqn need the AI to dispatch and on which interval (min and max)
REDA2ADisp:SetSquadronOverhead("Western Defense SQN",1.5)                                                           --For each plane the AI will spawn x amounts of planes to defend
REDA2ADisp:SetSquadronVisible("Western Defense SQN")        
-- Northern defence sqn setup
REDA2ADisp:SetSquadron("Central Defense SQN",AIRBASE.Caucasus.Sochi_Adler,{"Enemy_29SA_Temp","Enemy_29SB_Temp"},10)      
REDA2ADisp:SetSquadronCap("Central Defense SQN",REDCAP2,UTILS.FeetToMeters(18000),UTILS.FeetToMeters(25000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("Central Defense SQN",2,CAPINTERVALMIN,CAPINTERVALMAX,1.0)    
REDA2ADisp:SetSquadronGci("Central Defense SQN",UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437))                                    
REDA2ADisp:SetSquadronOverhead("Central Defense SQN",1.5)    
REDA2ADisp:SetSquadronVisible("Central Defense SQN")  
-- Eatern defence sqn setup
REDA2ADisp:SetSquadron("Eatern Defense SQN",AIRBASE.Caucasus.Mozdok,{"Enemy_29SA_Temp","Enemy_29SB_Temp"},8)      
REDA2ADisp:SetSquadronCap("Eatern Defense SQN",REDCAP3,UTILS.FeetToMeters(18000),UTILS.FeetToMeters(25000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("Eatern Defense SQN",2,CAPINTERVALMIN,CAPINTERVALMAX,1.0)                                        
REDA2ADisp:SetSquadronOverhead("Eatern Defense SQN",1.0) 
REDA2ADisp:SetSquadronVisible("Eatern Defense SQN") 
REDA2ADisp:SetSquadronTakeoffFromParkingHot("Eatern Defense SQN")
--REDA2ADisp:SetSquadronLandingAtEngineShutdown("Eatern 2 Defense SQN")

end

BASE:E("Loading AI Dispatcher - DONE!!!!")

