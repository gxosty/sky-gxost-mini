local response = gg.makeRequest("https://raw.githubusercontent.com/gxosty/gx-gg/main/gx.lua")
gx = load(response.content)()
-- local gx = require("gx.gx")
gameinfo = gg.getTargetInfo()
scriptv = {process ='com.tgc.sky.android'}

gx.vars.settings = {
	version = tostring(gameinfo.versionCode)
}
config_path = "/sdcard/gxostmini.gx"
config = {
	offset = {},
	settings = {}
}
defaults = {
	wbdistance = 5.0,
	version = math.floor(gameinfo.versionCode)
}
local old_ranges = gg.getRanges()
local bootloader = gg.getRangesList('libBootloader.so')[1].start
gx.set_signs({[true] = '¦✅¦', [false] = '¦❌¦'})
gx.set_back_text("|<- Back")

function pcheck()
	if gameinfo.packageName ~= scriptv.process then
		gg.alert('[Error] You have selected wrong process!\nprocess: ' .. gameinfo.packageName)
		os.exit()
	end
end

-- x: 1.0~1.2
-- y: 0~1.5
-- z: -1.3~-1.1
-- w: 1.0

maps = {
	{"Home", "CandleSpace"},
	{"Isle", "Dawn"},
	{"Trials Cave", "DawnCave"},
	{"Water Trial", "Dawn_TrialsWater"},
	{"Earth Trial", "Dawn_TrialsEarth"},
	{"Air Trial", "Dawn_TrialsAir"},
	{"Fire Trial", "Dawn_TrialsFire"},
	{"Prairie Butterfly Field", "Prairie_ButterflyFields"},
	{"Bird Nest", "Prairie_NestAndKeeper"},
	{"Sancuary Islands", "Prairie_Island"},
	{"Prairie Cave", "Prairie_Cave"},
	{"Prairie Village", "Prairie_Village"},
	{"8 player puzzle", "DayHubCave"},
	{"Prairie Temple", "DayEnd"},
	{"Forest", "Rain"},
	{"Forest Clearing", "RainForest"},
	{"Forest Elevated Clearing", "RainShelter"},
	{"Forest Caves", "Rain_Cave"},
	{"Forest Boneyard", "RainMid"},
	{"Forest Temple", "RainEnd"},
	{"Treehouse", "Rain_BaseCamp"},
	{"Wind Paths", "Skyway"},
	{"Valley", "Sunset"},
	{"Valley Citadel", "Sunset_Citadel"},
	{"Valley Fly Race", "Sunset_FlyRace"},
	{"Valley Race", "SunsetRace"},
	{"Valley Race End", "SunsetEnd"},
	{"Hermit Valley", "Sunset_YetiPark"},
	{"Dream Village", "SunsetVillage"},
	{"Valley Dream Theater", "Sunset_Theater"},
	{"Valley Music Shop", "SunsetVillage_MusicShop"},
	{"Valley Colosseum", "SunsetColosseum"},
	{"Valley Temple", "SunsetEnd2"},
	{"Wasteland Lobby", "DuskStart"},
	{"Wasteland", "Dusk"},
	{"Abyss Area", "Dusk_Triangle"},
	{"Wasteland Graveyard", "DuskGraveyard"},
	{"Forgotten Ark", "DuskOasis"},
	{"Crab Fields", "Dusk_CrabField"},
	{"Battlefield", "DuskMid"},
	{"Wasteland Temple", "DuskEnd"},
	{"Vault", "Night"},
	{"Vault 2", "Night2"},
	{"Vault End", "NightEnd"},
	{"Vault Archive", "NightArchive"},
	{"Starlight Desert", "NightDesert"},
	{"Starlight Desert Beach", "NightDesert_Beach"},
	{"Jar Cave", "Night_JarCave"},
	{"Infinite Desert", "Night_InfiniteDesert"},
	{"Planets", "NightDesert_Planets"},
	{"Office", "TGCOffice"},
	{"Void of Shattering", "StormEvent_VoidSpace"},
	{"Days of Mischief", "Event_DaysOfMischief"},
	{"Nintendo area", "Nintendo_CandleSpace"},
	{"Eden", "StormStart"},
	{"Eden mid", "Storm"},
	{"Eden end", "StormEnd"},
	{"!!! Orbit !!!", "OrbitMid"},
	{"!!! Orbit 2 !!!", "OrbitEnd"},
	{"!!! Heaven !!!", "CandleSpaceEnd"},
	{"Credits map", "Credits"},
}

