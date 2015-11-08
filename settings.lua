local AddonName, sArena = ...

sArena.Settings = CreateFrame("Frame", "sArenaSettings", InterfaceOptionsFramePanelContainer, "sArenaSettingsTemplate")

function sArena.Settings:ADDON_LOADED()
	sArena.Settings.name = AddonName
	InterfaceOptions_AddCategory(sArena.Settings)
	SLASH_sArena1 = "/sarena"
	SlashCmdList["sArena"] = function(msg, editbox)
		if msg == '' then
			InterfaceOptionsFrame_OpenToCategory(sArena.Settings)
			InterfaceOptionsFrame_OpenToCategory(sArena.Settings)
		elseif msg == 'test' then sArena:TestMode(not sArenaDB.TestMode) sArenaSettings_TestMode:SetChecked(sArenaDB.TestMode)
		elseif msg == 'clear' then sArena:TestMode(false) sArenaSettings_TestMode:SetChecked(sArenaDB.TestMode)
		end
	end
	
	sArenaSettings_Lock:SetChecked(sArenaDB.Lock)
	sArenaSettings_Lock.setFunc = function(setting)
		sArenaDB.Lock = setting == "1" and true or false
		sArena.Lock(sArenaDB.Lock)
	end
	
	sArenaSettings_TestMode:SetChecked(sArenaDB.TestMode)
	sArenaSettings_TestMode.setFunc = function(setting)
		sArenaDB.TestMode = setting == "1" and true or false
		sArena.TestMode(sArenaDB.TestMode)
	end
	
	sArenaSettings_GrowUpwards:SetChecked(sArenaDB.GrowUpwards)
	sArenaSettings_GrowUpwards.setFunc = function(setting)
		sArenaDB.GrowUpwards = setting == "1" and true or false
		sArena.GrowUpwards(sArenaDB.GrowUpwards)
	end
	
	sArenaSettings_Scale:SetValue(sArenaDB.Scale)
	sArenaSettings_Scale.tooltipText = sArenaDB.Scale
	sArenaSettings_Scale:SetScript("OnValueChanged", function(self)
		sArenaDB.Scale = floor(self:GetValue()*100+0.5)/100
		self:SetValue(sArenaDB.Scale)
		self.tooltipText = sArenaDB.Scale
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		sArena.Frame:SetScale(sArenaDB.Scale)
	end)
	
	sArenaSettings_ClassColours_Health:SetChecked(sArenaDB.ClassColours.Health)
	sArenaSettings_ClassColours_Health.setFunc = function(setting)
		sArenaDB.ClassColours.Health = setting == "1" and true or false
	end
	
	sArenaSettings_ClassColours_Name:SetChecked(sArenaDB.ClassColours.Name)
	sArenaSettings_ClassColours_Name.setFunc = function(setting)
		sArenaDB.ClassColours.Name = setting == "1" and true or false
	end
	
	sArenaSettings_ClassColours_Frame:SetChecked(sArenaDB.ClassColours.Frame)
	sArenaSettings_ClassColours_Frame.setFunc = function(setting)
		sArenaDB.ClassColours.Frame = setting == "1" and true or false
	end
	
	sArenaSettings_AuraWatch:SetChecked(sArenaDB.AuraWatch.Enabled)
	sArenaSettings_AuraWatch.setFunc = function(setting)
		sArenaDB.AuraWatch.Enabled = setting == "1" and true or false
		sArena.AuraWatch:PLAYER_ENTERING_WORLD()
		sArena.AuraWatch:TestMode()
	end
	
	sArenaSettings_AuraWatch_FontSize:SetValue(sArenaDB.AuraWatch.FontSize)
	sArenaSettings_AuraWatch_FontSize.tooltipText = sArenaDB.AuraWatch.FontSize
	sArenaSettings_AuraWatch_FontSize:SetScript("OnValueChanged", function(self)
		sArenaDB.AuraWatch.FontSize = self:GetValue()
		self:SetValue(sArenaDB.AuraWatch.FontSize)
		self.tooltipText = sArenaDB.AuraWatch.FontSize
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		for i = 1, MAX_ARENA_ENEMIES do
			sArena.AuraWatch["arena"..i].Text:SetFont("Fonts\\FRIZQT__.TTF", sArenaDB.AuraWatch.FontSize, "OUTLINE")
		end
	end)
	
	sArenaSettings_AuraWatch_Alpha:SetValue(sArenaDB.AuraWatch.Alpha)
	sArenaSettings_AuraWatch_Alpha.tooltipText = sArenaDB.AuraWatch.Alpha
	sArenaSettings_AuraWatch_Alpha:SetScript("OnValueChanged", function(self)
		sArenaDB.AuraWatch.Alpha = floor(self:GetValue()*100+0.5)/100
		self:SetValue(sArenaDB.AuraWatch.Alpha)
		self.tooltipText = sArenaDB.AuraWatch.Alpha
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		for i = 1, MAX_ARENA_ENEMIES do
			sArena.AuraWatch["arena"..i]:SetSwipeColor(0, 0, 0, sArenaDB.AuraWatch.Alpha)
		end
	end)
	
	sArenaSettings_Trinkets:SetChecked(sArenaDB.Trinkets.Enabled)
	sArenaSettings_Trinkets.setFunc = function(setting)
		sArenaDB.Trinkets.Enabled = setting == "1" and true or false
		sArena.Trinkets:AlwaysShow()
	end
	
	sArenaSettings_Trinkets_AlwaysShow:SetChecked(sArenaDB.Trinkets.AlwaysShow)
	sArenaSettings_Trinkets_AlwaysShow.setFunc = function(setting)
		sArenaDB.Trinkets.AlwaysShow = setting == "1" and true or false
		sArena.Trinkets:AlwaysShow()
	end
	
	sArenaSettings_Trinkets_Scale:SetValue(sArenaDB.Trinkets.Scale)
	sArenaSettings_Trinkets_Scale.tooltipText = sArenaDB.Trinkets.Scale
	sArenaSettings_Trinkets_Scale:SetScript("OnValueChanged", function(self)
		sArenaDB.Trinkets.Scale = floor(self:GetValue()*100+0.5)/100
		self:SetValue(sArenaDB.Trinkets.Scale)
		self.tooltipText = sArenaDB.Trinkets.Scale
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		for i = 1, MAX_ARENA_ENEMIES do
			sArena.Trinkets["arena"..i]:SetScale(sArenaDB.Trinkets.Scale)
		end
	end)
	
	sArenaSettings_Trinkets_FontSize:SetValue(sArenaDB.Trinkets.CooldownFontSize)
	sArenaSettings_Trinkets_FontSize.tooltipText = sArenaDB.Trinkets.CooldownFontSize
	sArenaSettings_Trinkets_FontSize:SetScript("OnValueChanged", function(self)
		sArenaDB.Trinkets.CooldownFontSize = self:GetValue()
		self:SetValue(sArenaDB.Trinkets.CooldownFontSize)
		self.tooltipText = sArenaDB.Trinkets.CooldownFontSize
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		for i = 1, MAX_ARENA_ENEMIES do
			sArena.Trinkets["arena"..i].Cooldown.Text:SetFont("Fonts\\FRIZQT__.TTF", sArenaDB.Trinkets.CooldownFontSize, "OUTLINE")
		end
	end)
end