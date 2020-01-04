local PA = _G.ProjectAzilroka
local TS = PA:NewModule('TargetSounds', 'AceEvent-3.0')
PA.TS = TS

TS.Title = PA.ACL['|cFF16C3F2Target|r|cFFFFFFFFSounds|r']
TS.Description = PA.ACL['Audio for Target Sounds.']
TS.Authors = 'Azilroka'

local UnitExists = UnitExists
local UnitIsEnemy = UnitIsEnemy
local UnitIsFriend = UnitIsFriend

local IsReplacingUnit = IsReplacingUnit
local PlaySound = PlaySound

function TS:PLAYER_TARGET_CHANGED()
	if (UnitExists('target') and not IsReplacingUnit()) then
		if ( UnitIsEnemy('target', "player") ) then
			PlaySound(_G.SOUNDKIT.IG_CREATURE_AGGRO_SELECT);
		elseif ( UnitIsFriend("player", 'target') ) then
			PlaySound(_G.SOUNDKIT.IG_CHARACTER_NPC_SELECT);
		else
			PlaySound(_G.SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT);
		end
	else
		PlaySound(_G.SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT)
	end
end

function TS:GetOptions()
	local Options = {
		type = 'group',
		name = TS.Title,
		args = {
			Enable = {
				order = 0,
				type = 'toggle',
				name = PA.ACL['Enable'],
			},
			header = {
				order = 1,
				type = 'header',
				name = TS.Title,
			},
			AuthorHeader = {
				order = -4,
				type = 'header',
				name = PA.ACL['Authors:'],
			},
			Authors = {
				order = -3,
				type = 'description',
				name = TS.Authors,
				fontSize = 'large',
			},
		},
	}

	PA.Options.args.TargetSounds = Options
end

function TS:BuildProfile()
	PA.Defaults.profile.TargetSounds = { Enable = false }
end

function TS:Initialize()
	TS.db = PA.db.TargetSounds

	if TS.db.Enable ~= true then
		return
	end

	TS:RegisterEvent('PLAYER_TARGET_CHANGED')
end