posits = {
	{map='CandleSpace',name='BLACKOUT',x=800,y=0.6,z=0},
	{map='CandleSpace',name='Spawn',x=1.3682793378829956,y=1.1504778861999512,z=-0.7198812365531921},
	{map='Dawn',name='Trials Cave entrance',x=211.96453857421875,y=4.274348258972168,z=-63.84076690673828},
	{map='Dawn',name='Exit',x=154.19021606445312,y=103.16753387451172,z=-278.95806884765625},
	{map='Dawn',name='Rainbow',x=301.889892578125,y=413.0315246582031,z=-301.21563720703125},
	{map='Dawn',name='Cloudy',x=402.95318603515625,y=115.7956314086914,z=-10.648039817810059},
	{map='Dawn',name='Isle Elder room',x=117.75272369384766,y=1.006047010421753,z=-1733.9976806640625},
	{map='DawnCave',name='Water Trial',x=-90.0,y=245.0,z=-305.0},
	{map='DawnCave',name='Earth Trial',x=-28.13365936279297,y=253.9242401123047,z=-372.3354797363281},
	{map='DawnCave',name='Air Trial',x=21.34743881225586,y=259.1813049316406,z=-346.86083984375},
	{map='DawnCave',name='Fire Trial',x=57.113975524902344,y=251.7130889892578,z=-326.27691650390625},
	{map='Prairie_ButterflyFields',name='Skip first',x=93.07067108154297,y=150.75,z=-5.158041477203369},
	{map='Prairie_Village',name='Cave',x=157.04954528808594,y=199.9058837890625,z=225.65309143066406},
	{map='Prairie_Village',name='invisible thing',x=96.71356964111328,y=175.35667419433594,z=265.9364929199219},
	{map='Prairie_Village',name='8 Player Door',x=-48.69554138183594,y=182.15054321289062,z=324.2794189453125},
	{map='Prairie_Village',name='Temple',x=126.16890716552734,y=254.21255493164062,z=478.1236572265625},
	{map='Prairie_Cave',name='Prairie soar high OOB',x=314.2340393066406,y=235.1671600341797,z=162.43087768554688}, 
	{map='DayEnd',name='Forest',x=-128.55003356933594,y=106.04075622558594,z=41.26801681518555},
	{map='DayEnd',name='Elder Room',x=-529.508544921875,y=8.83392333984375,z=-213.78453063964844},
	{map='DayHubCave',name='Exit',x=30.72627067565918,y=42.47455596923828,z=0.237472802400589},
	{map='Prairie_Island',name='Bird Nest',x=272.2238464355469,y=175.1832275390625,z=-26.06362915390625},
	{map='Prairie_Island',name='First air flower',x=244.09881591796875,y=95.16970825195312,z=221.4185791015625},
	{map='Prairie_Island',name='Waterfall',x=494.17425537109375,y=321.3855285644531,z=393.63873291015625},
	{map='Prairie_Island',name='Top of center',x=57.3979606628418,y=102.27421569824219,z=300.8200378417969},
	{map='Prairie_Island',name='Big flower',x=90.91666412353516,y=2.906703472137451,z=293.2203063964844},
	{map='Rain',name='Skip',x=17.024648666381836,y=92.79985046386719,z=-225.68663024902344},
	{map='RainForest',name='Sunny Forest',x=6.1400275230407715,y=111.99101257324219,z=-61.309600830078125},
	{map='RainShelter',name='To Cave',x=54.64596939086914,y=68.41414642333984,z=43.7832145690918},
	{map='RainShelter',name='To Temple',x=15.340384483337402,y=88.6324691772461,z=119.18212890625},
	{map='RainShelter',name='Forest pit OOB',x=-32.04302215576172,y=206.95440673828125,z=0.1170167475938797}, 
	{map='Rain_Cave',name='Exit',x=-65.55963134765625,y=210.6380157470703,z=-285.0746154785156},
	{map='RainMid',name='Exit',x=-17.595956802368164,y=182.86737060546875,z=400.8680114746094},
	{map='RainEnd',name='Elders Room',x=2.448410749435425,y=8.948872566223145,z=503.58135986328125},
	{map='Sunset',name='Skip',x=181.40216064453125,y=49.21394348144531,z=-512.7560424804688},
	{map='Sunset',name='To First Race',x=202.9875030517578,y=56.84459686279297,z=-593.9754638671875},
	{map='Sunset',name='To Second Race',x=282.1065673828125,y=39.942588806152344,z=-527.995065460546875},
	{map='Sunset_Citadel',name='Candle run first',x=115.18697357177734,y=477.2147521972656,z=15.642013549804688},
	{map='Sunset_Citadel',name='Exit',x=199.33934020996094,y=491.9642028808594,z=-195.2884063720703},
	{map='Sunset_FlyRace',name='Skip',x=124.05903625488281,y=1045.8760986328125,z=-78.43795013427734},
	{map='Sunset_FlyRace',name='Cloud OOB',x=-812.950927734375,y=1545.5372314453125,z=-505.4371643066406},
	{map='Sunset_FlyRace',name='Valley castle OOB',x=-478.83294677734375,y=1573.1116943359375,z=76.33606719970703},
	{map='SunsetRace',name='Skip',x=236.2896728515625,y=599.3069458007812,z=-526.8030395507812},
	{map='SunsetEnd',name='Skip',x=42.99704360961914,y=166.48251342773438,z=0.7978107333183289},
	{map='SunsetColosseum',name='Dream',x=133.408065795899844,y=154.74673461914062,z=-171.10191345214844},
	{map='SunsetColosseum',name='End',x=62.833187103271484,y=145.87591552734375,z=-293.7547607421875},
	{map='SunsetEnd2',name='OOB Castle',x=308.30621337890625,y=148.89456176757812,z=-775.3768920898438},
	{map='SunsetVillage',name='Skip',x=-110.77000427246094,y=205.6576385498047,z=487.48956298828125},
	{map='SunsetVillage',name='OOB Trumpets',x=-65.07833099365234,y=128.78334045410156,z=-33.79042434692383},
	{map='Dusk',name='To Boat',x=150.89471435546875,y=1.2322540283203125,z=46.65181350708008},
	{map='Dusk',name='To Graveyard',x=-90.4443359375,y=12.013911247253418,z=158.87918090820312},
	{map='DuskGraveyard',name='To Battlefield',x=33.067073822021484,y=82.51902770996094,z=-240.50013732910156},
	{map='DuskGraveyard',name='To Crabfield',x=135.5191192626953,y=97.7408447265625,z=16.016836166381836},
	{map='DuskMid',name='To End',x=-284.5697326660156,y=92.47919464111328,z=-400.2809753417969},
	{map='DuskMid',name='To Shipwreck',x=54.159915924072266,y=111.84867095947266,z=-264.114990234375},
	{map='DuskEnd',name='Elders Room',x=-417.28424072265625,y=12.288487434387207,z=410.8535461425781},
	{map='Dusk_CrabField',name='To Battlefield',x=-338.3324279785156,y=36.55388641357422,z=387.93304443359375},
	{map='Dusk_CrabField',name='Wasteland Moon OOB',x=-338.6526184082031,y=185.0042266845703,z=400.361328125},
	{map='DuskOasis',name='Skip',x=141.16297912597656,y=120.97766876220703,z=351.2036437988281},
	{map='DuskOasis',name='Exit Ship',x=-47.61760330200195,y=141.75379943847656,z=170.869873046875},
	{map='TGCOffice',name='Vault Office Space',x=7009.4736328125,y=6921.181640625,z=9078.2421875},
	{map='Night',name='To Archive',x=-35.5402946472168,y=34.19679641723633,z=-97.76521301269531},
	{map='Night',name='To Desert',x=42.82196807861328,y=36.75535583496094,z=-81.42263793945312},
	{map='Night',name='2nd Floor',x=11.553918838500977,y=80.62894439697266,z=14.284697532653809},
	{map='Night',name='3rd Floor',x=27.935970306396484,y=153.792236328125,z=-39.151798248291016},
	{map='NightEnd',name='Thunder',x=31.983366012573242,y=347.39166259765625,z=41.15662384033203},
	{map='NightEnd',name='Elders Vault',x=-0.8692829012870789,y=195.21739196777344,z=6.841609001159668},
	{map='NightEnd',name='Full Moon Vault',x=67.19486236572266,y=240.53509521484375,z=-187.52154541015625},
	{map='NightArchive',name='Back to First Library',x=40.553749084472656,y=544.6246337890625,z=-25.288280487060547},
	{map='NightDesert',name='To Jellyfield',x=399.72943115234375,y=4.236130237579346,z=540.1605834960938},
	{map='NightDesert',name='To Vault of Knowledge',x=29.91564706713867,y=17.69660758972168,z=176.67739868164062},
	{map='NightDesert',name='To Jar',x=-76.51543426513672,y=28.447778701782227,z=372.2406921386719},
	{map='NightDesert',name='OOB Golden Skykids',x=-797.5425415039062,y=156.2596435546875,z=916.4702758789062},
	{map='NightDesert_Beach',name='Back to desert',x=464.6367492675781,y=8.204781532287598,z=552.7400512695312},
	{map='Night_JarCave',name='Back',x=-81.74847412109375,y=28.22599983215332,z=373.6864013671875},
	{map='Night2',name='Top',x=-0.18086150288581848,y=294.4930419921875,z=0.7263343930244446},
	{map='Storm',name='Skip',x=7,y=266,z=-250},
	{map='Storm',name='End of Cave',x=61.72602462768555,y=272.8486022949219,z=-332.78521728515625},
	{map='Storm',name='OOB Transparent',x=192,y=8,z=-489},
	{map='StormStart',name='Skip',x=-2,y=196,z=-19},
	{map='StormEnd',name='White Child',x=803.8466796875,y=0.6778343915939331,z=-11.73253059387207},
	{map='OrbitMid',name='Skip',x=923.1694946289062,y=2764.83251953125,z=146.8410186767578},
	{map='OrbitMid',name='Stones OOB',x=184.6337890625,y=1345.392333984375,z=-831.4788818359375},
	{map='OrbitEnd',name='Skip',x=-42.1104621887207,y=2465.890380859375,z=2261.208251953125},
	{map='Prairie_Cave',name='paintingoob',x=280.9242858886719,y=166.0093231201172,z=191.56130981445312},
	{map='Prairie_Cave',name='castle_oob',x=133.543701171875,y=308.047607421875,z=494.5435791015625},
	{map='CandleSpaceEnd',name='end',x=0.6592245101928711,y=0.5781212449073792,z=232.74395751953125},
	{map='DawnCave',name='exit_cave',x=-25.61272430419922,y=192.8677520751953,z=-38.68637466430664},
	{map='Dawn',name='Skip',x=101.23614501953125,y=2.32336688041687,z=123.376708984375},
	{map='Dawn',name='Prophecy Cave',x=211.96453857421875,y=4.274348258972168,z=-63.84076690673828},
	{map='Dawn',name='Temple',x=150.16748046875,y=102.43803405761719,z=-244.5251007080078},
	{map='Dawn_TrialsWater',name='Start',x=-0.11249076575040817,y=66.35979461669922,z=13.503379821777344},
	{map='Dawn_TrialsWater',name='Trial Meditation',x=43.719730377197266,y=67.64400482177734,z=-272.9099426269531},
	{map='Dawn_TrialsWater',name='End',x=0.060450248420238495,y=78.57532501220703,z=-411.5926513671875},
	{map='Dawn_TrialsEarth',name='Start',x=96.24566650390625,y=127.13948822021484,z=10.877419471740723},
	{map='Dawn_TrialsEarth',name='Trial Meditation',x=1.2450224161148071,y=127.96000671386719,z=15.725500106811523},
	{map='Dawn_TrialsEarth',name='End',x=-13.79636001586914,y=133.65394592285156,z=3.316030740737915},
	{map='Dawn_TrialsAir',name='Start',x=-1.648727297782898,y=30.203773498535156,z=-38.58304214477539},
	{map='Dawn_TrialsAir',name='Trial Meditation',x=-27.569198608398438,y=90.28909301757812,z=-130.7397003173828},
	{map='Dawn_TrialsAir',name='End',x=-11.577858924865723,y=105.93589782714844,z=-130.6845703125},
	{map='Dawn_TrialsFire',name='Start',x=-41.554508209228516,y=46.78275680541992,z=-22.998823165893555},
	{map='Dawn_TrialsFire',name='Trial Meditation',x=-12.22600269317627,y=50.001827239990234,z=-257.0751953125},
	{map='Dawn_TrialsFire',name='End',x=-11.194707870483398,y=50.01749038696289,z=-307.281982421875},
	{map='Prairie_ButterflyFields',name='Isle of Dawn',x=119.0,y=201.0,z=-458.0},
	{map='Prairie_ButterflyFields',name='Social Area',x=116.6399917602539,y=196.85479736328125,z=-434.001220703125},
	{map='Prairie_ButterflyFields',name='Prairie Cave',x=206.80516052246094,y=171.53472900390625,z=18.65180778503418},
	{map='Prairie_ButterflyFields',name='Prairie Birds Nest',x=-16.0,y=169.0,z=-6.0},
	{map='Prairie_ButterflyFields',name='Prairie Village',x=77.0,y=161.0,z=66.0},
	{map='Prairie_Village',name='Prairie Butterfly field',x=30.0,y=192.0,z=183.0},
	{map='Prairie_Village',name='Prairie Cave',x=162.0,y=200.0,z=222.0},
	{map='Prairie_Village',name='Prairie Birds Nest',x=-67.0,y=202.0,z=206.0},
	{map='Prairie_Cave',name='Prairie Butterfly Field',x=192.0,y=171.0,z=12.0},
	{map='Prairie_Cave',name='Prairie Village',x=243.0,y=198.0,z=226.0},
	{map='DayEnd',name='Prairie Village',x=-62.0,y=85.0,z=41.0},
	{map='Prairie_NestAndKeeper',name='Prairie Village',x=-109.54730224609375,y=184.3603515625,z=168.52159118652344},
	{map='DayEnd',name='Hidden Forest',x=-126.30734252929688,y=105.23834991455078,z=41.5018310546875},
	{map='Prairie_NestAndKeeper',name='Prairie Butterfly field',x=-49.0,y=163.0,z=37.0},
	{map='Prairie_NestAndKeeper',name='Sanctuary Islands',x=-358.0,y=127.0,z=109.0},
	{map='Prairie_Island',name='Dirty Water',x=142.66439819335938,y=2.3796894550323486,z=417.6568603515625},
	{map='Prairie_Island',name='Bell Shrine',x=24.223779678344727,y=55.22944259643555,z=335.5910339355469},
	{map='Prairie_Island',name='Mother Whale',x=407.8931579589844,y=-0.0814097449183464,z=514.7636108398438},
	{map='Rain',name='Skip to mid area',x=17.024648666381836,y=92.79985046386719,z=-225.68663024902344},
	{map='Rain',name='Social Area',x=139.7912139892578,y=216.697265625,z=-621.1143188476562},
	{map='Rain',name='To Rainforest',x=28.0,y=101.0,z=-115.0},
	{map='Rain',name='Mini Treehouse',x=57.644893646240234,y=107.6270751953125,z=-140.5428009033203},
	{map='Rain',name='Forest basecamp start',x=-12.0,y=152.0,z=-478.0},
	{map='Rain',name='Forest basecamp first gate',x=61.0,y=96.0,z=-165.0},
	{map='Rain_BaseCamp',name='Shared space',x=19.623136520385742,y=145.4346466064453,z=15.800447463989258},
	{map='Rain_BaseCamp',name='To first rain',x=21.0,y=150.0,z=152.0},
	{map='Rain_BaseCamp',name='To middle of first rain',x=-16.0,y=143.0,z=82.0},
	{map='Rain_BaseCamp',name='To Rainforest basecamp',x=-20.0,y=136.0,z=64.0},
	{map='Rain_BaseCamp',name='To mid forest',x=-40.0,y=148.0,z=58.0},
	{map='RainForest',name='Back to rain',x=21.0,y=101.0,z=-135.0},
	{map='RainForest',name='Mini Treehouse',x=58.60780334472656,y=115.9687271118164,z=-101.88823699951172},
	{map='RainForest',name='Forest basecamp',x=54.0,y=114.0,z=-114.0},
	{map='RainForest',name='To Rain mid',x=64.0,y=106.0,z=57.0},
	{map='RainShelter',name='To Rainforest',x=32.0,y=84.0,z=-67.0},
	{map='RainShelter',name='To Cave',x=51.0,y=80.0,z=43.0},
	{map='RainShelter',name='Golden Bell OOB',x=-31.19548988342285,y=74.96634674072266,z=-14.715871810913086},
	{map='Rain_Cave',name='To Sunny forest',x=-65.55963134765625,y=210.6380157470703,z=-285.0746154785156},
	{map='Rain_Cave',name='Big Fish OOB',x=-44.68874740600586,y=11.55691909790039,z=-334.6219482421875},
	{map='Rain_Cave',name='Birds OOB',x=161.14125061035156,y=-0.08140973746776581,z=149.28102111816406},
	{map='RainMid',name='Back to Rainforest',x=32.0,y=142.0,z=-27.0},
	{map='RainMid',name='To Sunny forest',x=-88,y=156.0,z=110.0},
	{map='RainMid',name='To Temple',x=-17.595956802368164,y=182.86737060546875,z=400.8680114746094},
	{map='RainMid',name='Mini Treehouse',x=-23.81351661682129,y=166.0816192626953,z=-0.289888858795166},
	{map='RainMid',name='Forest basecamp',x=-16.0,y=157.0,z=-36.0},
	{map='RainEnd',name='Butterflies',x=-0.6,y=107.0,z=83.0},
	{map='RainEnd',name='To Valley of Triumph',x=-1.0,y=211.0,z=219.0},
	{map='Sunset',name='Social Area',x=-30.16819953918457,y=305.6812438964844,z=27.05612564086914},
	{map='Sunset',name='To Second Race',x=286.0,y=41.0,z=-529.0},
	{map='Sunset',name='To Village',x=25.0,y=300.0,z=7.0},
	{map='Sunset',name='Soar High OOB',x=31.0,y=187.0,z=-467.0},
	{map='Sunset_Citadel',name='To fly race',x=206.0,y=495.0,z=-203.0},
	{map='SunsetRace',name='To main start',x=159.0,y=935.0,z=688.0},
	{map='SunsetEnd2',name='To Collosseum',x=8.0,y=147.0,z=-111.0},
	{map='SunsetEnd2',name='To Wasteland',x=12.0,y=141.0,z=-199.0},
	{map='SunsetVillage',name='Collosseum',x=-37,y=76.0,z=12.0},
	{map='SunsetVillage',name='Back to main',x=87.0,y=76.0,z=367.0},
	{map='SunsetVillage',name='To Yeti-park',x=-107.0,y=205.0,z=496.0},
	{map='SunsetVillage',name='Dream Guide',x=163.98046875,y=37.079376220703125,z=89.6847915649414},
	{map='Sunset_YetiPark',name='To Village',x=126.6,y=35.0,z=29.0},
	{map='DuskStart',name='Whirl pool',x=-171.370361328125,y=47.68985366821289,z=-873.1289672851562},
	{map='DuskStart',name='Ice Castle OOB',x=-50.03977966308594,y=4735.7001953125,z=-807.4383544921875},
	{map='DuskStart',name='Social Space',x=-77.0,y=64.0,z=-772.0},
	{map='DuskStart',name='To Valley',x=10.0,y=140.0,z=-195.0},
	{map='DuskGraveyard',name='To Dusk',x=54.0,y=97.0,z=362.0},
	{map='DuskMid',name='To End',x=-284.5697326660156,y=92.47919464111328,z=-400.2809753417969},
	{map='DuskMid',name='To Shipwreck',x=54.159915924072266,y=111.84867095947266,z=-264.114990234375},
	{map='DuskMid',name='To Graveyard',x=41.0,y=100.0,z=-41.0},
	{map='DuskEnd',name='To Vault of knowledge',x=0.0,y=208.0,z=-67.0},
	{map='Dusk_CrabField',name='To Graveyard',x=-49.0,y=26.0,z=525.0},
	{map='Night',name='4th floor',x=31.0,y=212.0,z=-40.0},
	{map='NightDesert',name='The Rose',x=133.8204345703125,y=12.115839004516602,z=347.6593322753906},
	{map='NightDesert',name='Amphi theater',x=83.05719757080078,y=73.64505767822266,z=62.82310485839844},
	{map='NightDesert',name='Light Tower',x=336.9781494140625,y=77.53258514404297,z=168.25814819335938},
	{map='NightDesert',name='Garden',x=227.37709045410156,y=16.496721267700195,z=606.0718383789062},
	{map='NightDesert',name='Throne',x=399.643310546875,y=92.43084716796875,z=778.90869140625},
	{map='NightDesert',name='BigBooks',x=408.36773681640625,y=154.7767791748047,z=1037.8370361328125},
	{map='NightDesert',name='Floating Eggrock',x=144.13259887695312,y=45.12910461425781,z=770.6494750976562},
	{map='CandleSpace',name='black_room_island',x=-401.7143859863281,y=14.144501686096191,z=413.95562744140625},
	{map='NightDesertBeach',name='jelly',x=-5397,73779296875,y=2580,5859375,z=6082,1962890625},
	{map='NightDesert',name='To Infinite Desert',x=-21.14558982849121,y=9.46289348602295,z=547.5945434570312},
	{map='Night_InfiniteDesert',name='Back to desert',x=635.3980712890625,y=54.36724853515625,z=-85.38371276855469},
	{map='SunsetVillage',name='ALL_SPIRIT_LOL',x=-419.5585021972656,y=19.289306640625,z=-203.55723571777344},
	{map='SunsetVillage',name='OOB_STONEPIGpig2_by_MadBoii',x=2.1557862758636475,y=1.2917245626449585,z=0.5072160363197327},
	{map='Skyway',name='Back to Rain',x=133.41851806640625,y=384.35552978515625,z=281.2737731933594}
}

