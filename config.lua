Config = {}

-- NPC Configurations
Config.NPC1 = {
    model = 'a_m_m_business_01',
    coords = vector3(-56.9, -1096.82, 26.42),
    heading = 69.6,
    animation = {
        dict = 'amb@world_human_cop_idles@male@idle_b',
        anim = 'idle_d'
    }
}

Config.NPC2 = {
    model = 'g_m_y_mexgoon_01',
    coords = vector3(1234.56, -3256.78, 4.56),
    heading = 42.0,
    animation = {
        dict = 'amb@world_human_smoking@male@male_a@base',
        anim = 'base'
    }
}

-- Drugs Configuration
Config.DrugsAmount = 10 -- Amount of drugs to give to the player
Config.DrugsItem = 'ketamine' -- Item name for the drugs
Config.BlackMoney = 'black_money' -- Black money item name

-- Payment Configuration
Config.Payment = {
    min = 10000,  -- Minimum payment
    max = 20000   -- Maximum payment
}

-- Target Configuration
Config.UseQBTarget = false -- Use qb-target instead of ox_target?

-- ox_lib Notifications
Config.Notifications = {
    success = 'You successfully delivered the drugs and received your payment.',
    notEnoughDrugs = 'You do not have enough drugs.',
    missionStarted = 'Mission started! Follow the waypoint to meet the contact.',
    drugsCollected = 'Drugs collected! Return to the first NPC.'
}
