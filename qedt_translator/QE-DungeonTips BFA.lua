--[[
Questionably Epic Mythic+ Dungeon Tips
Version: 4.8 (Battle for Azeroth)
Developed by: Voulk
Contact: 
	Discord: Voulk#1858
	Email: itsvoulk@gmail.com
	
	
Special Thanks:
 - CoV (testing & support)
 - Everyone who helped test the addon and support the site 
	

--Shorthand--

Defensives {Defensive: SpellName}
Interrupts {Interrupt: SpellName (SpellEffect)}, {Stun Interrupt: SpellName (SpellEffect)}
Dispels {Dispel: SpellName (SpellEffect)}, {Purge: SpellName (SpellEffect)}
Positioning: {Spread: When}, {Stack: When}, {Dodge: SpellName (Area / description)}
Other: {Frontal Cleave (opt: tank dodgeable)}, {Healing CD: SpellName}, {ClassName: Specific Cheese}, {Priority DPS target}

--Examples--
Interrupt: Stone Bolt (heavy ST nuke)
Defensive: Arcing / Expel Light overlap
Healing CD: Slicing Maelstrom (every 25s)
Dispel: Brittle Bones (inc dmg taken)
Frontal Cleave: Razor Shards (tank dodgeable)
Druid: Shapeshift the Arcane Lockdown debuff

]]--

local _, addon = ...;