function return_min(n, values, only_address)
	local m = {address = 0xFFFFFFFFFF, value = 999999999}
	for k, v in ipairs(values) do
		if only_address then
			if math.abs(n - m.address) > math.abs(n - v.address) then
				m = v
			end
		else
			if math.abs(n - m.value) > math.abs(n - v.value) then
				m = v
			end
		end
	end
	return m
end

function find_player_offset()
	ptoplayer = nil
	gg.setRanges(gg.REGION_C_ALLOC)
	gg.clearResults()
	gg.searchNumber("0;.125;.375::9", gg.TYPE_FLOAT)
	gg.refineNumber(".125", gg.TYPE_FLOAT)
	local adds = gg.getResults(gg.getResultCount())
	for k, v in ipairs(adds) do
		v.address = v.address - 0x8
	end
	local values = gx.editor.get(adds)
	player = nil
	for k, v in ipairs(values) do
		if v.value ~= 0 then
			v.address = v.address + 0x8
			player = v
			break
		end
	end

	local adds = gx.editor.get({player})
	adds[1].name = "player"
	gg.addListItems(adds)
	gg.clearResults()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber(player.address, gg.TYPE_QWORD)
	local len = gg.getResultsCount()
	if len > 0 then
		ptoplayer = gg.getResults(1)[1]
		offsets.ptoplayer = ptoplayer.address - bootloader
		ptoplayer.name = "ptoplayer"
		gg.addListItems({ptoplayer})
	else
		offsets.ptoplayer = 0
		gg.toast("Failed.")
	end

	gg.clearResults()
	gg.setRanges(old_ranges)
