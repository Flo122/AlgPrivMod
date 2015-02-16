/*

	Main configuration for non-persistent market system
	Will need triggers to hook into vanilla pricing methods

*/

////////////MAIN CONFIG

life_market_resources = [

	//Schema: SHORTNAME, DEFAULT-WERT, MIN-WERT, MAX-WERT, VERÄNDERUNG BEI AKTION [VERKAUF Multipliziert mit 1, Kauf multipliziert um -1
	//["gold", 1500, 450, 2300, 8, 5],
		
	["oilp", 3078, 200, 8940, 2, 2, 
		[ 
			["diamondc",1], 
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["cement",1],
			["glass",1], 
			["schwefelp",1]
		] 
	],
	
	//Eisenbarren	
	["iron_r", 3116, 200, 5000, 1, 2,  
		[ 
			["diamondc",1], 
			["oilp",1],
			["copper_r",1],
			["salt_r",1],
			["cement",1],
			["glass",1], 
			["schwefelp",1]

		] 
	],
	
	["diamondc", 3839, 200, 8500, 2, 2, 
		[ 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["cement",1],
			["glass",1],
			["schwefelp",1]

		] 
	],
	
	["copper_r", 3184, 200, 2750, 1, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["salt_r",1],
			["cement",1],
			["glass",1]

		] 
	],
	
	["salt_r", 3351, 200, 4350, 1, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["cement",1],
			["glass",1]
		] 
	],
	
	["glass", 3812, 200, 5800, 2, 1, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["cement",1],
			["schwefelp",1]
		] 
	],
	
	["cement", 4984, 200, 9350, 2, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["glass",1],
			["schwefelp",1]
		] 
	],
	["schwefelp", 3032, 200, 5350, 2, 1, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["glass",1]
		] 
	],
	
	["silberp", 3596, 200, 9350, 2, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["glass",1]
		] 
	],

	["holzp", 3265, 200, 8350, 2, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["glass",1]
			
		] 
	],
	
	//Gussformen
	["eisenp", 4185, 200, 7350, 2, 2, 
		[ 
			["diamondc",1], 
			["oilp",1],
			["iron_r",1],
			["copper_r",1],
			["salt_r",1],
			["glass",1]
		] 
	],
	["apple", 30, 25, 350, 2, 1, 
		[ 
			["peach",1], 
			["zuckerp",1]
		] 
	],
	///////////////////////////////////
	
	["turtle", 20086, 11000, 24000, 20, 18,  
		[ 
			["marijuana",1], 
			["cocainep",1],
			["heroinp",1],
			["pkugel",1],
			["pbrau",1]
		
		] 
	],
	
	["marijuana", 6546, 200, 15900, 2, 3,   
		[ 
			["turtle",1], 
			["cocainep",1],
			["heroinp",1]

			
		] 
	],
	
	["cocainep", 6837, 200, 14300, 3, 3,   
		[ 
			["marijuana",1], 
			["turtle",1],
			["heroinp",1],
			["pkugel",1],
			["pbrau",1]
		] 
	],
	
	["heroinp", 5345, 200, 9200, 2, 4,   
		[ 
			["marijuana",1], 
			["cocainep",1],
			["turtle",1]

		] 
	],

	["pkugel", 40325, 3000, 80200, 11, 8,   
		[ 
			["marijuana",1], 
			["cocainep",1],
			["turtle",1],
			["uran5",1]
		] 
	],
	["uran5", 65144, 20000, 164200, 60, 40,   
		[ 
			["pkugel",1], 
			["pbrau",1]
			
		] 
	],
	["pbrau", 11500, 3000, 100200, 1, 2,   
		[ 
			["marijuana",1], 
			["cocainep",1],
			["turtle",1],
			["pkugel",1],
			["uran5",1]
		] 
	]
	
	
	
];
publicVariable "life_market_resources";
 
////////////GENERATED CONFIG
//life_market_changes = []; //[SHORTNAME,SELL,BUY]
life_market_shortnames = []; //shortnames if in market
//life_market_clampprices = []; //[SHORTNAME,MIN,MAX]
 
{
	life_market_shortnames set [count life_market_shortnames, _x select 0];
	//life_market_clampprices set [count life_market_clampprices, [_x select 0, _x select 2, _x select 3] ];
	//life_market_changes set [count life_market_changes, [_x select 0, _x select 4, _x select 5] ];
}
foreach life_market_resources;
 
publicVariable "life_market_shortnames";
//publicVariable "life_market_clampprices";
 
////////////SYNC PRICES WITH SERVER IF EMPTY
//if(isNil("life_market_prices")) then
//{
	life_market_prices = []; //[SHORTNAME,CURRENTPRICE,DIRECTIONGLOBAL,DIRECTIONLOCAL]
	{
	
		life_market_prices set [count life_market_prices, [_x select 0, _x select 1, 0, 0] ];
	}
	foreach life_market_resources;
	
	publicVariable "life_market_prices";
	
	
//};