-- The Tips maps holds tooltip information and mob ID's for all 13 legion dungeons and all 10 BFA dungeons. This is basically the database.
-- Each array uses the format: {{"Type", "Tip1"}, {"Type", "Tip2"}}
local tipsMap = {
	-- Example
	[126389] = {{"Blank", "A+ Tip right here. \n It's a shame it's so damn long eh? It just goes on and on and on and ooon"}, 
				{"Interrupt", "INTERRUPT: Stone Bolt"}}, -- In this example case, all roles will see "A+ Tip right here" on the mobs tooltip but only Healers will see the second tip.
	
		--
	
	---------------------------------------------------
	----------------Battle for Azeroth-----------------
	---------------------------------------------------
	
	----- Ataldazar -----
	
	-- Trash toward Priestess
	[122971] = {{"Important", "Ranged players should stay spread 8 yards to avoid his charge hitting more than one player"}, {"Important", "Enrage: Dispel or Kite away during Fanatic's Rage"},
				{"Advanced", "The charge can be avoided completely with blinks / or sprints (stand as far away as possible)"}}, -- Dazar'ai Juggernaut
	[127799] = {{"Important", "Minor tank damage. Not dangerous."}}, -- Dazar'ai Honor Guard
	[127757] = {{"PriorityTargets", "Priority Target"}, {"Important", "MUST kill the reanimation totem first."}, {"Important", "Will pulse HEAVY AoE to the party after totem is dead. Kill quickly."}}, -- Reanimated Honor Guard
	[122973] = {{"Interrupts", "Interrupt(!): Bwonsamdi's Mantle (big CC immunity bubble)"}, {"Interrupts", "Interrupt: Mending Word (medium heal)"}, 
				{"TANK", "If they get a bubble off then you'll need to drag all of the mobs out of it."}}, -- Dazar'ai Confessor
	[122972] = {{"Interrupts", "Interrupt(!!): Fiery Enchant (buffs a nearby Juggernaut to throw fire)"}, 
				{"Important", "Will also cast Wild Fire (dmg + DoT) on random players but this is a less important interrupt"}}, -- Dazar'ai Augur
	[122984] = {{"PriorityTargets", "Priority Target: will heal and gain damage every time a nearby mob dies"}, {"Defensives", "Defensive: Soul Burn (Heavy DoT on one player)"}}, -- Dazar'ai Colossus
	[132126] = {{"Important", "Not dangerous. Stand in blood pools before transfusion to kill them more quickly"}}, -- Gilded Priestess
	
	-- Trash toward Vol'kaal
	[128435] = {{"Important", "Will jump to random allies and deal damage in a small AoE"}, {"Important", "Stay grouped but with a 3yd gap between each player."}}, -- Toxic Saurid
	[128434] = {{"Interrupts", "Interrupt(!!): Terrifying Screech (long AoE fear)"}}, -- Feasting Skyscreamer
	[128455] = {{"Important", "Skippable! Just walk carefully around the edge of the platform."}, {"Important", "Will charge a random player. Other allies should stand clear so only one is hit"}}, -- T'lonja
	[129552] = {{"Important", "Skippable! Just walk carefully around the edge of the platform."}}, -- Monzumi
	[129553] = {{"Important", "Skippable! Just walk carefully around the edge of the platform."}, {"Interrupts", "Interrupt or Purge: Dino Might (medium HoT)"}}, -- Dinomancer Kish'o
	[122969] = {{"Interrupts", "Interrupt or decurse: Unstable Hex (long CC)"}, {"Important", "The Hex spreads to allies within 8 yards when dispelled. Give them time to walk out."}}, -- Zanchuli Witch-Doctor
	[127879] = {{"Important", "Channels a big damage reduction shield that protects nearby enemies"}, {"Important", "Knockbacks are key here because you can knock his shield away from the rest of the pack"},
				{"Important", "Will Shield Bash nearby enemies if tank isn't in range. This really hurts so keep distance."}}, -- Shieldbearer of Zul
	[135989] = {{"Important", "Channels a big damage reduction shield that protects nearby enemies"}, {"Important", "Knockbacks are key here because you can knock his shield away from the rest of the pack"},
				{"Important", "Will Shield Bash nearby enemies if tank isn't in range. This really hurts so keep distance."}}, -- Shieldbearer of Zul
	[122970] = {{"Important", "Start stealthed and will stun you if they get the jump on you. Let the tank lead."}, {"Important", "Heavy tank damage. Particularly during Venonfang Strike (dispellable poison)"}, 
				{"Fluff", "The mob is stealthed so by the time you read this you might already be dead..."}}, -- Shadowblade Stalker
	
	-- Bosses
	[122967] = {{"Important", "Stand in the blood pools before Transfusion is cast"}, {"Important", "The debuff lasts 15 seconds so you can grab it early"},
				{"PriorityTargets", "Priority Target (or CC): Spirit of Gold (eats blood pools)"}, {"HEALER", "Contribute DPS and keep the tank alive. Very easy fight."}}, -- Priestess Alun'za
		[131009] = {{"Important", "Stand in the blood pools before Transfusion is cast"}, {"Important", "The debuff lasts 15 seconds so you can grab it early"},
				{"PriorityTargets", "Priority Target (or CC): Spirit of Gold (eats blood pools)"}, {"HEALER", "Contribute DPS and keep the tank alive. Very easy fight."}}, -- Priestess Alun'za (Spirit of Gold)
				
	[122965] = {{"Important", "Totems first. Boss second. Totems MUST die within 7 seconds of each other."}, {"Important", "Consider assigning one DPS to each totem."},
				{"Important", "Boss will instantly heal until totems are dead so don't multi-DoT him."}, {"HEALER", "Heavy ticking damage. Be efficient, use your cooldowns regularly."},
				{"HEALER", "The damage tends to be heavier while the totems are up so it's ok if you use more mana / CD's there."}}, -- Vol'kaal
	[122963] = {{"Important", "Don't stand on piles of bones"}, {"Important", "Line of Sight: Terrifying Visage"}, {"Important", "Tank the boss up against a pillar on the side of the room. You can use them for easy LoS."},
				{"Important", "Run from: Pursuit (though currently undertuned)"}}, -- Rezan
	[122968] = {{"Important", "Put down a raid marker 40 yards from the boss. During Soulrend, DPS / Healers stack on this point."}, {"Important", "This lets you stun and AoE down the adds that spawn."},
				{"Important", "There's plenty on the floor to dance around. It all hurts."}, {"HEALER", "Healing CD: Soulrend. Otherwise spot heal anyone who stands in spiders."}}, -- Yazma
	
	
	
	--- Freehold
	-- Trash toward Skycap'n Kragg
	[128551] = {{"Important", "Moderate tank damage."}, {"DRUID", "Soothe: Beastial Wrath (50% dmg buff)"}, {"HUNTER", "Tranq Shot: Beastial Wrath (50% dmg buff)"}}, -- Irontide Mastiff
	[129788] = {{"Important", "Moderate tank damage."}, {"Interrupts", "Interrupt (or purge): Healing Balm (medium HoT)"}, {"HEALER", "Dispel: Infected Wound (Disease, -healing taken)"}}, -- Irontide Bonesaw
	[129602] = {{"Important", "VERY annoying mob. Frontal cleave (tank can dodge after cast starts)"}, {"Important", "Will throw the tank but no longer drops threat. Pull one at a time if possible."}}, -- Irontide Enforcer
	[126928] = {{"Important", "Moderate tank damage."}, {"HEALER", "Dispel: Poisoning Strike (Poison, DoT, wait until 2 stacks)"}}, -- Irontide Corsair
	[126918] = {{"Important", "Move out of the red swirls. They burn. Don't burn."}, {"TANK", "These don't really move but still have threat table. Tank everything on top of them."}}, -- Irontide Crackshot
	[129598] = {{"Important", "Why are you killing the poor mules!?"}, {"Important", "No notable mechanics but still... why!?"}},
	
	-- The Village	
	[130522] = {{"Important", "Mostly harmless. Pull as few of them as you can."}}, -- Freehold Shipmate (Neutral)
	[130521] = {{"Important", "Mostly harmless. Pull as few of them as you can."}}, -- Freehold Deckhand (Neutral)
	[127124] = {{"Important", "Mostly harmless. Pull as few of them as you can."}}, -- Freehold Barhand (Neutral)
	[129526] = {{"Important", "Mostly harmless. Pull as few of them as you can."}}, -- Bilge Rat Swabby (Neutral)	
	[130024] = {{"Important", "Stacks healing debuff on tank. Pull out your AoE CC here."}}, -- Soggy Shiprat
	[127111] = {{"Interrupts", "Interrupt or Dodge: Sea Spout (conjures dodgeable blue swirls everywhere)"}}, -- Irontide Oarsman
	[130400] = {{"Important", "Two abilities to dodge. Boulder toss is a grey swirl that will stun you (if you live)."}, {"Important", "Ground Shatter is a 9 yard AoE around him that you'll move out of."}}, -- Irontide Crusher
	[130404] = {{"Important", "Will lay traps around the area. Standing in one roots you and deals very heavy damage"}}, -- Vermin Trapper
	[129527] = {{"Important", ""}}, -- Bilge Rat Buccaneer
	[129600] = {{"Important", ""}}, -- Bilge Rat Brinescale
	[129550] = {{"Important", "Will jump to random players."}, {"Important", "Don't stand 50 yards away so they stay in AoE (looking at you, Hunters)"}, {"HEALER", "Dispel: Plague Step (Disease, small DoT & -healing taken"}}, -- Bilge Rat Padfoot
	[129548] = {{"Important", "Have a minor AoE slow but otherwise harmless"}}, -- Blacktooth Brute
	[129529] = {{"Important", "Fixates random allies. The scrapper should be kited or you should pop a major defensive."}, {"DRUID", "Soothe: Blind Rage (yes, you can stop the fixate. Soothe is god.)"},
				{"HUNTER", "Tranq Shot: Blind Rage (yes, you can stop the fixate.)"}}, -- Blacktooth Scrapper
	[129547] = {{"Interrupts", "Interrupt(!): Shattering Bellow (AoE damage, spell interrupt)"}, {"Important", "Bellow only has a 30 yard range so it doesn't hurt to stand back if you're a caster."}}, -- Blacktooth Knuckleduster
	[129599] = {{"Important", "Has a bouncing blade. Stand 8 yards apart to minimize bouncing."}}, -- Cutwater Knife Juggler
	[129601] = {{"Important", "Will drag random ranged players into him. Consider using a defensive."}, {"Important", "The real danger here is that you get dragged into the Crushers abilities."}}, -- Cutwater Harpooner
	[129559] = {{"Important", ""}}, -- Cutwater Duelist	
		
	[135978] = {{"Important", ""}}, -- Bilge Rat Grog Jerk (Allied - Hands out drinks)
	[135353] = {{"Important", ""}}, -- Veteran Man O' Warden (World Quest mob)
	[130090] = {{"Important", ""}}, -- Gukguk "The Motivator" (Allied)
	
	-- Path to Sweete
	[130012] = {{"Interrupts", "Interrupt: Painful Motivation (45% dmg buff)"}, {"Important", "The buff also deals heavy damage to the mobs. The risk is up to you."}}, -- Irontide Ravager
	[126919] = {{"Interrupts", "Interrupt: Thundering Squall (moderate 12s 10yrd AoE)"}, {"Important", "You can walk out of this but your melee will lose damage."}}, -- Irontide Stormcaller
	[130011] = {{"Important", "Frontal Cleave (Blade Barrage, tank can dodge after cast start)"}}, -- Irontide Buccaneer
	[127106] = {{"Important", "Heavy tank damage."}, {"HEALER", "Dispel(!): Oiled Blade (Magic, 75% healing reduction)"}}, -- Irontide Officer
		
	-- Bosses
	[126832] = {{"Important", "Phase 1 (above 75% HP): Just dodge the brown charge swirl."}, {"Interrupts", "Interrupt: Revitalizing Brew (HoT). You can drink it off the floor after you interrupt it."},
				{"Important", "Spread around the boss. His powder shot deals damage in a big cone in a random players direction."}, 
				{"Important", "Big bird will swoop through the arena dealing heavy dmg. Watch what direction he's facing."}}, -- Skycap'n Kragg
	[126845] = {{"Important", "Don't fight all three at once! You need to complete a mini game to remove one from the fight."}, {"Important", "Mini-game rotates weekly. Find the dog, drink with vulperas or beat up the knuckledusters."},
				{"Important", "Raoul: Throws barrels on allies heads. Destroy them (barrel, not player). Dodge swirls."}, {"Important", "Eudora: Hits random allies, then casts big series of cones across arena."},
				{"Important", "Jolly: Dodge spinning blades. Watch out for boss charge."}, {"Important", "Honestly this fight has way too many mechanics. Check website soon for more information."}}, -- CoC: Captain Jolly
	[126847] = {{"Important", "Don't fight all three at once! You need to complete a mini game to remove one from the fight."}, {"Important", "Mini-game rotates weekly. Find the dog, drink with vulperas or beat up the knuckledusters."},
				{"Important", "Raoul: Throws barrels on allies heads. Destroy them (barrel, not player). Dodge swirls."}, {"Important", "Eudora: Hits random allies, then casts big series of cones across arena."},
				{"Important", "Jolly: Dodge spinning blades. Watch out for boss charge."}, {"Important", "Honestly this fight has way too many mechanics. Check website soon for more information."}}, -- CoC: Captain Raoul
	[126848] = {{"Important", "Don't fight all three at once! You need to complete a mini game to remove one from the fight."}, {"Important", "Mini-game rotates weekly. Find the dog, drink with vulperas or beat up the knuckledusters."},
				{"Important", "Raoul: Throws barrels on allies heads. Destroy them (barrel, not player). Dodge swirls."}, {"Important", "Eudora: Hits random allies, then casts big series of cones across arena."},
				{"Important", "Jolly: Dodge spinning blades. Watch out for boss charge."}, {"Important", "Honestly this fight has way too many mechanics. Check website soon for more information."}}, -- CoC: Captain Eudora
	[130099] = {{"Important", "Phase 1 (Pig). You need to click him 5 times as a group."}, {"Important", "Phase 2 (Turtle): Dodge the big shells."}, {"Important", "Phase 3 (Shark Puncher): Move from Sharknado, run from flailing sharks."},
				{"Important", "You need to run the sharks through the chum to slow them down."}, {"TANK", "Go too close to the side of the arena and spectators will throw fruit. Heavy fruit."}}, -- RoB: Lightning (Pig)
	[129699] = {{"Important", "Phase 1 (Pig). You need to click him 5 times as a group."}, {"Important", "Phase 2 (Turtle): Dodge the big shells."}, {"Important", "Phase 3 (Shark Puncher): Move from Sharknado, run from flailing sharks."},
				{"Important", "You need to run the sharks through the chum to slow them down."}, {"TANK", "Go too close to the side of the arena and spectators will throw fruit. Heavy fruit."}}, -- RoB: Ludwig Von Tortollan
	[126969] = {{"Important", "Phase 1 (Pig). You need to click him 5 times as a group."}, {"Important", "Phase 2 (Turtle): Dodge the big shells."}, {"Important", "Phase 3 (Shark Puncher): Move from Sharknado, run from flailing sharks."},
				{"Important", "You need to run the sharks through the chum to slow them down."}, {"TANK", "Go too close to the side of the arena and spectators will throw fruit. Heavy fruit."}}, -- RoB: Trothak (Shark Puncher)
	[126983] = {{"Important", "When marked with Cannon Barrage run from the party. You'll spawn swirls."}, {"Important", "Prioritize the adds that spawn. They'll fixate a player and self-destruct. CC, slow, kill."},
				{"Important", "Sabers spawn near the boss and fly in the direction they're facing. Stand between them."}, {"Important", "At 30% life he'll take and deal double damage. Save defensive, and offensive cooldowns."}, {"Fluff", "Not good looking."}}, -- Harlan Sweete
	
	
	----- King's Rest -----
	-- Trash toward Golden Serpent
	[133935] = {{"Important", "Frontal Cleave ('Suppression Slam', stuns, dodgeable by tank)"}, {"Tank", "MUCH more dangerous with the Released Inhibitors buff (gained a few moments in). Take care."}}, -- Animated Guardian
	[133943] = {{"Important", "Fixates random players and fears if they touch."}, {"Important", "Purge / Mass Dispel / Arcane Torrent will instantly kill them."}}, -- Minion of Zul
	[134158] = {{"Important", "Will block all spells from a direction with Vigilant Defense. Attack from behind."}, {"TANK", "Deals very heavy damage with Ancestral Fury. Cooldown if no soothe available."},
				{"DRUID", "Soothe: Ancestral Fury (+100% dmg)"}, {"HUNTER", "Tranq Shot: Ancestral Fury (+100% dmg)"}}, -- Shadow-Borne Champion
	[134174] = {{"Interrupts", "Interrupt(!!): Shadowbolt Volley (AoE nuke)"}}, -- Shadow-Borne Witch Doctor
	[134157] = {{"Important", "Do your best to avoid the tornados. Melee especially."}}, -- Shadow-Borne Warrior
	
	-- Trash toward Mchima. The traps.
	[137474] = {{"Important", "Bladestorm will wreck your life. Dread it. Run from it. Bladestorm arrives all the same."}}, -- King Timalji
	[137478] = {{"Important", "Will Mind Control a random player. Dispel it. Don't kill them."}}, -- Queen Wasi
	
	[134331] = {{"Important", "Channels HEAVY AoE lightning. Move. Quickly."}, {"Important", "If you stopped to read this you're probably already dead."}}, -- King Rahu'ai
	[137473] = {{"Interrupts", "Stun Interrupt(!): Axe Barrage (Heavy AoE DoT)"}}, -- Guard Captain Atu
	[134251] = {{"Interrupts", "Interrupt or Purge(!!): Induce Regeneration (big ST heal)"}}, -- Seneschal M'bara
	
	[137486] = {{"Important", "Don't stand in the big purple pools. Easy."}}, -- Queen Patlaa
	[137487] = {{"Important", "Will leap to a random player and then spam cleave. Just move away / behind it."}}, -- Skeletal Hunting Raptor
	
	[137484] = {{"Important", "While debuffed you'll poop pools behind you. Don't drop them on friends."}, {"HEALER", "Dispel: Hidden Blade (Poison, causes the green pools)"}}, -- King A'akul
	[137485] = {{"Important", "Will teleport to the purple swirls and AoE. Just move from them."}}, -- Bloodsword Agent
	
	
	[134739] = {{"Important", "Will spin a beam in a clockwise direction. Follow it around so you don't get hit."}, {"Important", "Don't stand in the fire. You've been practicing for 14 years."}}, -- Purification Construct

	-- Trash toward Council. The walkway.
	[135204] = {{"Interrupts", "Interrupt(!): Hex (long adorable CC)"}}, -- Spectral Hex Priest
	[135167] = {{"PriorityTargets", "Priority Target"}, {"Important", "The tank must stay within 10 yards of the mob to soak Severing Blade casts."},
				{"Important", "The mob will leap to random players. Don't stand too far away, and run when he moves."}, {"HEALER", "These deal HEAVY tank damage. It's Ironbark / Sac / Guardian Spirit time."}}, -- Spectral Beserker
	[135231] = {{"Important", "Huge, easily dodgeable ground AoE attack. Ranged should keep distance to minimize movement."}}, -- Spectral Brute
	[135239] = {{"Important", "You must kill the Healing Tide Totem they put down."}}, -- Spectral Witch Doctor
	[135235] = {{"Important", "If targeted by Poison Barrage you must move out of the party."}, {"Important", "A large cone AoE will be fired in your direction and only you must be hit."},
				{"Important", "Also has a knockback. Stand close to the edge at your own peril."}}, -- Spectral Beastmaster
	[135192] = {{"Important", "Wait for it to jump to a target, then run behind it. It's like a cleave."}}, -- Honored Raptor	
	
	-- Trash toward Dazar
	[138489] = {{"Important", "If afflicted with Dark Revelation then run from the group. Deals proximity dmg on expiry."}, {"Important", "On debuff expiry focus fire the add that spawns."},
				{"Important", "One player stands in each dark pool. You'll soak the damage for the party."}}, -- Shadow of Zul
	
	-- Bosses
	[135322] = {{"Important", "When afflicted with Spit Gold you should run to a corner that your party pre-selects."}, {"Important", "You'll drop a pool when it expires. You want all the pools grouped closely together"},
				{"Important", "When Lucre's Call is cast all pools will turn into adds which will run to the boss."}, {"Important", "CC them, slow them, kill them. If they reach the boss he'll get an absorb shield and dmg buff."},
				{"Important", "When the boss is low CC the adds and burn him down."}, {"Important", "Dodge the Serpentine Gust. It's a basic 15yd AoE."}, 
				{"TANK", "You need to pull the boss away from the gold blobs wherever possible. You're first to die if they reach him."},
				{"HEALER", "Spit Gold targets will need heavy spot healing."}, {"HEALER", "You have CC of your own. Time to pull out that utility."}}, -- The Golden Serpent
		[135406] = {{"Important", "When afflicted with Spit Gold you should run to a corner that your party pre-selects."}, {"Important", "You'll drop a pool when it expires. You want all the pools grouped closely together"},
				{"Important", "When Lucre's Call is cast all pools will turn into adds which will run to the boss."}, {"Important", "CC them, slow them, kill them. If they reach the boss he'll get an absorb shield and dmg buff."},
				{"Important", "When the boss is low CC the adds and burn him down."}, {"Important", "Dodge the Serpentine Gust. It's a basic 15yd AoE."}, 
				{"TANK", "You need to pull the boss away from the gold blobs wherever possible. You're first to die if they reach him."},
				{"HEALER", "Spit Gold targets will need heavy spot healing."}, {"HEALER", "You have CC of your own. Time to pull out that utility."}}, -- The Golden Serpent (Animated Gold)
				
	[134993] = {{"Important", "Mchimba here is going to shut one of you in a crypt. Spam action button to shake your coffin."}, {"Important", "The rest of the party finds the wiggling sarcophagus and lets them out"},
				{"Important", "Opening the wrong one spawns a mummy. Interrupt its Wretched Discharge or pay the price."}, {"Important", "There's also plenty of fire around the room to dodge."},
				{"HEALER", "Debuff: Drain Fluids / Dessication. Spam heal the player to above 90% life."}}, -- Mchimba
	[135470] = {{"Important", "Council. Order you fight them in changes week to week. When you kill one they'll cast as spirits."}, {"Important", "Aka'ali: Barrel Through. targeted on player. Rest of party stands between them and boss to soak."},
				{"Important", "Kula: Dodge the spinning axes"}, {"Important", "Zanazal(!!!): Kill the Explosive Totem immediately. Party wipe if cast goes off."}, {"Important", "Totem kill order is otherwise Explosive > Thundering > Torrent > Earthwall"},
				{"TANK", "Aka'ali: Run away from boss after Debilitating Backhand knockback. You take triple dmg during debuff."}, {"HEALER", "Kula: Spot heal the Severing Axe debuff."}}, -- Council of Tribes (Aka'ali the Conqueror)
	[135475] = {{"Important", "Council. Order you fight them in changes week to week. When you kill one they'll cast as spirits."}, {"Important", "Aka'ali: Barrel Through. targeted on player. Rest of party stands between them and boss to soak."},
				{"Important", "Kula: Dodge the spinning axes"}, {"Important", "Zanazal(!!!): Kill the Explosive Totem immediately. Party wipe if cast goes off."}, {"Important", "Totem kill order is otherwise Explosive > Thundering > Torrent > Earthwall"},
				{"TANK", "Aka'ali: Run away from boss after Debilitating Backhand knockback. You take triple dmg during debuff."}, {"HEALER", "Kula: Spot heal the Severing Axe debuff."}}, -- Council of Tribes (Kula the Butcher)
	[135472] = {{"Important", "Council. Order you fight them in changes week to week. When you kill one they'll cast as spirits."}, {"Important", "Aka'ali: Barrel Through. targeted on player. Rest of party stands between them and boss to soak."},
				{"Important", "Kula: Dodge the spinning axes"}, {"Important", "Zanazal(!!!): Kill the Explosive Totem immediately. Party wipe if cast goes off."}, {"Important", "Totem kill order is otherwise Explosive > Thundering > Torrent > Earthwall"},
				{"TANK", "Aka'ali: Run away from boss after Debilitating Backhand knockback. You take triple dmg during debuff."}, {"HEALER", "Kula: Spot heal the Severing Axe debuff."}}, -- Council of Tribes (Zanazal the Wise)
	[136160] = {{"Important", "Busy boss, but most of it isn't threatening."}, {"Important", "Dodge tornados, move away from the raptor after it leaps. Kill Reban quickly when he spawns."},
				{"Important", "Will cast an uninterruptable fear while riding T'zala. Again, not that dangerous."}, {"Important", "At 40% you'll have to dodge patterns of brown spear swirls. Focus on your movement instead of DPS."}}, -- Dazar, The First King
		
	
	----- Siege of Boralus -----
	-- Siege has multiple IDs for a lot of mobs. I'm theorising that they change after your first clear (with the first being tied heavily into the questline) but that needs more testing.
	-- Until then this section is a mess of duplicates. Horde / Alliance also see different mobs leading up to the first boss. Same mechanics, different names / IDs. So there's that too.
	
	-- Path to the Horde / Alliance boss
	[141283] = {{"Important", "Look. This isn't related to the mob, but don't swim in the water. A shark will eat you."}, {"Important", "Frontal Cleave ('Slobber Knocker', tank can dodge)"}}, -- Kul Tiran Halberd
	[141565] = {{"PriorityTargets", "Priority Target"}, {"Important", "Mostly just wreck your tank including a -haste debuff."}}, -- Kul Tiran Footman
	[141284] = {{"Interrupts", "Interrupt or Purge(!!!): Watertight Shell (90% AoE DR, AoE damage on expiration)"}}, -- Kul Tiran Wavetender
	[132532] = {{"Important", "Throws fire at random players. Mostly harmless."}}, -- Kul Tiran Marksman
	[132481] = {{"Important", "Frontal Cleave ('Heavy Slash', stuns, tank can dodge)"}}, -- Kul Tiran Vanguard
	[133990] = {{"Important", "Completely harmless. Your healer could 1 v 1 it."}}, -- Scrimshaw Gutter
	[138002] = {{"Important", "Completely harmless. Your healer could 1 v 1 it."}}, -- Scrimshaw Gutter (2nd ID)
	[129374] = {{"Important", "No notable mechanics."}}, -- Scrimshaw Enforcer
	[143934] = {{"Important", "Dangerous. Don't punch."}}, -- Bloodcrazed Shark
	
	-- Path to Lockwood
	[144071] = {{"Interrupts", "Interrupt or Purge(!!!): Watertight Shell (90% AoE DR, AoE damage on expiration)"}}, -- Irontide Waveshaper (wavetender dup)
	[129370] = {{"Interrupts", "Interrupt or Purge(!!!): Watertight Shell (90% AoE DR, AoE damage on expiration)"}}, -- Irontide Waveshaper (wavetender dup, 2nd ID)
	[138254] = {{"Important", "Throws fire at random players. Mostly harmless."}}, -- Irontide Powdershot (marksman dup)
	[137521] = {{"Important", "Throws fire at random players. Mostly harmless."}}, -- Irontide Powdershot (marksman dup, 2nd ID)
	[129373] = {{"Important", "Will charge random players. Spread out."}}, -- Dockhound Packmaster
	[129640] = {{"PriorityTargets", "Priority Target"}, {"Important", "The hound and packmaster get +125% dmg while together so kill the dog quickly."}}, -- Snarling Dockhound
	[129371] = {{"Important", "Watch for the swirl he'll mark on the ground. He's apparently a stealthy little shit."}, {"Important", "Frontal Cleave ('Singing Steel', tank can dodge)"}}, -- Riptide Shredder
	[129369] = {{"Important", "Has an AoE attack called Savage Tempest. Step away from the mob at that time."}, {"Important", "Will hook random players and there's nothing you can do about it."}}, -- Irontide Raider
	[129372] = {{"Important", "Spread 5 yards and dodge any Burning Tar patches."}}, -- Blacktar Bomber
	[138247] = {{"PriorityTargets", "Stacks a curse on the tank. Dispel it, or focus this mob first."}}, -- Irontide Marauder
	[128969] = {{"Important", "Will focus a random player and charge toward them. All players must dodge this."}, {"Important", "Once fixated he won't follow the player, so even they can avoid it."},
				{"Important", "Will cast Bolstering Shout (DR buff to nearby allies). Try and tank him away from the others where possible."}}, -- Ashvane Commander
	[138255] = {{"Important", "Keep her rooted or slowed to stop her leaping around the room."}, {"Important", "A player will get a Sighted Artillery debuff. Their location is hit with missiles every 1.5s"},
				{"Important", "These missiles also damage trash. Use wisely and don't die."}}, -- Ashvane Spotter
	[138464] = {{"Important", "Frontal Cleave ('Crimson Swipe')"}}, -- Ashvane Deckhand
	[135258] = {{"Important", "Completely harmless. Your grandma could 1 v 1 it."}}, -- Irontide Marauder
	
	-- Path to Darkfathom
	[129366] = {{"Important", "D-don't walk into the bananas."}}, -- Bilge Rat Buccaneer
	[135241] = {{"Important", "Frontal Cleave ('Viscous Slobber', tank can't dodge)"}}, -- Bilge Rat Pillager
	[135245] = {{"Important", "Frontal Cleave ('Crushing Slam', stuns, tank CAN dodge)"}, {"Important", "Terrifying Roar is a 30yd AoE Fear. Ranged players should stand at max distance."}}, -- Bilge Rat Demolisher
	[129367] = {{"Interrupts", "Interrupt(!): Revitalizing Mist (Big ST heal)"}, {"Interrupts", "Interrupt or Dispel(!): Choking Waters (DoT, silence)"}}, -- Bilge Rat Tempest
	[137511] = {{"Important", "Moderate tank threat. Stacks -healing debuff."}, {"HEALER", "Dispel: Rotting Wounds (Disease, -healing, stacks)"}}, -- Bilge Rat Cutthroat
	
	
	-- Bosses
	[144158] = {{"Important", "Focus all adds over the boss until he's low."}, {"Important", "Boss will fixate a ranged player who must kite. He'll hit you with iron pipe if he catches you."},
				{"Important", "Kite the boss into the munitions to stun him."}, {"Important", "Will re-fixate every 20 seconds. He does speed up so if you're going to get hit then pop defensive CD."},
				{"DRUID", "BEAR FORM THE IRON PIPE. Or... just run."}}, -- Sergeant Bainbridge (Horde version of the boss)
	[128649] = {{"Important", "Focus all adds over the boss until he's low."}, {"Important", "Boss will fixate a ranged player who must kite. He'll hit you with iron pipe if he catches you."},
				{"Important", "Kite the boss into the munitions to stun him."}, {"Important", "Will re-fixate every 20 seconds. He does speed up so if you're going to get hit then pop defensive CD."},
				{"DRUID", "BEAR FORM THE IRON PIPE. Or... just run."}}, -- Sergeant Bainbridge (Horde version of the boss)
				
	[144160] = {{"Important", "Focus all adds over the boss until he's low."}, {"Important", "Boss will fixate a ranged player who must kite. He'll hit you with iron pipe if he catches you."},
				{"Important", "Kite the boss into the munitions to stun him."}, {"Important", "Will re-fixate every 20 seconds. He does speed up so if you're going to get hit then pop defensive CD."},
				{"DRUID", "BEAR FORM THE IRON PIPE. Or... just run."}}, -- Chopper Redhook (Alliance version of the boss)
	[128650] = {{"Important", "Focus all adds over the boss until he's low."}, {"Important", "Boss will fixate a ranged player who must kite. He'll hit you with iron pipe if he catches you."},
				{"Important", "Kite the boss into the munitions to stun him."}, {"Important", "Will re-fixate every 20 seconds. He does speed up so if you're going to get hit then pop defensive CD."},
				{"DRUID", "BEAR FORM THE IRON PIPE. Or... just run."}}, -- Chopper Redhook (Alliance version of the boss, second ID for some reason)
				
	[129208] = {{"Important", "Keep her rooted or slowed to prevent her running and Gut Shotting people."}, {"Important", "When boss reaches full energy she'll return to her ship and start firing in patterns."},
				{"Important", "AoE the adds down until a cannoneer drops an ordnance to fire back at the boss."}, {"Important", "This causes her to re-engage and the fight repeats."},
				{"Important", "Frontal Cleave (Deckhands & boss)"}}, -- Dread Captain Lockwood
				
	[128651] = {{"Important", "Will shoot damaging pools in a straight line in front of him. Don't stand in them."}, {"Important", "You'll want to tank him near a corner to minimize space taken up by pools."},
				{"Important", "He'll also target random allies with Break Water which leave identical pools. Watch your position."}, {"Important", "Hide behind the statue during the massive wave. It won't hurt you there."}}, -- Hadal Darkfathom
	[130086] = {{"Important", "Will shoot damaging pools in a straight line in front of him. Don't stand in them."}, {"Important", "You'll want to tank him near a corner to minimize space taken up by pools."},
			{"Important", "He'll also target random allies with Break Water which leave identical pools. Watch your position."}, {"Important", "Hide behind the statue during the massive wave. It won't hurt you there."}}, -- Hadal Darkfathom

	
	[128652] = {{"PriorityTargets", "Target order: Demolishing Terror > Gripping Terror. Target swap whenever a new Demo spawns."}, {"Important", "Demolishers need to be tanked quickly or they'll deal crushing AoE damage to the party."},
				{"Important", "Killing Gripping Terrors will reactive the cannon. Use it to damage the boss."}, {"Important", "After firing cannon move left to the next one. There are three total. The water hurts. Don't swim."},
				{"HEALER", "The cannons line of sight healing. Zzzzzzzzzzzzzz."}, {"HEALER", "Dispel Putrid Waters on cooldown or the 30s debuff will overwhelm you."}}, -- Viq'Goth
		[137614] = {{"PriorityTargets", "Target order: Demolishing Terror > Gripping Terror. Target swap whenever a new Demo spawns."}, {"Important", "Demolishers need to be tanked quickly or they'll deal crushing AoE damage to the party."},
				{"Important", "Killing Gripping Terrors will reactive the cannon. Use it to damage the boss."}, {"Important", "After firing cannon move left to the next one. There are three total. The water hurts. Don't swim."},
				{"HEALER", "The cannons line of sight healing. Zzzzzzzzzzzzzz."}, {"HEALER", "Dispel Putrid Waters on cooldown or the 30s debuff will overwhelm you."}}, -- Viq'Goth (Demolishing Terror)
		[137405] = {{"PriorityTargets", "Target order: Demolishing Terror > Gripping Terror. Target swap whenever a new Demo spawns."}, {"Important", "Demolishers need to be tanked quickly or they'll deal crushing AoE damage to the party."},
				{"Important", "Killing Gripping Terrors will reactive the cannon. Use it to damage the boss."}, {"Important", "After firing cannon move left to the next one. There are three total. The water hurts. Don't swim."},
				{"HEALER", "The cannons line of sight healing. Zzzzzzzzzzzzzz."}, {"HEALER", "Dispel Putrid Waters on cooldown or the 30s debuff will overwhelm you."}}, -- Viq'Goth (Gripping Terror)
	
	
	
	----- Temple of Sethraliss -----
	-- Path to Twin Snakes
	[134600] = {{"Important", "Will cast a slow Power Shot at a player. Hits in a line and all players should avoid when cast starts."}, {"Important", "No threat table. Attacks random players."},
				{"Important", "Don't move with Neurotoxin unless in the way of Power Shot. It'll sleep you."}}, -- Sandswept Marksman
	[134900] = {{"Interrupts", "Interrupt(!): Healing Surge (moderate heal)"}, {"Interrupts", "Will also lightning bolt random players but this is low priority."}}, -- Charged Dustdevil
	[134991] = {{"Important", "Has a 30yd mini-interrupt. Casters must stand further away."}}, -- Sandfury Stonefist
	[134616] = {{"Important", "These interrupt random players. I hate to say this, but you're going to have to kill some puppies."}}, -- Krolusk Pup
	[134602] = {{"Important", "Will blade flurry the tank. Tank can take it but nearby melee should stay 5yds away."}}, -- Shrouded Fang (stealthed)
	[134990] = {{"Interrupts", "Interrupt(!!): Healing Surge (Large ST Heal)"}}, -- Charged Dust Devil
	
	-- Path to Merektha
	[134629] = {{"Important", "Frontal Cleave (Noxious Breath, DoT, tank can dodge after cast start)"}, {"Important", "They also have a SECOND frontal cleave so definitely face away"},
				{"Important", "When Electrified Scales is up you'll take reflect damage. Don't stop DPS, just watch health."}}, -- Scaled Krolusk Rider
	[135562] = {{"HEALER", "Dispel: Cytotoxin (Poison, Stacking DoT, dispel on 2+)"}}, -- Venomous Ophidian
	[135846] = {{"PriorityTargets", "Priority Target"}, {"Important", "Drag mobs out of the sandcloud they drop. It causes everything to miss."}}, -- Sand-Crusted Striker
	[134686] = {{"Important", "Frontal Cleave (Scouring Sand, large area)"}, {"Important", "Frontal Cleave (Noxious Breath, DoT, tank can dodge after cast start)"}}, -- Mature Krolusk
	[139422] = {{"Important", "Frontal Cleave"}, {"Important", "When Electrified Scales is up you'll take reflect damage. Don't stop DPS, just watch health."}}, -- Scaled Krolusk Tamer
	[139425] = {{"Important", "Move out of the lightning circles on the ground"}, {"Important", "Will self destruct when low. Kill quickly or move away from it."},
				{"Interrupts", "Interrupt(!!): Stoneshield Potion (90% damage reduction)"}}, -- Crazed Incubator
	[134364] = {{"Important", "Healer mob. Don't pull too many at once or you'll spend half your timer here."}, {"Interrupts", "Stun Interrupt: Drain (big heal, dmg buff)"}, 
				{"Interrupts", "Interrupt: Greater Healing Potion (Big heal)"},
				{"HEALER", "Dispel: Venomous Spit (Poison, DoT, Stacks)"}}, -- Faithless Tender
	[134390] = {{"PriorityTargets", "Priority Target"}, {"Important", "Drag mobs out of the sandcloud they drop. It causes everything to miss."}}, -- Sand-crusted Striker
	
	-- Path to Galvazzt
	[136076] = {{"Interrupts", "Interrupt or Purge(!!): Accumulate Charge (damage buff)"}, {"Important", "Will deal heavy AoE damage based on number of charges."}}, -- Agitated Nimbus
	[134599] = {{"Important", "Don't stand in the swirls."}, {"Important", "Will Shock random players for medium damage. Save your kicks for the Nimbus."}}, -- Imbued Stormcaller
	[134691] = {{"Important", "Will deal persistent AoE to random allies. Not overly dangerous."}}, -- Static Charged Dervish
	
	-- Path to Avatar
	[139110] = {{"Important", "Engaging him will stop sparks on the bridge so your... less-mobile allies can make it across."}, {"Important", "Dodge the blue swirls."},
				{"Interrupts", "Interrupt: Shock (damage burst on random ally)"}}, -- Spark Channeler
	[135971] = {{"Important", "Exist only to whack the orb carrier. AoE them down, keep as much threat as you can."}, {"Important", "Respawn after a minute or so."}}, -- Faithless Conscript
	[135007] = {{"PriorityTargets", "Priority Target"}, {"Important", "You need to pick up orbs from each side of the room and move them to the big skull door."},
				{"Important", "You can throw the orbs between players with the extra action button and should do so"}, {"Important", "Getting hit by a mob will cause you to drop it and be unable to pick it back up for a bit."},
				{"Important", "This mob will steal the orb back. CC them and focus them down."}, {"Important", "Respawn after a minute or so."}}, -- Orb Guardian
	[136250] = {{"HEALER", "Dispel: Flame Shock (Magic, moderate DoT)"}}, -- Hoodoo Hexer (also involved in boss fight)
	[139949] = {{"Interrupts", "Interrupt: Chain Lightning (AoE dmg)"}, {"HEALER", "Dispel(!!): Snake Charm (Magic, long CC)"}}, -- Plague Doctor
	[139946] = {{"PriorityTargets", "Priority Target"}, {"Important", "Stacks a damage taken increase on the tank. Kite if low DPS."}}, -- Heart Guardian
	
	-- Bosses
	[133944] = {{"Important", "DON'T ATTACK THE ONE WITH LIGHTNING SHIELD"}, {"Important", "Lightly spread around the room to minimize movement"}, {"Important", "Run out: Conduction debuff (8 yard AoE on expiry)"}, 
				{"Important", "If you have 0-1 melee then have a ranged stay within 15yds to split Arcing Blade"},
				{"Defensives", "Defensive: Static Shock (2s cast, used when Aspix at 100 energy)"}}, -- A&A: Aspix
	[133379] = {{"Important", "DON'T ATTACK THE ONE WITH LIGHTNING SHIELD"}, {"Important", "Lightly spread around the room to minimize movement"}, {"Important", "Run out: Conduction debuff (8 yard AoE on expiry)"}, 
				{"Important", "If you have 0-1 melee then have a ranged stay within 15yds to split Arcing Blade"},
				{"Defensives", "Defensive: Static Shock (2s cast, used when Aspix at 100 energy)"}}, -- A&A: Adderis
	[133384] = {{"Important", "LOOK AWAY DURING BLINDING SAND. AHHHHH."}, {"Important", "You can break allies from snakes with stun / incap. Otherwise DPS them out."}, 
				{"Important", "Boss only burrows twice. Even on tyrannical +30."},
				{"Important", "During Boss burrow: DPS the adds and watch out for her dashes across the arena."},
				{"HEALER", "Dispel: Cytotoxin (Posion, heavy DoT)"}}, -- Merektha
	[133389] = {{"Important", "You need to intercept beams so they don't hit boss or he'll gain energy"}, {"Important", "Beams debuff you and deal more damage over time. Take full beam, then switch for next set"},
				{"Defensives", "Defensive: Consume Charge (at 100 energy, heavy AoE)"}, {"HEALER", "Damage gets worse longer the fight lasts. Channel healing into beam soakers"},
				{"HEALER", "Healing CD: Consume Charge. Cast as boss nears 100 energy since party likely isn't topped"}}, -- Galvazzt
	[133392] = {{"Important", "Kill Order: Heart Guardian > Toads > Plague Doctor > Hoodoo Hexer"}, {"Important", "Toads must be kept off your healer. They can be CC'd to buy time"},
				{"HEALER", "After hexers die you can heal boss in increments of 10->40, 40->70, 70-100% health"}, {"HEALER", "You have as MUCH TIME AS YOU NEED. New hexers won't spawn until you heal him 30%."},
				{"HEALER", "That means don't burn all of your mana rushing it. Save your cooldowns for the rest of the fight"}}, -- Avatar of Sethraliss (Friendly)
	
	
	----- Motherlode!! -----
	-- Path to the... coin dude
	[130436] = {{"Important", "Will wang random allies with wrenches. Just heal through it."}}, -- Off-Duty Laborer
	[136470] = {{"PriorityTargets", "Priority Target"}, {"Interrupts", "Interrupt(!): Iced Spritzer (DoT, stun if full channel)"},
				{"Interrupts", "Interrupt(!): Kaja'Cola Refresher (HoT)"}, {"HEALER", "You can dispel the Brain Freeze stun if nobody interrupts."}}, -- Refreshment Vendor
	[136006] = {{"Important", "Harmless."}}, -- Rowdy Reveler
	[130488] = {{"Important", "Must be CC'd if they try and run to a mech or they'll get inside."}, {"Important", "Dodge the red swirls to avoid knockback"}}, -- Mech Jockey
	[136139] = {{"Important", "Energy Shield blocks attacks from one direction. Just move around it."}, {"Important", "Watch out for the Tear Gas clouds. They disorient."}}, -- Mechanized Peacekeeper
	[134232] = {{"Interrupts", "Interrupt(!): Toxic Blades (causes DoT on all attacks)"}, {"Important", "Stun / CC Interrupt(!): Hail of Flechettes (heavy AoE)"},
				{"Important", "The Flechettes have a huge radius so outranging isn't really an option."}}, -- Hired Assassin
	[130435] = {{"Important", "Will charge random allies and stun them. Rude."}, {"Interrupts", "Interrupt: Inhale Vapors (+50% phys dmg)"}, {"DRUID", "Soothe: Inhale Vapors"},
				{"HUNTER", "Tranq Shot: Inhale Vapors"}}, -- Addled Thug
	
	-- Path to the... rock dude
	[130653] = {{"Important", "When sappers get low they'll cast Final Blast. Kill or CC them to prevent the cast or move away from it."},
				{"Important", "The big red swirls hurt. You have five seconds to move from them."}}, -- Wanton Sapper
	[130437] = {{"Important", "Pelt random allies with rocks. Annoying but not dangerous."}}, -- Mine Rat
	[130661] = {{"Interrupts", "Interrupt or Purge(!): Earth Shield (DR + healing when hit)"}}, -- Venture Co. Earthshaper
	[136643] = {{"Important", "Frontal Cleave (Power through)"}}, -- Azerite Extractor
	[136688] = {{"Important", "Moderate tank damage."}}, -- Fanatical Driller
	[130635] = {{"Interrupts", "Interrupt(!!): Furious Quake (Heavy AoE)"}, {"Interrupts", "Interrupt or Purge(!): Tectonic Barrier (DR + interrupt immunity)"}}, -- Stonefury
	[134005] = {{"Important", "Mostly harmless."}}, -- Shalebiter
	[134012] = {{"Important", "During the Cower cast just drag away nearby trash. It's a big DR shield."}, {"Important", "Will deal heavy tank damage when below 20% HP."},
				{"Important", "Kill the Sappers first. This guy isn't too dangerous."}}, -- Taskmaster Askari
	
	-- Path to the boss whose name I can't remember because she dies so quickly
	[133345] = {{"Interrupts", "Interrupt(!!): Transfiguration Serum"}, {"Interrupts", "Interrupt: Blowtorch (frontal cone AoE)"}}, -- Feckless Assistant
	[136934] = {{"Important", "This mob is awful. During Force Cannon you need to rotate around him. Randomly targeted."}, {"Important", "Frontal Cleave (Echo Blade, tank can't dodge, silences)"},
				{"HEALER", "You can dispel the Echo Blade silence debuff that hopefully only the tank got."}}, -- Weapons Tester
	[133432] = {{"Interrupts", "Interrupt or Dispel: Transmute Enemy to Goo (10s Polymorph)"}}, -- Venture Co. Alchemist
	[133430] = {{"PriorityTargets", "Priority Target"}, {"Important", "Watch out for the purple orbs. They heal the mob."}, {"Important", "Purge: Azerite Injection (heal, +dmg)"}, 
				{"HEALER", "Energy Lash targets need heavy spot healing."}}, -- Venture Co. Mastermind
	[133963] = {{"Important", "Mostly harmless but do get stronger over time so clear them quickly."}}, -- Test Subject
	
	-- The part you probably want to invis potion
	[133482] = {{"Important", "These will fixate a player and explode. Kill them quickly or kite them."}}, -- Crawler Mine
	[137029] = {{"Interrupts", "Interrupt: Artillery Barrage (conjures 100 red swirls to dodge)."}}, -- Ordnance Specialist
	[133436] = {{"Important", "Will fixate a target with a red laser. It can be intercepted by standing in it when shot fires."}, {"Important", "The shot does give you a -healing debuff, so take care if the tank soaks it."}}, -- Venture Co. Skyscorcher
	[133463] = {{"Important", "Will rock the tank with Charged Shot. They'll need a defensive."}}, -- Venture Co. War Machine
	[133593] = {{"Interrupts", "Stun Interrupt(!): Repair (heal on the war machine)"}, {"Interrupts", "Interrupt: Overcharge (haste buff on war machine)"}}, -- Expert Tactician
	
	-- Bosses
	[129214] = {{"Important", "Let's play football. The boss will throw balls around the arena."}, {"Important", "You have to click them to kick them toward the boss. You have to aim them."},
				{"Important", "Any that aren't kicked into the boss will explode for big AoE damage."}, {"Important", "Frontal Cleave (Shocking Claw, tank dodgeable after cast starts)"},
				{"TANK", "Try and move the boss away from the coin piles. He'll suck them in for a damage bonus."}}, -- Coin-Operated Crowd Pummeler
	[129227] = {{"Important", "The adds will fixate random targets. They must be kited and killed very quickly."}, {"Important", "Frontal Cleave (Tectonic Smash, tank can dodge after cast start)."},
				{"Important", "Boss will sometimes empower an add, it'll deal and take more damage. Nuke it."}, {"Important", "When the boss casts Resonant Pulse all alive adds must be CC'd."},
				{"HEALER", "Almost all of the damage is in the first minute. Pop your cooldowns immediately."}}, -- Azerokk
	[129231] = {{"Important", "You can use Propellant Blast to push the azerite pools off the platform."}, {"Important", "Other than that, don't stand in pools and this is very easy."},
				{"HEALER", "Dispel: Chemical Burn (DoT)"}}, -- Rixxa Fluxflame
	[129232] = {{"Important", "Homing Missle will target ranged players. Run it from the group."}, {"Important", "Two boomba adds will fly around the arena. They'll fire red swirlies across 3/4 of the platform."},
				{"Important", "You can avoid them by looking up at standing in the quarter they're not facing."}, {"Important", "In P2 all players must stand near the brown rockets (look like closets)"},
				{"Important", "Random player will be targeted and resulting Drill Smash will break the rockets."}, {"Important", "Break them all and boss will return to platform."},
				{"HEALER", "Phase 1 is damage light, phase 2 quite heavy. Save your cooldowns."}}, -- Mogul Razdunk
	
	
	----- The Underrot -----
	-- Path to Elder Leaxa
	[131402] = {{"Important", "Look small but are vicious."}, {"Important", "Stacks HEAVY DoT on the tank and explodes on death."}, 
				{"Important", "Pull as few of these as possible and stagger your kills so your healer can recover."}}, -- Underrot Tick
	[130909] = {{"Important", "Frontal breath in a random allies direction."}, {"Important", "Wait until the cast starts, then make sure you're nowhere near the front of the mob."}}, -- Fetid Maggot
	[131436] = {{"PriorityTargets", "Priority Target"}, {"Important", "Frontal Cleave (Savage Cleave, heavy damage + DoT)"}, {"Important", "Warcry heavily buffs all nearby enemies. It can be soothed / tranq shotted."}, 
				{"Important", "Try and go down whichever path has fewer Blood Matrons"}}, -- Chosen Blood Matron
	[133663] = {{"Important", "Will pelt random allies. Hooked Snare is a DoT. Consider defensives here."}}, -- Fanatical Headhunter
	[131492] = {{"Interrupts", "Interrupt(!!): Dark Reconstitution (big heal)"}, {"Interrupts", "Interrupt or Purge(!): Gift of G'huun (+100% damage, unkillable)"}}, -- Devout Blood Priest
	[133685] = {{"Interrupts", "Interrupt(!!!): Harrowing Despair (BIG AoE)"}, {"Important", "Will also channel on random players. Spread a little so you don't share the damage"}, 
				{"HEALER", "Dark Omen should be on you bars and they'll need some decent healing."}}, -- Befouled Spirit
	
	-- The Crag
	[133835] = {{"Important", "Will fixate a random player. Kite, CC, don't get hit."}, {"Interrupts", "Interrupt: Sonic Screech (AoE damage, interrupts spells)"}}, -- Feral Bloodswarmer
	[133870] = {{"Interrupts", "Interrupt(!!): Decaying Mind (Long CC)"}, {"Important", "If a Decaying Mind goes off it can be cleansed by healing through the healing absorb."},
				{"Important", "It can also be cleansed (disease)"}, {"Important", "If it was targeted on the healer you are likely to wipe. Interrupt it."}}, -- Diseased Lasher
	[133852] = {{"Important", "Drop green pools around them. Can interrupt but low priority."}}, -- Living Rot
	
	-- Path to Sporecaller Zancha
	[133836] = {{"Important", "Will cast Bone Shield, a big absorb on themselves. Try and AoE CC them and burn."}}, -- Reanimated Guardian
	[138338] = {{"Important", "Will cast Bone Shield, a big absorb on themselves. Try and AoE CC them and burn."}}, -- Reanimated Guardian (second ID)
	[138187] = {{"Interrupts", "Interrupt(!!): Death Bolt (AoE dmg + DoT)"}, {"Important", "You really need to interrupt every Death Bolt here."}}, -- Grotesque Horror
	[134284] = {{"Interrupts", "Interrupt: Raise Dead (summons a Guardian)"}, {"Interrupts", "Interrupt or Soothe: Wicked Frenzy (+100% haste)"}}, -- Fallen Deathspeaker
	[133912] = {{"Interrupts", "Interrupt(!!): Withering Curse (+dmg taken, -dmg done)"}, {"Interrupts", "Interrupt(!): Shadowbolt Volley (Medium AoE)"},
				{"Important", "Summons a totem that MUST be killed or run away from within 6 seconds (6yd AoE)."}}, -- Bloodsworn Defiler
	
	-- Path to the Abomination
	[138281] = {{"Important", "Dodge: Maddening Gaze (Long fear, targeted in random players direction)"}, {"Important", "Move away from tentacles when they spawn. They're easy to dodge."}}, -- Faceless Corruptor
	
	
	-- Bosses
	[131318] = {{"Important", "When Leaxa or an add casts Sanguine Feast you must walk away from them"}, {"Important", "Dodge: Creeping Rot (moving ground effect that leaves from boss)"}, 
				{"PriorityTargets", "Priority Target: Blood Effigy"}, {"Interrupts", "Interrupt: Blood Bolt (where possible, ST nuke)"}, 
				{"HEALER", "All boss abilities inflict stacking DoT / healing absorb on target."}}, -- Elder Leaxa
	[131817] = {{"Important", "Larva spawn when boss uses abilities. Stand on them to squish."}, {"Important", "Larva grow into adds if not stood on within 8 seconds"},
				{"Important", "Dodge: Charge (Cast on random target, BIG damage)"}, {"HEALER", "Healing CD: Tantrum (big AoE damage, cast at 100 energy)"}}, -- Cragmaw the Infested
	[131383] = {{"Important", "Every mushroom that explodes leaves a stacking DoT. Avoid taking more than 2 stacks."}, {"Important", "Targeted by Upheaval: stand next to a group of mushrooms then run out of the swirl"}, 
				{"Important", "Run into lone mushrooms to detonate them"}, {"Important", "Boss will explode all mushrooms every ~50s. You must clear all mushrooms beforehand"},
				{"TANK", "Frontal Cleave: It also destroys mushrooms"}, {"HEALER", "Consider saving healing CDs for Boundless Rot since it's big dmg if mushrooms are alive"},
				{"ROGUE", "Immunity: the mushroom debuff. Run into as many as possible"}}, -- Sporecaller Zancha
	[133007] = {{"Important", "Boss gains energy instead of taking damage. At 100 he releases adds."}, {"Important", "Dodge: Floating Spores, Vile Expulsion (Cone targeted at player)"},
				{"Important", "Yellow circle around you? Party stacks in it. Clears your debuffs"}, {"PriorityTargets", "Priority Target: Blood Visage > Boss. Killing Blood Visages damages boss."},
				{"Important", "Spores can be one-shot. Clear any that are getting close."},
				{"HEALER", "Stacking dispellable DoT on entire party. Yellow circle clears it. Dispel newbies that miss circle."}}, -- Unbound Abomination
		[137103] = {{"Important", "Boss gains energy instead of taking damage. At 100 he releases adds."}, {"Important", "Dodge: Floating Spores, Vile Expulsion (Cone targeted at player)"},
				{"Important", "Yellow circle around you? Party stacks in it. Clears your debuffs"}, {"PriorityTargets", "Priority Target: Blood Visage > Boss. Killing Blood Visages damages boss."},
				{"Important", "Spores can be one-shot. Clear any that are getting close."},
				{"HEALER", "Stacking dispellable DoT on entire party. Yellow circle clears it. Dispel newbies that miss circle."}}, -- Unbound Abomination (Blood Visage)
	
	
	
	
	----- Tol Dagor -----
	-- Outside
	[127480] = {{"Important", "Stack a light DoT on the party. Just AoE them down."}}, -- Stinging Parasite
	[127381] = {{"Important", "Will squeeze random players for moderate dmg. Don't pull too many at once."}, {"HEALER", "Make sure you can see the Squeeze debuff on your party frames."},
				{"DRUID", "You can shapeshift out of Squeeze. Nice."}}, -- Silt Crab
	
	
	-- Sewer / Lower Prison
	[127482] = {{"Important", "Will lower the max health of the tank. Don't pull too many at once."}}, -- Sewer Vicejaw
	[130025] = {{"Interrupts", "Interrupt(!!): Debilitating Shout (AoE dmg + dmg dealt reduction"}}, -- Irontide Thug
	[131112] = {{"Important", "Low priority mob. Harmless."}}, -- Cutwater Striker
	[135366] = {{"Important", "Prominent torch chucker. Will give your healer something to dispel but not otherwise dangerous."}, {"HEALER", "Dispel: Torch Strike (Magic, DoT, stacking, dispel at 2+)"}}, -- Blacktooth Arsonist
	[127485] = {{"Important", "Moderate tank damage."}, {"Important", "You can AoE purge (Mass dispel, Arcane Torrent) their Darkstep buff."}}, -- Bilge Rat Looter
	[130582] = {{"Important", ""}}, -- Despondent Scallywag (Neutral)
	[130026] = {{"Interrupts", "Interrupt(!!): Watery Dome (AoE damage reduction)"}}, -- Bilge Rat Seaspeaker
	[135254] = {{"Important", "Harmless."}}, -- Irontide Raider
	[131445] = {{"Important", ""}}, -- Block Warden
	
	-- Upper Prison
	[135699] = {{"Interrupts", "Stun / CC Interrupt: Riot Shield (dmg reduction, spell reflect)"}, {"Important", "Will REFLECT spells during Riot Shield. Ow."}}, -- Ashvane Jailer
	[127486] = {{"Interrupts", "Interrupt(!): Handcuff (Silence, pacify, DoT)"}, {"Interrupts", "Stun / CC Interrupt: Riot Shield (dmg reduction, spell reflect)"}}, -- Ashvane Officer
	[127488] = {{"Important", "Fuselighter will create a swirl under a random player. Dodge. Definitely dodge."}}, -- Ashvane Flamecaster
	[130027] = {{"Important", "Have a threat table but a ranged basic attack."}, {"Important", "Frontal Cleave (Suppression Fire, tank must take, DoT)"}}, -- Ashvane Marine
	[136665] = {{"Important", "Will blow up a barrel when engaged. Don't stand in it."}, {"Important", "Has a threat table but a ranged basic attack."}, 
				{"Important", "Frontal Cleave (Suppression Fire, tank must take, DoT)"}}, -- Ashvane Spotter
	[133972] = {{"Important", "You can get in the cannon to deal HEAVY AoE damage."}, {"Important", "WARNING: FRIENDLY FIRE. THE CANNON ALSO HITS ALLIES."},
				{"Important", "Handle the next few packs by pulling them toward the cannon and then CC'ing in place while cannon kills."},
				{"Fluff", "Up-and-coming super villains can use this opportunity to murder your friends."}}, -- Heavy Cannon (Vehicle, Neutral)
	
	-- Roof
	[127497] = {{"Important", "Lockdown is a slow cast that'll root everyone within 6 yds. Avoid."}, {"TANK", "Consider kiting during the Heavily Armed buff. They'll deal dbl dmg."},
				{"Important", "Drag them toward the cannons. Cannons very buff."}}, -- Ashvane Warden
	[130028] = {{"Important", "Righteous Flames is a slow cast that'll disorient everyone within 6 yrds. Avoid."}, {"Interrupts", "Interrupt(!!): Inner Flames (AoE heal, dmg buff)"}}, -- Ashvane Priest
	
	
	-- Bosses
	[127479] = {{"Important", "When she burrows move away from the upheaval target"}, {"Important", "Avoid: Sand mounds (4s stun)"}, 
				{"Important", "Killing drones gives boss a 4s damage buff. Kill in small bunches on higher keys"}, {"HEALER", "Sandstorm (heavy AoE) hits every 30s. Save healing CD's."},
				{"HEALER", "The tank damage can be heavy, especially below 30%"}, {"DRUID", "Soothe: Enrage (Both when adds die, and when she hits 30% HP."},
				{"HUNTER", "Tranq Shot: Enrage (Both when adds die, and when she hits 30% HP."}}, -- The Sand Queen
	[127484] = {{"Important", "Hide around the corner during Flashing Daggers cast or you will die."}, {"Interrupts", "Interrupt: Howling Fear (long AoE fear)"},
				{"Important", "At 50% boss will run away. Chase while killing prisoner adds."}, {"Important", "As soon as you reach boss interrupt his Motivating Cry"},
				{"Important", "During P2 Bobby will join fight and stun ally. Damage his shield off FIRST then interrupt"}, {"HEALER", "Dispel or heal: Crippling Shiv (Poison, medium DoT)"}}, -- Jes Howlis
	[127490] = {{"Important", "You need to pick up and move barrels out of: Cinderflame (cone on random player) and Ignition (big red circles)"}, {"Important", "Everyone must help. You click to pick up, then use extra action bar to drop."},
				{"Advanced", "You only need to keep a corner clean. Tank in a corner and leave the barrels on other side of room."},
				{"Advanced", "There are two barrels near the door when you come in. Move them into the corridor before the fight begins"}}, -- Knight Captain Valyri
	[127503] = {{"Important", "Tank in the north west corner of the room. Everyone spreads around boss with backs to the small walls"}, {"Important", "This will stop you getting pushed back and minimizes movement"},
				{"Important", "You need to dodge the Cross Ignition. It's marked with black paths along the ground."}, {"Important", "If you move more than a few inches then you'll be stunned and likely die."},
				{"HEALER", "Even with good play this is a bursty high damage fight. Try and keep the party topped up."}, {"HEALER", "The group is close together so make sure you keep group heals like Effloresence down."}}, -- Overseer Korgus
	
	
	
	----- Waycrest Manor -----
	-- Entrance Hall
	[135240] = {{"Important", "Moderate damage casts at random allies. Group them up and AoE CC."}}, -- Soul Essence	
	[131677] = {{"Important", "Frontal Cleave (Marking Cleave, tank can dodge after cast start)"}, {"Interrupts", "Interrupt(!): Etch (ST damage channel)"}}, -- Heartsbane Runeweaver
	
	-- Right Side
	[135234] = {{"Important", "Mostly harmless."}}, -- Diseased Mastiff
	[131849] = {{"Important", "Targets random players."}, {"Important", "Will fire a rocket at a random player. Spread out so only one person gets hit."}}, -- Crazed Marksman
	[131850] = {{"Important", "Will throw out traps. One deals heavy damage, one stuns for 8s."}, {"Important", "You really need to make sure you don't walk into them."},
				{"Interrupts", "Interrupt(!): Serving Serpents (AoE disease DoT)"}}, -- Maddened Survivalist
	[134024] = {{"Important", "Harmless UNLESS it has the Parasitic debuff. If it does it must be burned down or interrupted."}, {"Important", "Successful Infest casts will spawn two more maggots"}}, -- Devouring Maggot
	[134041] = {{"Important", "Mostly harmless."}}, -- Infected Peasant
	[135048] = {{"Important", "Mostly harmless. Maybe even cute?"}}, -- Gorestained Piglet
	[137850] = {{"Important", "Frontal Cleave (Retch)"}, {"Important", "Will leap to furthest ally and deal 5yd AoE DoT. Spread a little."}}, -- Pallid Gorger
	[131586] = {{"Interrupts", "Interrupt: Dinner Bell (AoE 8yd silence)"}}, -- Banquet Steward
	[131847] = {{"Important", "Mostly harmless."}}, -- Waycrest Reveler
	
	-- Left Side
	[131670] = {{"Interrupts", "Interrupt or Purge(!): Grasping Thorns (Stun, DoT)"}}, -- Heartsbane Vinetwister
	[131585] = {{"Important", "Frontal Cleave (Shadow Cleave)"}}, -- Enthralled Guard
	[131587] = {{"Interrupts", "Interrupt or Purge: Spirited Defense (medium DR)"}}, -- Bewitched Captain
	--[131685] = {{"Important", ""}}, -- Runic Disciple
	[131818] = {{"Important", "Try and interrupt Runic Mark but if not then the marked player walks away from the group."}, {"Interrupts", "Interrupt or Purge(!!): Soul Fetish (buffs allies on death)"}}, -- Marked Sister
	--[135049] = {{"Important", ""}}, -- Dreadwing Raven
	[135474] = {{"Interrupts", "Interrupt: Bone Splinter, Drain Essence (both DoTs)"}}, -- Thistle Acolyte
	[135052] = {{"Important", "Creates big green swirl on death. Move."}}, -- Blight Toad
	
	-- Courtyard
	[131669] = {{"Important", "Moderate tank damage."}}, -- Jagged Hound
	[131858] = {{"Important", "Heavy tank damage."}, {"Important", "Explodes into a brown swirl on death. Is as nasty as it sounds. Move."}, 
				{"DRUID", "Soothe: Enrage (+25% dmg)"}, {"HUNTER", "Tranq Shot: Enrage (+25% dmg)"}}, -- Thornguard
	[131666] = {{"Important", "Will conjure roots underneath allies. Don't stand in them."}, 
				{"Interrupts", "Interrupt(!!): Effigy Reconstruction (full AoE heal)"}, {"Interrupts", "Interrupt or Purge(!!): Soul Fetish (buffs allies on death)"},
				{"HEALER", "Dispel or heal: Infested Thorn (Disease, medium DoT)"}}, -- Coven Thornshaper
	[135329] = {{"Important", "Very heavy tank damage during uninterruptable Thorned Barrage cast."}, {"Important", "More browl swirls. Move."}}, -- Matron Bryndle
	
	-- Cellar
	[131819] = {{"Interrupts", "Interrupt or Purge(!!): Soul Fetish (buffs allies on death)"}, {"HEALER", "Dispel: Fragment Soul (DoT, buffs the mob later)"}}, -- Coven Diviner
	[135365] = {{"Important", "Spread with Dread Mark. Your healer will give you $5 later."}, {"Interrupts", "Interrupt(!): Ruinous Volley (AoE nuke)"},
				{"TANK", "Have a defensive ready for Decaying Touch. It increases your dmg taken."}}, -- Matron Alna
	[139269] = {{"Important", "Will leap to furthest player and deal 5yd AoE DoT. Have one player stand out."}}, -- Gloom Horror
	[131812] = {{"Important", "Drag mobs out of any candles the soulcharmer drops. Save the romance for later."}, {"Interrupts", "Interrupt: Soul Volley (AoE nuke)"}}, -- Heartsbane Soulcharmer
	
	-- Bosses
	[131863] = {{"Important", "Dodge: Rotten Expulsion, Tenderize (Cone AoEs)"}, {"Important", "If Wasting Servants get to boss he gets damage buff. Ignore them when boss is low."}, 
				{"Important", "Servants vulnerable to ALL CCs if you need more time"}, {"PriorityTargets", "Priority Target: Wasting Servants > Boss. AoE oozelings."},
				{"HEALER", "Low damage so help DPS adds and triage any rookies that stand in puddles."}}, -- Raal the Gluttenous
	[131667] = {{"PriorityTargets", "Priority Target: Soul Thorns (stuns random player until dead)"}, {"HEALER", "Little red spirits will chase you around. Don't stop moving for long"},
				{"HEALER", "Heavy tank damage until boss is dragged over fire, then heavy party damage"}, {"HEALER", "Healing CDs: Burning Brush (moderate AoE)"},
				{"TANK", "Drag the boss into fire to reset his stacks. Do it whenever possible."}}, -- Soulbound Goliath
	[131824] = {{"Important", "Can only dmg one at a time. Don't multi-DoT. Targetable mob will be bigger."}, {"Important", "Aura of Dread: you MUST keep moving. The active aura rotates."},
				{"Important", "Will periodically MC an ally. Switch DPS to them until broken free."},
				{"DAMAGE", "Aura of Thorns: You'll take damage after every attack. Care."}, {"HEALER", "Very hard fight. Aura of Apathy: 50% healing reduction. Conserve mana."},
				{"HEALER", "Spam Heal: Jagged Nettles debuff (heavy DoT, lasts til target is above 90%.)"}, {"HEALER", "Each boss deals heavy AoE at 100 energy. Track it and top the party before."}}, -- Witches: Sister Selena
	[131825] = {{"Important", "Can only dmg one at a time. Don't multi-DoT. Targetable mob will be bigger."}, {"Important", "Aura of Dread: you MUST keep moving. The active aura rotates."},
				{"Important", "Will periodically MC an ally. Switch DPS to them until broken free."},
				{"DAMAGE", "Aura of Thorns: You'll take damage after every attack. Care."}, {"HEALER", "Very hard fight. Aura of Apathy: 50% healing reduction. Conserve mana."},
				{"HEALER", "Spam Heal: Jagged Nettles debuff (heavy DoT, lasts til target is above 90%.)"}, {"HEALER", "Each boss deals heavy AoE at 100 energy. Track it and top the party before."}}, -- Witches: Sister Briar
	[131823] = {{"Important", "Can only dmg one at a time. Don't multi-DoT. Targetable mob will be bigger."}, {"Important", "Aura of Dread: you MUST keep moving. The active aura rotates."},
				{"Important", "Will periodically MC an ally. Switch DPS to them until broken free."},
				{"DAMAGE", "Aura of Thorns: You'll take damage after every attack. Care."}, {"HEALER", "Very hard fight. Aura of Apathy: 50% healing reduction. Conserve mana."},
				{"HEALER", "Spam Heal: Jagged Nettles debuff (heavy DoT, lasts til target is above 90%.)"}, {"HEALER", "Each boss deals heavy AoE at 100 energy. Track it and top the party before."}}, -- Witches: Sister Malady
		[135052] = {{"Important", ""}}, -- Blight Toad
	[131545] = {{"Important", "Virulent Pathogen debuff (green circle): run it out of the group"}, {"Important", "Run out the debuff, stay out of purple swirls and this is very easy fight"},
				{"Important", "Lady will heal Lord a few times using her own health. No counterplay, just keep DPS'ing"}, {"TANK", "Lady Waycrest will fly over at 10% health. You need to taunt her immediately"},
				{"HEALER", "Don't dispel the disease in most cases. Only lasts 5s and they need to run out"}}, -- L&L: Lady Waycrest
	[131527] = {{"Important", "Virulent Pathogen debuff (green circle): run it out of the group"}, {"Important", "Run out the debuff, stay out of purple swirls and this is very easy fight"},
				{"Important", "Lady will heal Lord a few times using her own health. No counterplay, just keep DPS'ing"}, {"TANK", "Lady Waycrest will fly over at 10% health. You need to taunt her immediately"},
				{"HEALER", "Don't dispel the disease in most cases. Only lasts 5s and they need to run out"}}, -- L&L: Lord Waycrest
	[131864] = {{"Important", "Slavers cast Death Lens. Either kill quickly or interrupt cast with knockbacks / grips."}, {"Important", "Yorrick will drop flasks of fire on the floor. Assign one DPS to pick them up"},
				{"Important", "Kill the adds near the boss and then cast Alchemical Fire when boss casts Dread Essence"}, {"Important", "If you don't then he'll resummon all dead adds."},
				{"HEALER", "Add Death Lens to your frame. They'll need big healing if the cast goes through"}}, -- Gorak Tul	
	
	
	
	
	----- Shrine of the Storm -----
	-- Path to Aqu'sirr
	[136347] = {{"Important", "Mostly harmless. They'll run when low so watch for that."}}, --  Tidesage Initiate
	[134139] = {{"Important", "Annoying mob. CC them where possible and kill them alone."}, {"Important", "Frontal Cleave (Heaving blow, stuns, dodgeable by tank)"},
				{"Interrupts", "Interrupt or Purge: Tidal Surge (+haste +dmg)"}}, -- 	Shrine Templar
	[134137] = {{"Important", "Move out of the blue swirl."}, {"Interrupts", "Interrupt as many Water Blasts as you can but it isn't urgent."}}, -- 	Temple Attendant
	[134173] = {{"Important", "Mostly harmless."}}, -- 	Animated Droplet
	[136186] = {{"Interrupts", "Interrupt(!!): Mending Rapids (Massive heal)"}, {"Important", "Anchor of Binding will toss an anchor at a player. Dodgeable."}}, -- 	Tidesage Spiritualist
	[134144] = {{"Important", "Dangerous mob. Will throw players into the air and deal heavy AoE damage."}, {"Important", "You CAN now Line of Sight the Rising Tides. Healers / DPS are encouraged to."}}, -- 	Living Current
	
	-- Path to Council
	[139800] = {{"Important", "Move from the windy zones and dodge any tornadoes."}, {"Interrupts", "Interrupt: Tempest (spawns high damage dodgeable tornadoes)"}}, -- 	Galecaller Apprentice
	[139799] = {{"Important", "Heavy tank damage. AoE 8yd cleave (Whirling Slam, dodgeable)"}, {"TANK", "Kite during the Blessing of Ironsides buff. Mob deals dbl dmg but moves slow."}}, -- 	Ironhull Apprentice
	[134150] = {{"Important", "Ok he'll put a ward down and everyone should stand in it at all times."}, {"Important", "He'll cast Carve Flesh on a random party member."},
				{"Important", "If you're in the ward you'll take -75% dmg and live. If you're 50 yards away you're dead."}, {"TANK", "You want to stand in the ward yourself, while keeping the miniboss out of it."},
				{"HEALER", "Make sure you can see Carve Flesh on your frames. Try and save idiot DPS that isn't in ward."}}, -- 	Runecarver Sorn
	[136249] = {{"Important", "BFA's Mariner. Will channel heavy AoE damage on party."}, {"HEALER", "Make sure you have healing CD's ready. It's predictable but heavy damage."}, 
				{"HEALER", "Dispel: Electrifying Shock (Medium DoT)"}}, -- 	Guardian Elemental
	[136214] = {{"Important", "Jump in the Swiftness Wards she summons for a 25% haste buff"}, {"TANK", "The haste ward also buffs Heldis and any other trash. Drag them out."},
				{"HEALER", "Gale Winds is a moderately harmful AoE channel. You'll need to heal through it."},
				{"Fluff", "With all that haste you'll feel like you're still playing a different expansion."}},
	
	-- Path to Stormsong
	[134417] = {{"Important", "PULL ONE AT A TIME"}, {"Important", "Spread out with Void Seed. It doesn't hurt if you're 6yds apart."}, 
				{"Interrupts", "Interrupt(!!): Unending Darkness (AoE nuke, inc shad dmg taken debuff)"}}, -- 	Deepsea Ritualist
	[139626] = {{"Important", "You can purge their shield to make them easier kills. Arcane Torrent is beautiful here."}}, -- 	Dredged Sailor
	[134338] = {{"Important", "Conjures many blue swirls. I died to them once. Don't be me."}}, -- 	Tidesage Enforcer
	[134418] = {{"Important", "Have many interruptable casts. Priority is Touch of the Drowned > Rip Mind > Void Bolt."}, {"Interrupts", "Interrupt or dispel(!): Touch of the Drowned (medium DoT)"},
				{"Interrupts", "Interrupt: Rip Mind (ST Nuke, -max HP)"}}, -- 	Drowned Depthbringer
	[134514] = {{"Important", "Frontal Cleave ('Mental Assault', stun, tank can dodge)"}, {"Interrupts", "Interrupt or Purge(!): Consuming Void (spell absorb buff)"},
				{"Interrupts", "Interrupt: Detect Thoughts (100% dodge chance, 6s)"}}, -- 	Abyssal Cultist
	[136353] = {{"Important", "Deal heavy AoE damage. Make sure your tank is standing close to them."}}, -- 	Colossal Tentacles
	[134423] = {{"Important", "Deal medium AoE damage. AoE them quickly."}}, -- 	Abyss Dweller
	
	-- The Seas
	[140038] = {{"Important", "Moderate tank damage. Otherwise harmless."}}, -- 	Abyssal Eel
	[136295] = {{"Important", "Heavy tank damage. Slow so can be kited."}}, -- 	Sunken Denizen
	[136297] = {{"Interrupts", "Interrupt(!!) Consume Essence (AoE Nuke + full AoE heal)"}}, -- 	Forgotten Denizen
	
	-- Bosses
	[134056] = {{"Important", "Don't stand in blue swirls. Don't stand in front of boss when he charges. DPS Grasps."}, {"Important", "Boss will split into three smaller elementals. Same abilities. Watch out for the charges."}, 
				{"Important", "YOU CAN FALL OFF THE PLATFORM. KEEP YOURSELF SAFE."}, {"HEALER", "Dispel: Choking Brine (DoT)"}, {"DRUID", "You can shapeshift out of the Grasp of the Depths root"}, 
				{"PALADIN", "You can Freedom the Roots."}}, -- 	Aqu'sirr
		[134828] = {{"Important", "Don't stand in blue swirls. Don't stand in front of boss when he charges. DPS Grasps."}, {"Important", "Boss will split into three smaller elementals. Same abilities. Watch out for the charges."}, 
				{"Important", "YOU CAN FALL OFF THE PLATFORM. KEEP YOURSELF SAFE."}, {"HEALER", "Dispel: Choking Brine (DoT)"}, {"DRUID", "You can shapeshift out of the Grasp of the Depths root"}, 
				{"PALADIN", "You can Freedom the Roots."}}, -- 	Aqualing
	[134063] = {{"Important", "Swiftness and Reinforcing wards are dropped through fight. ALWAYS stand in them"}, {"Important", "Reinforcing clears Slicing Winds stacks, Swiftness is +25% haste"},
				{"Important", "Kill Faye first, or both at the same time (efficient but tough on mana)"}, {"Important", "Interrupt: Slicing Blast (when Faye is in a swiftness ward)"},
				{"TANK", "When Ironhull casts Blessing you need to kite. He deals double damage"}, {"TANK", "Face the cleave away from the party. You can clear the movement debuff in swiftness wards"},
				{"HEALER", "Track Slicing Blast stacks. They should be cleared every reinforcing ward but DPS are slow sometimes"}, {"HEALER", "Warning: The tank is likely to take heavy spiky damage"}}, -- 	TC: Brother Ironhull
	[134058] = {{"Important", "Swiftness and Reinforcing wards are dropped through fight. ALWAYS stand in them"}, {"Important", "Reinforcing clears Slicing Winds stacks, Swiftness is +25% haste"},
				{"Important", "Kill Faye first, or both at the same time (efficient but tough on mana)"}, {"Important", "Interrupt: Slicing Blast (when Faye is in a swiftness ward)"},
				{"TANK", "When Ironhull casts Blessing you need to kite. He deals double damage"}, {"TANK", "Face the cleave away from the party. You can clear the movement debuff in swiftness wards"},
				{"HEALER", "Track Slicing Blast stacks. They should be cleared every reinforcing ward but DPS are slow sometimes"}, {"HEALER", "Warning: The tank is likely to take heavy spiky damage"}}, -- 	TC: Galecaller Faye
	[134060] = {{"Important", "MC'd targets must take damage by running through orbs and being targeted by allies."}, {"Important", "If you're not MC'd, don't get hit by the orbs or I'm taking away your dungeon license."},
				{"HEALER", "Dispel: Mind Rend (DoT, slow). You can also dispel Explosive Void (stun) if someone hits an orb."}}, -- 	Lord Stormsong
	[134069] = {{"Important", "Complex fight. Start by dodging tentacle slams and big black circles."}, {"Important", "Boss will drop everyone to sunken realm. Tank & healer in one, DPS in the other. Must kill add to escape"},
				{"Important", "Healer gets debuff that gives +damage +healing -maximum health. Healer MUST help DPS. DPS can receive buff if healer already has it"}, {"Important", "Debuff can be cleansed if you don't trust yourself to dodge everything"},
				{"Important", "Manifestation adds can't reach boss but will deal AoE damage when killed. Ensure nobody is low"}, {"Important", "Advanced strat on the website soon (too long for tooltips)"}}, -- 	Vol'zith the Whisperer
		[136100] = {{"Important", "Kite it, kill it. Healer MUST DPS it. Cast from your spellbook if you must; you're hitting it."}}, -- 	Sunken Denizen
	
	
	---------------------------------------------------
	
	
	
	
	[0] = {{"-"}}	
	
}

-- Color code information for the different types of tips:
-- Important:	Green
-- Interrupt:	Orange
-- Healer Note: Light Blue
-- Blank:		Default Blizzard color
local tipsColors = {
	["Legion"] = {0.8, 0.8, 0.8},
	["Important"] = {1,0.57,0.12},
	["Defensives"] = {1,0.57,0.12},
	["Interrupts"] = {0.37,0.92,1},
	["PriorityTargets"] = {1, 1, 0},
	["Fluff"] = {1, 1, 1},
	["Advanced"] = {0.75, 0.55, 0.35},
	
	["HEALER"] = {0.2, 0.98, 0.25},
	["TANK"] = {0.8, 0.6, 0},	
	["DAMAGE"] = {1, 0.72, 0.68},
	
	
	--["DEMONHUNTER"] = {0.64, 0.19, 0.79},
	["DEMONHUNTER"] = {0.68, 0.22, 0.84},
	["DRUID"] = {1, 0.49, 0.04},
	["DEATHKNIGHT"] = {0.77, 0.12, 0.23},
	["HUNTER"] = {0.67, 0.83, 0.45},
	["MAGE"] = {0.41, 0.8, 0.94},
	["MONK"] = {0, 1, 0.59},
	["PALADIN"] = {0.96, 0.55, 0.73},
	["PRIEST"] = {1, 1, 1},
	["ROGUE"] = {1, 0.96, 0.41},
	["SHAMAN"] = {0, 0.44, 0.87},
	["WARRIOR"] = {0.78, 0.61, 0.43},
	["WARLOCK"] = {0.58, 0.51, 0.79}

}

local roleList = {
	TANK = true,
	HEALER = true,
	DAMAGE = true,
}

local classList =  {
	DEMONHUNTER = true,
	DRUID = true,
	DEATHKNIGHT = true,
	HUNTER = true,
	MAGE = true,
	MONK = true,
	PALADIN = true,
	PRIEST = true,
	ROGUE = true,
	SHAMAN = true,
	WARRIOR = true,
	WARLOCK = true
}

local iconList = {
	PriorityTargets = "ability_hunter_markedfordeath",
	Interrupts = "ability_kick",
	Defensives = "inv_shield_05",
	Important = "ability_dualwield",
	Legion = "ability_dualwield",
	
	DEMONHUNTER = "classicon_demonhunter",
	DRUID = "classicon_druid",		
	DEATHKNIGHT = "classicon_deathknight",
	HUNTER = "classicon_hunter",
	MAGE = "classicon_mage",
	MONK = "classicon_monk",
	PALADIN = "classicon_paladin",
	PRIEST = "classicon_priest",
	ROGUE = "classicon_rogue",
	SHAMAN = "classicon_shaman",
	WARRIOR = "classicon_warrior",
	WARLOCK = "classicon_warlock",
	
	HEALER = "spell_nature_healingtouch",
	TANK = "inv_shield_06",
	DAMAGE = "inv_sword_01"

}

addon.acceptedDungeons = {
	-- BFA
	[1038] = true, -- Temple of Sethraliss
	[1043] = true, -- Temple of Sethraliss
	[934] = true, -- Atal'Dazar (MapUI = 934,  instance = 968))
	[935] = true, -- Atal'Dazar (MapUI = 934,  instance = 968))
	[936] = true, -- Freehold
	[1004] = true, -- Kings' Rest
	[1039] = true, -- Shrine of the Storm
	[1040] = true, -- Shrine of the Storm
	[1161] = true, -- Siege of Boralus
	[1162] = true, -- Siege of Boralus
	[1010] = true, -- Motherlode
	[1041] = true, -- Underrot
	[1042] = true, -- Tol Dagor
	[974] = true, -- Tol Dagor
	[975] = true, -- Tol Dagor
	[976] = true, -- Tol Dagor
	[977] = true, -- Tol Dagor
	[978] = true, -- Tol Dagor
	[979] = true, -- Tol Dagor (+1169!?)
	[980] = true, -- Tol Dagor
	[1169] = true, -- Tol Dagor
	[1015] = true, -- Waycrest Manor
	[1016] = true, -- Waycrest Manor
	[1017] = true, -- Waycrest Manor
	[1018] = true, -- Waycrest Manor
	
	[1148] = true, -- Uldir
	[1149] = true, -- Uldir
	[1150] = true, -- Uldir
	[1151] = true, -- Uldir
	[1152] = true, -- Uldir
	[1153] = true, -- Uldir
	[1154] = true, -- Uldir
	[1155] = true, -- Uldir
	
	-- Legion
	[751] = true, -- Blackrook Hold
	[752] = true, -- Blackrook Hold
	[753] = true, -- Blackrook Hold
	[754] = true, -- Blackrook Hold
	[755] = true, -- Blackrook Hold
	[756] = true, -- Blackrook Hold
	[845] = true, -- Cathedral of Endless Night
	[846] = true, -- Cathedral of Endless Night
	[847] = true, -- Cathedral of Endless Night
	[848] = true, -- Cathedral of Endless Night
	[849] = true, -- Cathedral of Endless Night
	[761] = true, -- Court of Stars
	[762] = true, -- Court of Stars
	[763] = true, -- Court of Stars
	[733] = true, -- Darkheart Thicket
	[790] = true, -- Eye of Azshara
	[703] = true, -- Halls of Valor
	[704] = true, -- Halls of Valor
	[705] = true, -- Halls of Valor
	[829] = true, -- Halls of Valor
	[1] = true, -- Maw of Souls
	[731] = true, -- Neltharion's Lair
	[794] = true, -- Return to Karazhan
	[795] = true, -- Return to Karazhan
	[796] = true, -- Return to Karazhan
	[797] = true, -- Return to Karazhan
	[809] = true, -- Return to Karazhan
	[810] = true, -- Return to Karazhan
	[811] = true, -- Return to Karazhan
	[812] = true, -- Return to Karazhan
	[813] = true, -- Return to Karazhan
	[814] = true, -- Return to Karazhan
	[815] = true, -- Return to Karazhan
	[816] = true, -- Return to Karazhan
	[817] = true, -- Return to Karazhan
	[818] = true, -- Return to Karazhan
	[819] = true, -- Return to Karazhan
	[820] = true, -- Return to Karazhan
	[821] = true, -- Return to Karazhan
	[822] = true, -- Return to Karazhan
	[903] = true, -- Seat of the Triumvirate
	[749] = true, -- Arcway
	[677] = true, -- Vault of the Wardens
	[678] = true, -- Vault of the Wardens
	[679] = true, -- Vault of the Wardens
	[710] = true, -- Vault of the Wardens
	[711] = true, -- Vault of the Wardens
	[712] = true, -- Vault of the Wardens
	
	[1] = true -- Bookstop
	
}

local function RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end


-- The addline function hooks into the WoW API to add a line to an NPC's tooltip.
local function addLine(tooltip, tips, type, role, class)
	local found = false
	-- Check if we already added to this tooltip. This prevents writing the same thing to the tooltip multiple times.
	for i = 1,15 do	
		local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
		local text
		if frame then text = frame:GetText() end
		if text and text == type then found = true break end
	end
	

	-- If we haven't added to the NPC tooltip yet, proceed.
	if not found then
		-- Remember we are passing in an array {"HEALER", "HealersOnly"}} in our example so we'll iterate through each pair here.
		for i, tip in ipairs(tips) do
			-- tip[1] is the category indicator and we'll use that to decide whether we should show this tooltip or not.
			
			if QEConfig[tip[1]] or tip[1] == "Legion" or -- Show if tip type turned on, or if it's using an old Legion tag.
				(tip[1] == role and QEConfig["RoleChoice"] == "Show my role only") or  -- Show if role matches the tip, and the user wants to see their role only.
				(roleList[tip[1]] and QEConfig["RoleChoice"] == "Show all roles") or -- Show if role tip and user wants to see all.
				
				(tip[1] == class and QEConfig["ClassChoice"] == "Show my class only") or
				(classList[tip[1]] and QEConfig["ClassChoice"] == "Show all classes") then
				
					local r,g,b = tipsColors[tip[1]][1], tipsColors[tip[1]][2], tipsColors[tip[1]][3]
					
					if iconList[tip[1]] then -- Check if Icon exists
						tooltip:AddLine((("|T%s:0|t"):format("Interface\\Icons\\"..iconList[tip[1]])..tip[2]),r,g,b)
					elseif tipsColors[tip[1]] then -- Check if color exists
						tooltip:AddLine(tip[2],r,g,b)
					else -- There is no icon or color assigned to the category so a plain line will be added instead.
						tooltip:AddLine(tip[2])
					end
			end
		end
		
		tooltip:Show() -- This is necessary to actually update the tooltip whenever we add anything to it.
	end