end

function find_player_pos()
	if offsets.ptoplayer == nil then
		local found = false
		for k, v in ipairs(gg.getListItems()) do
			if v.name == "ptoplayer" then
				ptoplayer = v
				offsets.ptoplayer = ptoplayer.address - bootloader
				player = v.value
				found = true
			end
		end
		if not found then
			gg.toast("Find player pointer first or enter it manually in GG list with name \"ptoplayer\"")
			return
		end
	end

	gg.setRanges(gg.REGION_C_ALLOC)
	gg.clearResults()
	gg.searchNumber("1~1.5;0~1.5;-0.9~-0.1;1.0;1~1.5;0~1.5;-0.9~-0.1;1.0::29", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, ptoplayer.value + 0x400000, ptoplayer.value + 0x500000, 1)
	if gg.getResultsCount() > 0 then
		player_pos_x = gg.getResults(1)[1]
		offsets.pos_off = player_pos_x.address - player.address
		player_pos_x.name = "ppos_x"
		gg.addListItems({player_pos_x})
	else
		offsets.pos_off = 0
		gg.toast("Failed. Either you weren't at spawn or script needs update.")
	end
	gg.clearResults()
	gg.setRanges(old_ranges)
end

function find_nentity()
	gg.setRanges(gg.REGION_C_ALLOC)
	gg.clearResults()
	gg.searchNumber("1099746509", gg.TYPE_DWORD)
	local len = gg.getResultsCount()
	if len == 0 then
		offsets.ptoentity = 0
		offsets.ptonentity = 0
		gg.toast("Failed")
		return
	end
	nentity = gg.getResults(1)[1]
	gg.clearResults()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber(tostring(nentity.address - 0x1000000).."~"..tostring(nentity.address), gg.TYPE_QWORD)
	local len = gg.getResultsCount()
	if len == 0 then
		offsets.ptoentity = 0
		offsets.ptonentity = 0
		gg.toast("Failed")
		return
	end
	local values = gg.getResults(len)
	ptoentity = return_min(nentity.address, values)
	offsets.ptoentity = ptoentity.address - bootloader
	offsets.ptonentity = nentity.address - gx.editor.get({{address = ptoentity.value, flags = "D"}})[1].address
	ptoentity.name = "ptoentity"
	nentity.name = "nentity"
	gg.addListItems({ptoentity, nentity})
	gg.clearResults()
	gg.setRanges(old_ranges)
