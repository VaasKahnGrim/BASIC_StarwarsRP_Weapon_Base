--[[sets up your content downloading stuff]]
if(SERVER)then
	resource.AddWorkshop('889827473')
	resource.AddWorkshop('912818711')
	resource.AddWorkshop('907051587')
	--missing alot of addons most likely for starwars weapons. just copy each addons ID into here.
	
	--[[DO ***NOT*** PUT THEM IN YOUR CONTENT COLLECTION, EXTRACT THEM AND UPLOAD THEM TO YOUR SERVER INSTEAD AND REMOVE THE LUA CODE FROM THEM!!!! ITS BETTER TO JUST REMAKE THEM FROM SCRATCH!!!!
	
	JUST MAKE SURE YOU KNOW HOW TO MAKE A BASIC SWEP FIRST AND YOU'LL BE FINE.
	
	YOU SHOULD BE DOING THIS ANYWAYS FOR YOUR ADDONS ALREADY BTW!!! ;)
	]]
end
AddCSLuaFile()


--[[SWEP CONFIGURATION SETTINGS, MAKE A NEW LUA FILE FOR YOUR SWEPS AND COPY THE CONFIGE BELOW AND EDIT IT TO YOUR LIKING]]

--[[SWEP AUTHOR NAME HERE]]
SWEP.Author = "Vaas Kahn Grim"
--[[CHANGE THIS TO "vaas_weapon_base" when you make your new sweps with it]]
SWEP.Base = "weapon_base"
--[[name of the weapon]]
SWEP.PrintName = "Vaas Weapon Base"
--[[What ever you want players to know]]
SWEP.Instructions = "Example"
--[[what you see in first person view]]
SWEP.ViewModel = "models/weapons/v_DC15A.mdl"
--[[if its upside down in first person set this to true]]
SWEP.ViewModelFlip = false
--[[keep this false unless you don't see hands properly]]
SWEP.UseHands = false
--[[what other players see you holding]]
SWEP.WorldModel = "models/weapons/W_DC15A.mdl"
--[[set to "ar2" for rifle like weapons, set to "pistol" for pistols.]]
SWEP.SetHoldType = "ar2"
--[[set to same as above just in case something tries to overide SWEP.SetHoldType]]
SWEP.DEFAULTHOLD = "ar2"
--[[how heavy your swep is? I guess it could be useful so why the hell not put it here for you]]
SWEP.Weight = 5
--[[switch to this weapon when you pick it up?]]
SWEP.AutoSwitchTo = true
--[[switch from this weapon when you pick up another?]]
SWEP.AutoSwitchFrom = false
--[[which key do you want to press to get to this weapon? 1,2,3,4,5 or 6]] 
SWEP.Slot = 0
--[[basically sort order of weapons on the same slot. 0 will be highest and 99 at botem of list]]
SWEP.SlotPos = 0
--[[apparently important. I suggest leave false unless you think it needs to be true]]
SWEP.DrawAmmo = false
--[[a crosshair thats basic and default with garrysmod. true if you want it, false if you don't]]
SWEP.DrawCrosshair = true
--[[where it will be in the q-menu]]
SWEP.Category = "Vaas Weapon Base"
--[[will it even show up in q-menu?]]
SWEP.Spawnable = true
--[[is it only spawnable by BADMINS]]
SWEP.AdminSpawnable = true
--[[the laser that actually fires out the gun. don't fuck with this unless you know how effects work in lua]]
SWEP.TracerName = "fucking_laser"
--[[its a laser gun, best not to change the tracer count unless its a Republic shotgun or something]]
SWEP.TracerCount = 1
--[[how much ammo per clip]]
SWEP.Primary.ClipSize = 50
--[[ammo in reserve]]
SWEP.Primary.DefaultClip = 200
--[[ammo type, leave the same or getting ammo is a bitch for players]]
SWEP.Primary.Ammo = "ar2"
--[[single shot or automatic? will have better method later for this]]
SWEP.Primary.Automatic = true
--[[how much damage for each shot]]
SWEP.Primary.Damage = 10
--[[how many blasts come out per shot? leave as 1 unless its a shotgun or something]]
SWEP.Primary.NumShots = 1
--[[how much it spreads out when firing. keep in mind that its easy to fuck up this one. keep the number small]]
SWEP.Primary.Spread = 0.02
--[[noticed nothing changing from this so ignore unless you know what to do with it.]]
SWEP.Primary.Cone = 0
--[[how long between each shot being fired from the gun. lower is faster]]
SWEP.Primary.Delay = 0.2
--[[how long it takes to begin reloading the gun. For later features to use. leave default for now]]
SWEP.ReloadDelay = 0.5
--[[how far you zoom in? will redo this later probably]]
SWEP.ZoomLevelA = 60
--[[how fast you zoom in]]
SWEP.ZoomLevelB = .2 --zoom speed
--[[can you zoom in at all?]]
SWEP.zoomEnabled = true
--[[don't bother changing the sound for reloading unless you really want to]]
SWEP.ReloadSound = Sound("weapons/shared/standard_reload.ogg")
--[[leave these unchanged for now, will probably rework later for other uses]]
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
--[[do you want to drop it on death? not sure what any starwarsRP server would want that considering lots of minges join servers to RDM]]
SWEP.ShouldDropOnDie = false
--[[the sound of the gun when you shoot it]]
local ShootSound = Sound("weapons/dc15a/dc15a_fire.ogg")

--[[
	//////////////////////////////////////////////////////////////////
	////////////////////END OF CONFIGURATION//////////////////////////
	//////////////////////////////////////////////////////////////////
	
	EVERYTHING BELOW IS SETUP THE WAY IT NEEDS TO BE TO WORK WITH YOUR
	NEW SWEPS YOU MAKE! DO NOT COPY ANYTHING BELOW THIS INTO YOUR NEW
	SWEPS!!! ITS ALREADY BEING USED WHEN YOU SET SWEP.Base = "vaas_weapon_base"
	
	Seriously I made this thing easy to use for a reason, its basic as
	fuck but atleast you won't have the insane retarded issues that alot
	of people have with TFA Weapons. I'll update it later with new features
	but atleast take the time to read it as your going about editing the
	config for each swep. I included some somewhat helpful advice for each
	entry in the config. Lastly don't forget to follow the instructions at
	the top regarding the downloading of content for this.
	
										With Lua,
													Vaas Kahn Grim
													[RAPADANT NETWORKS]
]]







local Time = CurTime()
function SWEP:Initialize()
	self:SetHoldType(self.DEFAULTHOLD)
end
function SWEP:PrimaryAttack()
	if(not self:CanPrimaryAttack())then
		return
	end
	local ply = self:GetOwner()
	ply:LagCompensation(true)
	local Bullet = {}
		Bullet.Num = self.Primary.NumShots
		Bullet.Src = ply:GetShootPos()
		Bullet.Dir = ply:GetAimVector()
		Bullet.Spread = Vector(self.Primary.Spread,self.Primary.Spread,0)
		Bullet.Tracer = 1
		Bullet.TracerName = self.TracerName
		Bullet.Damage = self.Primary.Damage
		Bullet.AmmoType = self.Primary.Ammo
	self:FireBullets(Bullet)
	self:ShootEffects()
	self:EmitSound(ShootSound)
	self.BaseClass.ShootEffects(self)
	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
	ply:LagCompensation(false)
end
function SWEP:SecondaryAttack()
	if(self.zoomEnabled == true)then
		if(ScopeLevel == 0)then
			if(SERVER)then
				self.Owner:SetFOV(self.ZoomLevelA,self.ZoomLevelB)
			end
			ScopeLevel = 1
		else
			if(SERVER)then
				self.Owner:SetFOV(0,self.ZoomLevelB)
			end
			ScopeLevel = 0
		end
	else
		return false
	end
end
function SWEP:Reload()

    if (self.cooldownvar || 0 ) < CurTime() then
        self.cooldownvar  = CurTime() + 2

        if self.Owner:KeyDown(IN_USE) and self.Owner:KeyDown(IN_SPEED) then

            if self:GetHoldType() == "passive" then

                self:SetHoldType( "ar2" )

            else

                self:SetHoldType( "passive" )

            end

        end

    end

	if(self.Weapon:Ammo1() <= 0)then
		return
	end
	if(self.Weapon:Clip1() >= self.Primary.ClipSize)then
		return
	end
	if(CurTime() < Time + self.ReloadDelay)then
		return
	end
	Time = CurTime()
	timer.Simple(self.ReloadDelay,function() self.Weapon:EmitSound(self.ReloadSound)end)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	self.Weapon:DefaultReload(ACT_VM_RELOAD)
end
function SWEP:ShouldDropOnDie()
	return false
end
--[[fix the below feature and I'll credit you for it btw]]
--[[if(CurHold == 0)then
		self:SetHoldType("passive")
		CurHold = 1
	else
		self:SetHoldType(self.DEFAULTHOLD)
		CurHold = 0
	end]]