end

-- The addline function hooks into the WoW API to add a line to an NPC's tooltip.
local function addFrameLine(tooltip, tips, type, role, class)
	local found = false
	-- Check if we already added to this tooltip. This prevents writing the same thing to the tooltip multiple times.
	if not QE_HeaderPanel:IsVisible() then addon:setEnabled() end
	
	for i = 1,15 do	
		local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
		local text
		if frame then text = frame:GetText() end
		if text and text == type then found = true break end
	end
	

	-- If we haven't added to the NPC tooltip yet, proceed.
	if not found then
		-- Remember we are passing in an array {"HEALER", "HealersOnly"}} in our example so we'll iterate through each pair here.
		for i, tip in ipairs(tips) do
			-- tip[1] is the category indicator and we'll use that to decide whether we should show this tooltip or not.

			if QEConfig[tip[1]] or tip[1] == "Legion" or -- Show if tip type turned on, or if it's using an old Legion tag.
				(tip[1] == role and QEConfig["RoleChoice"] == "Show my role only") or  -- Show if role matches the tip, and the user wants to see their role only.
				(roleList[tip[1]] and QEConfig["RoleChoice"] == "Show all roles") or -- Show if role tip and user wants to see all.
				
				(tip[1] == class and QEConfig["ClassChoice"] == "Show my class only") or
				(classList[tip[1]] and QEConfig["ClassChoice"] == "Show all classes") then
				
					local r,g,b = tipsColors[tip[1]][1], tipsColors[tip[1]][2], tipsColors[tip[1]][3]
					local lineHex = RGBToHex(r, g, b)
					local tipBase = QE_TipText:GetText() or ""
					
					if iconList[tip[1]] then -- Check if Icon exists
						--tooltip:AddLine((("|T%s:0|t"):format("Interface\\Icons\\"..iconList[tip[1]])..tip[2]),r,g,b)
						
						QE_TipText:SetText(tipBase .. ((("|T%s:0|t"):format("Interface\\Icons\\"..iconList[tip[1]]).. "|cff" .. lineHex .. " " .. tip[2] .. "|r" .. "\n")))
						
					elseif tipsColors[tip[1]] then -- Check if color exists
						QE_TipText:SetText(tipBase .. "|cff" .. lineHex .. " " .. tip[2] .. "|r" .. "\n")
						--tooltip:AddLine(tip[2],r,g,b)
					else -- There is no icon or color assigned to the category so a plain line will be added instead.
						QE_TipText:SetText(tipBase .. " " .. tip[2] .. "\n")
						--tooltip:AddLine(tip[2])
					end
			end
		end
		
		--tooltip:Show() -- This is necessary to actually update the tooltip whenever we add anything to it.
	end