end

function find_game_speed()
	gg.setRanges(gg.REGION_C_ALLOC)
	gg.clearResults()
	gg.searchNumber("1.0", gg.TYPE_FLOAT)
	gg.alert("Now, please hide Sky and then open GG again", "ok")
	gg.setVisible(false)
	while true do
		if gg.isVisible() then
			break
		end
		gg.sleep(500)
	end
	gg.refineNumber("0.00001", gg.TYPE_FLOAT)
	local len = gg.getResultsCount()
	if len == 0 then
		offfsets.gamespeed_off = 0
		gg.toast("Failed")
		gg.setRanges(old_ranges)
		return
	end
	gamespeed = gg.getResults(1)[1]
	if nentity == nil then
		gg.clearResults()
		gg.searchNumber("1099746509", gg.TYPE_DWORD)
		nentity = gg.getResults(1)[1]
	end
	offsets.gamespeed_off = gamespeed.address - nentity.address
	gamespeed.name = "gamespeed"
	gg.addListItems({gamespeed})
	gg.clearResults()
	gg.setRanges(old_ranges)
end

function find_current_map()
	gg.setRanges(gg.REGION_C_ALLOC)
	gg.clearResults()
	gg.searchNumber(":CandleSpace/Resources.lua", gg.TYPE_BYTE)
	local len = gg.getResultsCount()
	if len == 0 then
		offsets.curmap_off = 0
		gg.toast("Failed")
		return
	end
	gg.refineNumber(":C", gg.TYPE_BYTE)
	local values = gg.getResults(gg.getResultCount())
	if nentity == nil then
		gg.clearResults()
		gg.searchNumber("1099746509", gg.TYPE_DWORD)
		nentity = gg.getResults(1)[1]
	end
	for i = #values, 1, -1 do
		if values[i].address > nentity.address then
			table.remove(values, i)
		end
	end
	curmap = return_min(nentity.address, values, true)
	offsets.curmap_off = curmap.address - nentity.address
	curmap.name = "curmap"
	gg.addListItems({curmap})
	gg.clearResults()
	gg.setRanges(old_ranges)
