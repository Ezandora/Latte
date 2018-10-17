import "relay/choice.ash";
//Choice	override

//Set latteRelayDisabled to true if you want to disable this and not uninstall it.
//I thought about adding a button for it, but then I thought... does anyone need it?

//Also, you can CLI "choice.1329.ash refill" to refill your latte with an algorithm that is terrible.
string __latte_relay_version = "1.0.1";

boolean __setting_debug = false;

string capitaliseFirstLetter1329(string v)
{
	buffer buf;
	buf.append(v);
	if (v.length() <= 0)
		return v;
	buf.replace(0, 1, buf.char_at(0).to_upper_case());
	return buf.to_string();
}


Record LatteIngredient
{
	boolean is_disabled;
	boolean already_selected;
	string [int] input_values;
	string [int] names;
	string enchantment_html;
};

string [string] __images_for_ingredients_raw =
{
	"hellion":"images/itemimages/swords.gif",
	"cajun spice":"images/itemimages/meat.gif",
	"rawhide":"images/itemimages/babyworm.gif",
	"grave mold":"images/itemimages/tombstone.gif",
	"lizard milk":"images/itemimages/gilamonster.gif",
	"paradise milk":"images/itemimages/palmtree.gif",
	"squamous":"images/itemimages/gibberer.gif",
	"hobo spice":"images/itemimages/hobohead.gif"
};