end




-- This starts the ball rolling. This function is called whenever an NPC tooltip is moused over.
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	
  if C_PetBattles.IsInBattle() then return end -- Tiny Snippet to disable the mod while pet battling.
  if QEConfig.ShowFrame == "Show in separate frame" and QEConfig.TargetTrigger == "Show targeted mob" then return end -- Tiny Snippet to disable the tooltip hook if targeting is selected instead.
  if QEConfig.ShowFrame == "Show in separate frame" and QEConfig.TargetTrigger == "Show mouseover" and QE_onBoss then return end -- Disable tooltip hook if player is using frame + Mouseover but is on boss
  if not addon:checkInstance() then return end -- We won't be adding anything to tooltips if the addon is disabled in the current instance.
  
  local unit = select(2, self:GetUnit()) -- This grabs information about the unit we have targeted.
  local role = UnitGroupRolesAssigned("player")
  local _, class, _ = UnitClass("player")
  
	if unit then
		local guid = UnitGUID(unit) or ""
		local id = tonumber(guid:match("-(%d+)-%x+$"), 10) -- This is the mobs ID. Don't worry about the regex.
		local name = UnitName(unit) or ""
		
		-- Check our dictionary to see if we actually have any tips for the mob targeted.
		if tipsMap[id] then
			-- Don't remove active tip if you accidentally mouse over ally.
			QE_TipText:SetText("")
			QE_MobName:SetText(name)	
		
			if QEConfig.ShowFrame == "Show in separate frame" then addFrameLine(QE_TipPanel, tipsMap[id], "NPC ID:", role, class) 
			else addLine(GameTooltip, tipsMap[id], "NPC ID:", role, class)
			end
		
		elseif UnitIsEnemy(unit, "player") then
			QE_TipText:SetText("")
			QE_MobName:SetText(name)
		end
		
	
  end 