end

function find_all_offsets()
	offsets = {}
	gg.toast("Scanning for player offset")
	find_player_offset()
	gg.toast("Scanning for player position offset")
	find_player_pos()
	gg.toast("Searching nentity")
	find_nentity()
	gg.toast("Scanning for current map offset")
	find_current_map()
	gg.toast("Scanning for game speed offset")
	find_game_speed()
	saveoffsets()

	gg.alert("Found offsets:\nptoplayer = "..string.format("%x", offsets.ptoplayer).."\nplayer -> pos_x = "..string.format("%x", offsets.pos_off).."\nptoentity = "..string.format("%x", offsets.ptoentity).."\nptonentity = "..string.format("%x", offsets.ptonentity).."\nnentity -> curmap = -"..string.format("%x", -offsets.curmap_off).."\nnentity -> gamespeed_off = -"..string.format("%x", -offsets.gamespeed_off))
end

-- gg.getRangesList('[anon:libc_malloc]')

function getadd(add,flag)
	local a = {
		[1] = {address = add, flags = flag}
	}

	b = gg.getValues(a)
	return tonumber(b[1].value)
end

function setadd(add,flag,val,bfreeze)
	local uu = {}

	uu[1] = {
		address = add,
		flags = flag,
		value = val,
		freeze = bfreeze
	}

	gg.setValues(uu)

	if bfreeze then 
		gg.addListItems(uu)
	else
		gg.removeListItems(uu)
	end