item [string] __images_for_ingredients =
{
	//coal dust for a spice
	"ancient/spicy":$item[ancient spice],
	"pumpkin spice":$item[pumpkin],
	"butternut-spice":$item[pat of butter],
	"cajun spice":$item[none],
	"greek spice":$item[Uranium Omega of Temperance],
	"hobo spice":$item[none],
	"spaghetti squash spice":$item[spaghetti with rock-balls], //it looks more like ice cream
	"basil":$item[big leaf],
	"Belgian vanilla":$item[consummate ice cream],
	"blue chalk":$item[cube of billiard chalk],
	"bug-thistle":$item[jitterbug larva],
	"macaroni":$item[fleetwood macaroni],
	"carrot":$item[sea carrot],
	"carrrdamom":$item[Dreadsylvanian seed pod],
	"chili seeds":$item[jaba&ntilde;ero pepper],
	"cinnamon":$item[rain-doh violet bo],
	"cloves":$item[crude crudit&eacute;s],
	"coal":$item[lump of coal],
	"cocoa powder":$item[cookie cookie],
	"diet soda":$item[Cloaca-Cola],
	"dwarf cream":$item[invisibility cream],
	"Dyspepsi":$item[Dyspepsi-Cola],
	"asp venom":$item[snakehead charrrm],
	"hot sausage":$item[sausage bomb],
	"health potion":$item[extra-strength red potion],
	"rock salt":$item[chunk of rock salt],
	"filth milk":$item[handful of juicy garbage],
	"white flour":$item[all-purpose flower],
	"vitamin":$item[vitamin G pill],
	"fresh grass":$item[grass clippings],
	"fungus":$item[warm mushroom],
	"sausage":$item[knob sausage],
	"grobold rum":$item[redrum],
	"guarna":$item[dead guy's watch],
	"gunpowder":$item[V for Vivala mask],
	"hellion":$item[none],
	"hot wing":$item[hot wing],
	"ink":$item[inkwell],
	"kombucha":$item[cuppa Loyal tea],
	"lihc saliva":$item[lihc face],
	"lizard milk":$item[none], //maybe Mutant Gila Monster familiar?
	"grave mold":$item[none],
	"motor oil":$item[gas can],
	"MSG":$item[msg],
	"norwhal milk":$item[li'l unicorn costume], //'
	"oil paint":$item[pretentious palette],
	"paradise milk":$item[none],
	"rawhide":$item[none],
	"salt":$item[tiny shaker of salt],
	"sandalwood splinter":$item[cement sandals],
	"space pumpkin":$item[ginormous pumpkin],
	"squamous":$item[none],
	"mega sausage":$item[blood sausage],
	"teeth":$item[loose teeth],
	"vanilla":$item[conjured ice cream]
};

location [string] __locations_for_ingredients =
{
	"ancient/spicy":$location[The Mouldering Mansion],
	"asp venom":$location[The Middle Chamber],
	"basil":$location[The Overgrown Lot],
	"Belgian vanilla":$location[Whitey's Grove], //'
	"blue chalk":$location[The Haunted Billiards Room],
	"bug-thistle":$location[The Bugbear Pen], //FIXME post-quest or before?
	"butternut-spice":$location[Madness Bakery],
	"cajun spice":$location[The Black Forest],
	"carrot":$location[The Dire Warren],
	"carrrdamom":$location[Barrrney's Barrr], //'
	"chili seeds":$location[The Haunted Kitchen],
	"cinnamon":$location[none],
	"cloves":$location[The Sleazy Back Alley],
	"coal":$location[The Haunted Boiler Room],
	"cocoa powder":$location[The Icy Peak],
	"dwarf cream":$location[Itznotyerzitz Mine],
	"filth milk":$location[The Feeding Chamber],
	"fresh grass":$location[The Hidden Park],
	"fungus":$location[The Fungal Nethers],
	"grave mold":$location[the unquiet garves],
	"grobold rum":$location[The Old Rubee Mine],
	"guarna":$location[The Bat Hole Entrance],
	"gunpowder":$location[1st Floor\, Shiawase-Mitsuhama Building],
	"health potion":$location[The Daily Dungeon],
	"hellion":$location[The Dark Neck of the Woods],
	"hobo spice":$location[Hobopolis Town Square],
	"hot sausage":$location[Cobb's Knob Barracks], //'
	"hot wing":$location[The Dark Heart of the Woods],
	"ink":$location[The Haunted Library],
	"lihc saliva":$location[The Defiled Niche],
	"lizard milk":$location[The Arid\, Extra-Dry Desert],
	"macaroni":$location[The Haunted Pantry],
	"mega sausage":$location[Cobb's Knob Laboratory], //'
	"motor oil":$location[The Old Landfill],
	"MSG":$location[The Briniest Deepests],
	"norwhal milk":$location[The Ice Hole],
	"oil paint":$location[The Haunted Gallery],
	"paradise milk":$location[The Stately Pleasure Dome],
	"pumpkin spice":$location[none],
	"rawhide":$location[The Spooky Forest],
	"rock salt":$location[The Brinier Deepers],
	"salt":$location[The Briny Deeps],
	"sandalwood splinter":$location[Noob Cave],
	"sausage":$location[Cobb's Knob Kitchens], //'
	"space pumpkin":$location[The Hole in the Sky],
	"squamous":$location[The Caliginous Abyss],
	"teeth":$location[The VERY Unquiet Garves],
	"vanilla":$location[none],
	"vitamin":$location[The Dark Elbow of the Woods],
	"white flour":$location[The Road to the White Citadel],
	"spaghetti squash spice":$location[The Copperhead Club],
	"diet soda":$location[Battlefield (No Uniform)],
	"greek spice":$location[Wartime Frat House],
	"kombucha":$location[Wartime Hippy Camp],
	
	/*
	"Dyspepsi":$location[REPLACEME],*/
};

int INGREDIENT_GROUPING_USEFUL = 1;
int INGREDIENT_GROUPING_ASCENSION_RELEVANT = 2;
int INGREDIENT_GROUPING_ELEMENTAL_DAMAGE = 8;
int INGREDIENT_GROUPING_DAMAGE = 9;
int INGREDIENT_GROUPING_REGEN = 6;
int INGREDIENT_GROUPING_RESISTANCE = 5;
int INGREDIENT_GROUPING_STATS = 3;

int [string] __grouping_for_ingredient = {
	"ancient/spicy":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"asp venom":INGREDIENT_GROUPING_DAMAGE,
	"basil":INGREDIENT_GROUPING_REGEN,
	"Belgian vanilla":INGREDIENT_GROUPING_STATS,
	"blue chalk":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"bug-thistle":INGREDIENT_GROUPING_STATS,
	"butternut-spice":INGREDIENT_GROUPING_DAMAGE,
	"cajun spice":INGREDIENT_GROUPING_USEFUL,
	"carrot":INGREDIENT_GROUPING_USEFUL,
	"carrrdamom":INGREDIENT_GROUPING_REGEN,
	"chili seeds":INGREDIENT_GROUPING_RESISTANCE,
	"cinnamon":INGREDIENT_GROUPING_STATS,
	"cloves":INGREDIENT_GROUPING_RESISTANCE,
	"coal":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"cocoa powder":INGREDIENT_GROUPING_RESISTANCE,
	"diet soda":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"dwarf cream":INGREDIENT_GROUPING_STATS,
	"Dyspepsi":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"filth milk":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"fresh grass":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"fungus":INGREDIENT_GROUPING_STATS,
	"grave mold":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"greek spice":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"grobold rum":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"guarna":INGREDIENT_GROUPING_USEFUL,
	"gunpowder":INGREDIENT_GROUPING_DAMAGE,
	"health potion":INGREDIENT_GROUPING_REGEN,
	"hellion":INGREDIENT_GROUPING_USEFUL,
	"hobo spice":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"hot sausage":INGREDIENT_GROUPING_STATS,
	"hot wing":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"ink":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"kombucha":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"lihc saliva":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"lizard milk":INGREDIENT_GROUPING_REGEN,
	"macaroni":INGREDIENT_GROUPING_STATS,
	"mega sausage":INGREDIENT_GROUPING_STATS,
	"motor oil":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"MSG":INGREDIENT_GROUPING_DAMAGE,
	"norwhal milk":INGREDIENT_GROUPING_STATS,
	"oil paint":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"paradise milk":INGREDIENT_GROUPING_STATS,
	"pumpkin spice":INGREDIENT_GROUPING_STATS,
	"rawhide":INGREDIENT_GROUPING_USEFUL,
	"rock salt":INGREDIENT_GROUPING_DAMAGE,
	"salt":INGREDIENT_GROUPING_DAMAGE,
	"sandalwood splinter":INGREDIENT_GROUPING_STATS,
	"sausage":INGREDIENT_GROUPING_STATS,
	"space pumpkin":INGREDIENT_GROUPING_STATS,
	"spaghetti squash spice":INGREDIENT_GROUPING_DAMAGE,
	"squamous":INGREDIENT_GROUPING_RESISTANCE,
	"teeth":INGREDIENT_GROUPING_ELEMENTAL_DAMAGE,
	"vanilla":INGREDIENT_GROUPING_STATS,
	"vitamin":INGREDIENT_GROUPING_ASCENSION_RELEVANT,
	"white flour":INGREDIENT_GROUPING_RESISTANCE,
};

float [string] __relative_power_for_ingredient = {
	"ancient/spicy":50,
	"asp venom":25,
	"basil":5,
	"Belgian vanilla":100 * 0.2 + 100 * 0.2 + 100 * 0.2,
	"blue chalk":25,
	"bug-thistle":20,
	"butternut-spice":10,
	"cajun spice":5,
	"carrot":4,
	"carrrdamom":5 * 10,
	"chili seeds":3,
	"cinnamon":1,
	"cloves":3,
	"coal":25,
	"cocoa powder":3,
	"diet soda":50,
	"dwarf cream":30,
	"Dyspepsi":25,
	"filth milk":1,
	"fresh grass":50.1,
	"fungus":30,
	"grave mold":20,
	"greek spice":25,
	"grobold rum":25,
	"guarna":2,
	"gunpowder":50,
	"health potion":15,
	"hellion":1,
	"hobo spice":51,
	"hot sausage":100 * 0.5,
	"hot wing":100,
	"ink":100,
	"kombucha":25,
	"lihc saliva":25,
	"lizard milk":10 * 10,
	"macaroni":20,
	"mega sausage":100 * 0.5,
	"motor oil":20,
	"MSG":15 * 2,
	"norwhal milk":100 * 2,
	"oil paint":51,
	"paradise milk":20 + 20 + 20,
	"pumpkin spice":1,
	"rawhide":3,
	"rock salt":10 * 2,
	"salt":5 * 2,
	"sandalwood splinter":5 + 5 + 5,
	"sausage":100 * 0.5,
	"space pumpkin":10 + 10 + 10,
	"spaghetti squash spice":20,
	"squamous":3,
	"teeth":50,
	"vanilla":1,
	"vitamin":99,
	"white flour":3,
};

float LatteIngredientSorter(LatteIngredient gradiant)
{
	float value;
	if (gradiant.is_disabled)
		value += 1000000.0;
	string name = gradiant.names[1];
	value += 10000.0 * __grouping_for_ingredient[name];
	value += -__relative_power_for_ingredient[name];
	return value;
}

LatteIngredient [int] __saved_picked_ingredients;
boolean __ignore_disabled_relay;
void handleLatte(string page_text)
{
	LatteIngredient [int] saved_picked_ingredients;
	__saved_picked_ingredients = saved_picked_ingredients;
	if (!page_text.contains_text("You visit your friendly neighborhood coffee shop and puzzle over the menu") || (!__ignore_disabled_relay && get_property("latteRelayDisabled").to_boolean()))
	{
		write(page_text);
		return;
	}
	//write(page_text);
	
	LatteIngredient [int] ingredients;
	LatteIngredient [string] ingredients_by_name;
	
	//Parse:
	string page_text_using_for_matching = page_text.replace_string("\r","").replace_string("\n","");
	string [int][int] line_matches = page_text_using_for_matching.group_string("<tr style=[^>]*>(.*?)</tr>");
	int currently_available_ingredient_count = 0;
	foreach key in line_matches
	{
		LatteIngredient gradiant;
		string line = line_matches[key][1];
		gradiant.is_disabled = line.contains_text("&Dagger;");
		
		if (__setting_debug)
			gradiant.is_disabled = (random(4) != 0);
			
		if (!gradiant.is_disabled)
			currently_available_ingredient_count += 1;
		
		//core_out.append("<br>");
		string [int][int] td_matches = line.group_string("<td[^>]*>(.*?)</td>");
		if (td_matches.count() != 5) continue;
		foreach key2 in td_matches
		{
			string td_core = td_matches[key2][1];
			//core_out.append("<br>" + td_core.entity_encode());
			
			if (td_core.contains_text(" checked"))
				gradiant.already_selected = true;
			if (key2 == 4)
				gradiant.enchantment_html = td_core.replace_string("<i>", "").replace_string("<br />", ""); //game's HTML contains a needless <i> and no </i>. and the last <br /> we don't want
			if (key2 <= 3 && key2 >= 1)
			{
				string input_value = td_core.group_string("<input .*? value=\"([^\"]*)\"")[0][1];
				string name = td_core.group_string("<input[^>]*> (.*)")[0][1];
				
				name = name.replace_string("    ", ""); //trailing four spaces
				/*if (name.length() > 0 && name.substring(name.length() - 1) == " ")
				{
					//name = name.substring(0, name.length() - 4);
				}*/
				
				gradiant.input_values[gradiant.input_values.count()] = input_value;
				gradiant.names[gradiant.names.count()] = name;
				//print_html("\"" + name + "\": \"" + input_value + "\"");
			}
		}
		
		ingredients[ingredients.count()] = gradiant;
		ingredients_by_name[gradiant.names[1]] = gradiant;
		
		//core_out.append("<br><br>" + line.entity_encode());
	}
	
	sort ingredients by LatteIngredientSorter(value);
	
	boolean no_refills_left = page_text.contains_text("You've got <b>0</b> refills left today.");
	string [int][int] buttons;
	LatteIngredient [int][int] buttons_ingredients;
	int active_grouping_number = -1;
	int disabled_boundary_grouping_id = -1;
	foreach key, gradiant in ingredients
	{
		buffer button;
		boolean different_grouping = false;
		//boolean use_hr = false;
		if (key > 0 && gradiant.is_disabled && !ingredients[key - 1].is_disabled)
		{
			different_grouping = true;
			disabled_boundary_grouping_id = active_grouping_number + 1;
			//use_hr = true;
		}
		if (key > 0 && __grouping_for_ingredient[gradiant.names[1]] != __grouping_for_ingredient[ingredients[key - 1].names[1]])
			different_grouping = true;
		
		if (different_grouping || active_grouping_number == -1)
		{
			active_grouping_number += 1;
			string [int] blank;
			buttons[active_grouping_number] = blank;
			/*if (use_hr)
				core_out.append("<hr>");
			else if (!gradiant.is_disabled || true)
				core_out.append("<hr>");
			else
				core_out.append("<br>");*/
		}
		string style = "margin:5px;display:inline-block;width:18%;";
		if (gradiant.is_disabled)
			style += "opacity:0.5;";
			
		string core_ingredient_name = gradiant.names[1];
		
		
		//button.append("<span style=\"" + style + "\">");
		
		button.append("<div style=\"display:table;" + (gradiant.is_disabled ? "opacity:0.5;" : "") + "\">");
		button.append("<div style=\"display:table-row;\">");
		button.append("<div style=\"display:table-cell;vertical-align:middle;\">");
		
		string image_url = "";
		if (__images_for_ingredients[core_ingredient_name] != $item[none])
			image_url = "images/itemimages/" + __images_for_ingredients[core_ingredient_name].image;
		else if (__images_for_ingredients_raw contains core_ingredient_name)
			image_url = __images_for_ingredients_raw[core_ingredient_name];
		if (image_url == "")
		{
			image_url = "images/itemimages/confused.gif";
		}
		button.append("<img src=\"" + image_url + "\" style=\"mix-blend-mode:multiply;\" width=30 height=30>");
		
		button.append("</div>");
		button.append("<div style=\"display:table-cell;vertical-align:middle;\">");
		button.append("<strong>");
		button.append(core_ingredient_name.capitaliseFirstLetter1329());
		button.append("</strong>");
		
		if (gradiant.is_disabled)
		{
			button.append("<br>");
			if (__locations_for_ingredients[core_ingredient_name] == $location[none])
				button.append("Unknown unlock");
			else
				button.append("Unlocked in " + __locations_for_ingredients[core_ingredient_name]);
		}
		//if (__relative_power_for_ingredient[core_ingredient_name] == REPLACEME && __setting_debug)
			//button.append("<br><font color=red>Needs score</font>");
		
		button.append("<br>");
		//<small><span style="color: blue;">+5 <font color=red>Hot Damage</font><br>+5 <font color=blue>Cold Damage</font><br>+5 <font color=gray>Spooky Damage</font><br>+5 <font color=blueviolet>Sleaze Damage</font><br>+5 <font color=green>Stench Damage</font></span></small>
		string enchantment_html = gradiant.enchantment_html;
		if (core_ingredient_name == "oil paint") //override to save some space
			enchantment_html = "<small><span style=\"color: blue;\">+5 <font color=red>p</font><font color=blue>r</font><font color=gray>i</font><font color=blueviolet>s</font><font color=green>m</font><font color=red>a</font><font color=blue>t</font><font color=gray>i</font><font color=blueviolet>c</font> damage</span></small>";
		enchantment_html = enchantment_html.replace_string("<span style=\"color: blue;\">", "<span style=\"color: #333333;\">");
		button.append(enchantment_html);
		
		
		button.append("</div>");
		button.append("</div>");
		button.append("</div>");
		//button.append("</span>");
		int id = buttons[active_grouping_number].count();
		buttons[active_grouping_number][id] = button;
		buttons_ingredients[active_grouping_number][id] = gradiant;
	}
	if (disabled_boundary_grouping_id == -1) disabled_boundary_grouping_id = 1000000;
	buffer core_out;
	
	
	
	
	
	core_out.append("<script type=\"text/javascript\" src=\"latte.js\"></script>");
	core_out.append("<style type=\"text/css\">");
	
	core_out.append("div.latte_button {background-color: #FFFFFF;color: #000000;-webkit-appearance: none;-webkit-border-radius: 0;text-align:left;vertical-align:middle;padding-top: 2px;padding-right: 6px;padding-bottom: 3px;padding-left: 6px;cursor:pointer;border-radius:3px;} div.latte_button:hover {background-color:#E1E3E7;} ");
	core_out.append("div.latte_button_selected {background-color: #D1D3D7; }");
	
	core_out.append("</style>");
	
	
	if (true)
	{
		//Preamble:
		boolean banish_used = get_property("_latteBanishUsed").to_boolean();
		boolean copy_used = get_property("_latteCopyUsed").to_boolean(); //more of an olfact than a copy
		boolean drink_used = get_property("_latteDrinkUsed").to_boolean();
	
		Record Infographic
		{
			string image_url;
			string header;
			string subtext;
			boolean disabled;
		};
		
		string refill_first_text = "Refill first.";
		if (get_property("_latteRefillsUsed").to_int() >= 3)
			refill_first_text = "Wait for tomorrow.";
		Infographic [int] infographics;
		if (true)
		{
			Infographic info;
			info.image_url = "images/itemimages/lattecup3.gif";
			info.header = "Throw Latte on Opponenent";
			if (!banish_used)
			{
				info.subtext = "Banish/free run available.";
				if (!no_refills_left && !can_interact())
					info.subtext = "<span style=\"color:red\">" + info.subtext + "</span>";
			}
			else
			{
				info.disabled = true;
				info.subtext = refill_first_text;
			}
			infographics[infographics.count()] = info;
		}
		if (true)
		{
			Infographic info;
			info.image_url = "images/itemimages/lattecup2.gif";
			info.header = "Offer Latte to Opponent";
			if (!copy_used)
				info.subtext = "Olfaction-lite available.";
			else
			{
				info.disabled = true;
				info.subtext = refill_first_text;
			}
			infographics[infographics.count()] = info;
		}
		if (true)
		{
			Infographic info;
			info.image_url = "images/itemimages/lattecup4.gif";
			info.header = "Gulp Latte";
			if (!drink_used)
				info.subtext = "Restores 50% HP/MP.";
			else
			{
				info.disabled = true;
				info.subtext = refill_first_text;
			}
			infographics[infographics.count()] = info;
		}
		if (infographics.count() > 0)
		{
			core_out.append("<div style=\"display:table;width:100%;vertical-align:middle;\">");
			core_out.append("<div style=\"display:table-row;\">");
			foreach key, info in infographics
			{
				string base_align = "left";
				if (key == 1)
					base_align = "center";
				else if (key == 2)
					base_align = "right";
				core_out.append("<div style=\"width:33%;display:table-cell;text-align:" + base_align + ";" + (info.disabled ? "opacity:0.5;" : "") + "\">");
			
				core_out.append("<div style=\"display:inline-block;\">"); //for text-align
				//oh yes
				core_out.append("<div style=\"display:table;text-align:left;\">");
				core_out.append("<div style=\"display:table-row;\">");
				core_out.append("<div style=\"display:table-cell;vertical-align:middle;\">");
				core_out.append("<img src=\"" + info.image_url + "\" width=30 height=30>");
				core_out.append("</div>");
				core_out.append("<div style=\"display:table-cell;vertical-align:middle;\">");
				core_out.append("<strong>" + info.header + "</strong>");
				core_out.append("<br>");
				core_out.append(info.subtext);
				core_out.append("</div>");
				core_out.append("</div>");
				core_out.append("</div>");

				core_out.append("</div>");
				core_out.append("</div>");
			}
			core_out.append("</div>");
			core_out.append("</div>");
			//core_out.append("<br>"); //add some space
			core_out.append("<hr>");
		}
	}
	
	
	//core_out.append("<button style=\"cursor:pointer;\" onmouseup=\"makeLatteButtonClicked();\" class=\"button\">Order that Latte</button>");
	if (!no_refills_left)
	{
		core_out.append("<div style=\"display:table;width:100%;\">");
		core_out.append("<div style=\"display:table-row;\">");
		core_out.append("<div style=\"display:table-cell;font-size:1.5em;font-weight:bold;padding:10px;text-align:center;width:80%;text-align:left;vertical-align:middle;\" onmouseup=\"makeLatteButtonClicked();\" class=\"\" id=\"order_latte_button\">Select Three Ingredients</div>");
		core_out.append("<div style=\"display:table-cell;font-size:1.5em;font-weight:bold;padding:10px;text-align:center;width:20%;text-align:right;vertical-align:middle;\" onmouseup=\"autoSelectIngredients();\" class=\"latte_button\">Auto Pick Ingredients</div>");
		core_out.append("</div>");
		core_out.append("</div>");
	}
	
	core_out.append("<div style=\"display:table;width:100%;\">");
	
	//We randomly permute the order of the button IDs, so that the ingredient order is different. This doesn't affect the quality of the coffee, but looks nicer.
	int [int] button_randomisation_array;
	for i from 0 to currently_available_ingredient_count - 1
	{
		button_randomisation_array[i] = i;
	}
	//Use random swap permute algorithm that I vaguely remember.
	for i from 0 to currently_available_ingredient_count - 1
	{
		int target = random(currently_available_ingredient_count);
		int v = button_randomisation_array[i];
		button_randomisation_array[i] = button_randomisation_array[target];
		button_randomisation_array[target] = v;
	}
	
	int [int] button_ids_to_preselect;
	int [string] button_id_for_ingredient;
	int entry_count_on_line = 0;
	int button_id_raw = 0;
	foreach grouping in buttons
	{
		if (grouping > 0 && false)
			core_out.append("<hr>");
		if (grouping > 0 && false)
		{
			core_out.append("<div style=\"display:table-row;\">");
			core_out.append("<br>");
			core_out.append("</div>");
		}
		boolean combine_with_last_line = false;
		if (entry_count_on_line + buttons[grouping].count() <= 5 && false)
			combine_with_last_line = true;
		if (disabled_boundary_grouping_id == grouping || (grouping > 0 && !combine_with_last_line))
		{
			core_out.append("</div>");
			
			/*if (disabled_boundary_grouping_id == grouping)
			{
				core_out.append("<div style=\"font-size:1.5em;font-weight:bold;padding:10px;text-align:center;visibility:hidden;display:none;\" onmouseup=\"makeLatteButtonClicked();\" class=\"\" id=\"order_latte_button\">Order that Latte</div>");
			}*/
			core_out.append("<hr>");
			core_out.append("<div style=\"display:table;width:100%;\">");
			entry_count_on_line = 0;
		}
		core_out.append("<div style=\"display:table-row;\">");
		
		string extra_cell_style;
		int buttons_on_line = buttons[grouping].count();
		if (buttons_on_line >= 5 || true)
			extra_cell_style += "width:20%;";
		else if (buttons_on_line == 4)
			extra_cell_style += "width:25%;";
		else if (buttons_on_line == 3)
			extra_cell_style += "width:33%;";
		else if (buttons_on_line == 2)
			extra_cell_style += "width:50%;";
		else if (buttons_on_line == 1)
			extra_cell_style += "width:100%;";
		//extra_cell_style += "border-left:1px solid black;";
		int per_line_limit = 5;
		int output_on_line_so_far = 0;
		foreach key, button in buttons[grouping]
		{
			LatteIngredient gradiant = buttons_ingredients[grouping][key];
			if (output_on_line_so_far >= per_line_limit)
			{
				core_out.append("</div>");
				core_out.append("<div style=\"display:table-row;\">");
				output_on_line_so_far = 0;
			}
			core_out.append("<div style=\"display:table-cell;vertical-align:middle;" + extra_cell_style+ "\"");
			if (disabled_boundary_grouping_id > grouping && !no_refills_left)
			{
			
				int button_id = button_randomisation_array[button_id_raw];
				button_id_for_ingredient[gradiant.names[1]] = button_id;
				
				if (gradiant.already_selected)
					button_ids_to_preselect[button_ids_to_preselect.count()] = button_id;
				core_out.append(" id=\"button_" + button_id + "\"");
				core_out.append(" class=\"latte_button\" onclick=\"latteIngredientClicked(");
				//Arguments:
				core_out.append(button_id);
				core_out.append(");\"");
				core_out.append(" data-l1=\"" + gradiant.input_values[0] + "\"");
				core_out.append(" data-l2=\"" + gradiant.input_values[1] + "\"");
				core_out.append(" data-l3=\"" + gradiant.input_values[2] + "\"");
				
				core_out.append(" data-name0=\"" + gradiant.names[0] + "\"");
				core_out.append(" data-name1=\"" + gradiant.names[1] + "\"");
				core_out.append(" data-name2=\"" + gradiant.names[2] + "\"");
				core_out.append(" data-selected=\"false\"");
				button_id_raw += 1;
			}
			core_out.append(">");
			core_out.append(button);
			core_out.append("</div>");
			output_on_line_so_far += 1;
			entry_count_on_line += 1;
		}
		if (output_on_line_so_far < per_line_limit)
		{
			//output extra cells for alignment purposes:
			for i from output_on_line_so_far to per_line_limit
			{
				core_out.append("<div style=\"display:table-cell;vertical-align:middle;" + extra_cell_style+ "\">");
				core_out.append("</div>");
			}
		}
		core_out.append("</div>");
	}
	core_out.append("</div>");
	
	
	//Calculate some automatic good choices, so they can press a button and be lazy:
	//Note: good choices are made up.
	int [int] best_auto_button_ids;
	if (true)
	{
		string [int] active_ingredient_names;
		float [string] ingredient_priority;
		int refills_used = get_property("_latteRefillsUsed").to_int(); //FIXME bother to parse from HTML?
		
		float [string] priority_preamble;
		if (refills_used == 2)
		{
			priority_preamble["guarna"] += 10000.0;
			priority_preamble["hellion"] += 10000.0;
		}
		else
		{
			priority_preamble["guarna"] -= 10000.0;
			priority_preamble["hellion"] -= 10000.0;
		}
		if (!can_interact())
			priority_preamble["vitamin"] += 50.0;
		if (my_primestat() == $stat[muscle])
		{
			priority_preamble["vanilla"] += 1.0;
		}
		else if (my_primestat() == $stat[mysticality])
		{
			priority_preamble["pumpkin spice"] += 1.0;
		}
		else if (my_primestat() == $stat[moxie])
		{
			priority_preamble["cinnamon"] += 1.0;
		}
		priority_preamble["carrot"] += 200.0;
		priority_preamble["cajun spice"] += 200.0;
		priority_preamble["rawhide"] += 200.0;
		if (!hippy_stone_broken())
			priority_preamble["hellion"] -= 100000.0;
		if (my_familiar() == $familiar[none])
			priority_preamble["rawhide"] -= 10000.0;
			
		//both +combat and -combat are good, but we don't want them selected with auto code
		priority_preamble["hot wing"] -= 200.0;
		priority_preamble["ink"] -= 200.0;
		
		foreach name in button_id_for_ingredient
		{
			active_ingredient_names[active_ingredient_names.count()] = name;
			
			float v = 0.0;
			v += __relative_power_for_ingredient[name];
			v += priority_preamble[name];
			
			int grouping_id = __grouping_for_ingredient[name];
			if (grouping_id == INGREDIENT_GROUPING_ELEMENTAL_DAMAGE)
				v *= 0.2;
			if (grouping_id == INGREDIENT_GROUPING_RESISTANCE)
				v *= 16.0;
			ingredient_priority[name] = v;
		}
		sort active_ingredient_names by -ingredient_priority[value];
		
		for i from 0 to 2
		{
			best_auto_button_ids[i] = button_id_for_ingredient[active_ingredient_names[i]];
			__saved_picked_ingredients[__saved_picked_ingredients.count()] = ingredients_by_name[active_ingredient_names[i]];
		}
	}
	
	//core_out.append("<br><button style=\"cursor:pointer;\" onmouseup=\"disableLatteGUIButtonClicked();\" class=\"button\">Disable Relay Interface</button>");
	//core_out.append("<br><div style=\"cursor:pointer;text-decoration:underline;\" onmouseup=\"disableLatteGUIButtonClicked();\" class=\"button\">Disable Relay Interface</div>");
	core_out.append("<div style=\"display:none;\" id=\"latte_datastore\" data-pwd=\"" + my_hash() + "\" data-auto0=\"" + best_auto_button_ids[0] + "\" data-auto1=\"" + best_auto_button_ids[1] + "\" data-auto2=\"" + best_auto_button_ids[2] + "\"></div>");
	
	
	
	string page_text_before_form = page_text.substring(0, page_text.index_of("<form"));
	string page_text_after_form = page_text.substring(page_text.index_of("</form>") + "</form>".length() + 1);
	
	page_text_before_form = page_text_before_form.replace_string("You order a:", "");
	page_text_before_form = page_text_before_form.replace_string("<b>Latte Shop</b>", "<b>Latte Shop v" + __latte_relay_version + "</b>");
	
	
	if (currently_available_ingredient_count == 3 && button_ids_to_preselect.count() == 0)
	{
		for i from 0 to 2
			button_ids_to_preselect[button_ids_to_preselect.count()] = i;
	}
	if (button_ids_to_preselect.count() > 0)
	{
		buffer onload_text;
		foreach key, button_id in button_ids_to_preselect
		{
			onload_text.append("latteIngredientClicked(");
			onload_text.append(button_id);
			onload_text.append(");");
		}
		page_text_before_form = page_text_before_form.replace_string("<body", "<body onload=\"" + onload_text + "\"");
	}
	write(page_text_before_form);
	write(core_out);
	write(page_text_after_form);
	
}

void autoRefillLatte()
{
	//least-effort implementation:
	//ideally, move the parsing/auto-selection to another function and use that
	__ignore_disabled_relay = true;
	handleLatte(visit_url("main.php?latte=1", false, false));
	__ignore_disabled_relay = false;
	
	if (__saved_picked_ingredients.count() != 3) return;
	string url = "choice.php?whichchoice=1329&option=1";
	for i from 1 to 3
	{
		url += "&l" + i + "=";
		url += __saved_picked_ingredients[i - 1].input_values[i - 1];
	}
	visit_url(url);
}

void main(string page_text_encoded)
{
	if (page_text_encoded == "refill")
	{
		autoRefillLatte();
		return;
	}
	string page_text = page_text_encoded.choiceOverrideDecodePageText();
	if (form_fields()["relay_request"] != "")
	{
	}
	else
		handleLatte(page_text);
	
}