end)

-- This starts the ball rolling on a mob target.
function addon:getTarget(mobType)
  if C_PetBattles.IsInBattle() then return end -- Tiny Snippet to disable the mod while pet battling.
  
  local guid = UnitGUID(mobType) -- This grabs information about the unit we have targeted.
  
  local role = UnitGroupRolesAssigned("player")
  local _, class, _ = UnitClass("player")
  
  --print("GUID: " .. UnitGUID("boss1"))
  
  if guid then
    --local guid = UnitGUID(unit) or ""
    local id = tonumber(guid:match("-(%d+)-%x+$"), 10) -- This is the mobs ID. Don't worry about the regex.
	local name = UnitName(mobType) or ""
	
	-- Check our dictionary to see if we actually have any tips for the mob targeted.
	if tipsMap[id]  then
		-- Don't remove active tip if you accidentally mouse over ally.
		
		QE_TipText:SetText("")		
		QE_MobName:SetText(name)
		addFrameLine(QE_TipPanel, tipsMap[id], "NPC ID:", role, class)
		--addLine(GameTooltip, tipsMap[id], "NPC ID:", role, class)		

	elseif 	UnitIsEnemy(mobType, "player") then
		QE_TipText:SetText("")
		QE_MobName:SetText(name)
		
	end
	

	
  end
end