end

function find_adds()
	bootloader = gg.getRangesList('libBootloader.so')[1].start
	player = getadd(bootloader + offsets.ptoplayer, gg.TYPE_QWORD)
	player_r = player + offsets.pos_off + 0x20
	nentity = getadd(bootloader + offsets.ptoentity, gg.TYPE_QWORD) + offsets.ptonentity
	nentity_test = getadd(nentity, gg.TYPE_DWORD) == 1099746509

	if not(nentity_test) then
		gg.searchNumber(1099746509, gg.TYPE_DWORD)
		
		if gg.getResultsCount() > 0 then
			nentity = gg.getResults(1)[1].address
			nentity_test = getadd(nentity, gg.TYPE_DWORD) == 1099746509
		end
	end

	if not(nentity_test) then
		gg.toast("Error, some functions may not work.")
	else
		curmap = nentity + offsets.curmap_off
	end
end

function setposit(mx,my,mz)
	jh = {
		{
			address = player + offsets.pos_off,
			flags = gg.TYPE_FLOAT,
			value = mx
		},
		{
			address = player + offsets.pos_off + 0x4,
			flags = gg.TYPE_FLOAT,
			value = my
		},
		{
			address = player + offsets.pos_off + 0x8,
			flags = gg.TYPE_FLOAT,
			value = mz
		}
	}
	gg.setValues(jh)
end

function pmove(dis)
	local x,y,z = getadd(player + offsets.pos_off, gg.TYPE_FLOAT), getadd(player + offsets.pos_off + 0x4, gg.TYPE_FLOAT), getadd(player + offsets.pos_off + 0x8, gg.TYPE_FLOAT)
	local radin = getadd(player_r, gg.TYPE_FLOAT)
	
	local ax = dis * math.sin(radin)
	local az = dis * math.cos(radin)

	setposit(x + ax,y,z + az)
end

function make_positions(map)
	local points = {}

	for i, v in ipairs(posits) do
		if v.map == map then
			table.insert(points, v)
		end
	end

	return points
end

function get_names(list)
	local nm = {}

	for i, v in ipairs(list) do
		table.insert(nm, v.name)
	end

	return nm
end

function get_map()
	local c = ""
	local c1 = ""

	for i = 0, 23 do
		c1 = getadd(curmap + i, gg.TYPE_BYTE)

		if c1 == 47 then
			break
		end

		c = c..string.char(c1)
	end

	return c
end

function get_pos_by_name(list, name)
	for i, v in ipairs(list) do
		if v.name == name then
			return {x = v.x, y = v.y, z = v.z}
		end
	end

	return nil
end

function gotomenu()
	local map = get_map()
	
	ppoints = make_positions(map)
	
	if ppoints ~= nil then
		mp_names = get_names(ppoints)
		place = gg.choice(mp_names, nil, "Where to go?")
	
		if place == nil then
			return
		end
	
		pos = get_pos_by_name(ppoints, mp_names[place])
		setposit(pos.x, pos.y, pos.z)
	
		gg.toast(place)
	else
		gg.toast("No place to go here.")
	end
end

function set_game_speed(speed)
	setadd(nentity + offsets.gamespeed_off, gg.TYPE_FLOAT, speed, false)
end

function input_game_speed()
	local gs = getadd(nentity + offsets.gamespeed_off, gg.TYPE_FLOAT)
	local speed = gg.prompt({"Enter Game Speed:"}, {[1] = tostring(gs)}, {[1] = "number"})
	set_game_speed(speed[1])
end

function loadoffsets()
	config = gx.load_json_file(config_path)
	if config == nil then
		if gg.alert("Looks like offsets weren't found yet. Click \"OK\" to start scanning for offsets. You have to be at home spawn. If you are not at home, please go home, then don't move anywhere", "ok", "exit") ~= 1 then
			os.exit()
		end
		gx.vars.settings = defaults
		find_all_offsets()
		config = gx.load_json_file(config_path)
	elseif config.settings.version ~= gx.vars.settings.version then
		if gg.alert("Looks like Sky were updated. Click \"OK\" to start scanning for offsets. You have to be at home spawn. If you are not at home, please go home, then don't move anywhere", "ok", "exit") ~= 1 then
			os.exit()
		end
		gx.vars.settings = config.settings
		find_all_offsets()
		config = gx.load_json_file(config_path)
	end

	offsets = config.offsets
	gx.vars.settings = config.settings
end

function saveoffsets()
	config = {
		offsets = offsets,
		settings = gx.vars.settings
	}
	gx.save_json_file(config_path, config)
end

function init()
	pcheck()
	loadoffsets()
	find_adds()
end

gx.add_menu({
	title = {"Offset Finder v", {tostring, {"{gx:settings.version}"}}},
	name = "main",
	menu = {
		{"[⬆️] Wall Breach: {gx:settings.wbdistance}", {pmove, {"{gx:settings.wbdistance}"}}},
		{"[🚩] Go to", {gotomenu}},
		{"[🕘] Set Game Speed", {input_game_speed}},
		{"[⚙️] Settings", {gx.open_menu, {"settingsmenu"}}}
	},
	type = "choice"
})

gx.add_menu({
	title = "Settings:",
	name = "settingsmenu",
	menu = {
		{"[⬆️] Wall Breach distance: {gx:settings.wbdistance}", {gx.prompt_set_var, {"settings.wbdistance", "Set distance:"}}},
		{"[💾] Rescan offsets", {find_all_offsets}}
	},
	post_f = {saveoffsets},
	type = "xback",
	menu_repeat = true
})

init()
gx.loop(250, nil, false)

--[[

	          ) (`-.                   .-')    .-') _    62
	           ( OO ).                ( OO ). (  OO) )   79
	  ,----.  (_/.  \_)-..-'),-----. (_)---\_)/     '._  3A
	 '  .-./-')\  `.'  /( OO'  .-.  '/    _ | |'--...__) 20
	 |  |_( O- )\     /\/   |  | |  |\  :` `. '--.  .--' 67
	 |  | .--, \ \   \ |\_) |  |\|  | '..`''.)   |  |    78
	(|  | '. (_/.'    \_) \ |  | |  |.-._)   \   |  |    6F
	 |  '--'  |/  .'.  \   `'  '-'  '\       /   |  |    73
	  `------''--'   '--'    `-----'  `-----'    `--'    74

]]--