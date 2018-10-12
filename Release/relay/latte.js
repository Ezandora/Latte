
function postFormRequest(page_url, parameters)
{
	//Example:
	//postFormRequest("choice.php", {"pwd":hash, "option":"1", "whichchoice":"1267", "wish":wish});
	var form = document.createElement("form");
	form.setAttribute("method", "POST");
	form.setAttribute("action", page_url);
	
	
	for (var key in parameters)
	{
		if (!parameters.hasOwnProperty(key)) continue;
		var input = document.createElement("input");
		input.setAttribute("type", "hidden");
		input.setAttribute("name", key);
		input.setAttribute("value", parameters[key]);
		form.appendChild(input);
	}
		
	document.body.appendChild(form);
	form.submit();
}

function latteGetAllButtonDivs()
{
	var button_id = 0;
	var buttons = [];
	var failure = false;
	while (button_id < 10000)
	{
		var button_div = document.getElementById("button_" + button_id);
		if (button_div === null)
		{
			break;
		}
		buttons.push(button_div);
		
		button_id += 1;
	}
	
	return buttons;
}

function latteGetSelectedButtonDivs()
{
	var selected_divs = [];
	var all_button_divs = latteGetAllButtonDivs();
	for (var i = 0; i < all_button_divs.length; i++)
	{
		var button_div = all_button_divs[i];
		if (button_div.dataset.selected === "true")
			selected_divs.push(button_div);
	}
	return selected_divs;
}

function updateOrderButton()
{
	//order_latte_button
	var order_button_div = document.getElementById("order_latte_button");
	var selected_buttons = latteGetSelectedButtonDivs();
	if (selected_buttons.length >= 3)
	{
		var order_text = "Order a";
		if (selected_buttons[0].dataset.name0.startsWith("A"))
			order_text += "n";
		order_text += " " + selected_buttons[0].dataset.name0;
		if (!selected_buttons[0].dataset.name0.endsWith("-"))
			order_text += " ";
		order_text += selected_buttons[1].dataset.name1;
		order_text += " Latte " + selected_buttons[2].dataset.name2;
		order_button_div.innerHTML = order_text;
		order_button_div.className = "latte_button";
		//order_button_div.style.visibility = "visible";
		//order_button_div.style.display = "block";
	}
	else
	{
		order_button_div.innerHTML = "Select Three Ingredients";
		order_button_div.className = "";
		//order_button_div.style.visibility = "hidden";
		//order_button_div.style.display = "none";
	}
}



function latteIngredientClickedDiv(button_div)
{
	var is_selected = button_div.dataset.selected === "true";
	
	
	
	var selected_buttons = latteGetSelectedButtonDivs();
	var button_count_currently_selected = selected_buttons.length;
	
	if (!is_selected && button_count_currently_selected >= 3)
	{
		//If we have three selected already, don't select.
		//Show error?
		return;
	}
	
	is_selected = !is_selected;
	if (is_selected)
	{
		button_count_currently_selected += 1;
		button_div.dataset.selected = "true";
		button_div.className = "latte_button latte_button_selected";
	}
	else
	{
		button_count_currently_selected -= 1;
		button_div.dataset.selected = "false";
		button_div.className = "latte_button";
	}
	
	updateOrderButton();
}

function latteIngredientClicked(button_id)
{
	var button_div = document.getElementById("button_" + button_id);
	latteIngredientClickedDiv(button_div);
}

function autoSelectIngredients()
{
	//Deselect current:
	var selected_button_divs_previous = latteGetSelectedButtonDivs();
	for (var i = 0; i < selected_button_divs_previous.length; i++)
		latteIngredientClickedDiv(selected_button_divs_previous[i]);
	//Select the autos:
	var datastore_div = document.getElementById("latte_datastore");
	latteIngredientClicked(parseInt(datastore_div.dataset.auto0));
	latteIngredientClicked(parseInt(datastore_div.dataset.auto1));
	latteIngredientClicked(parseInt(datastore_div.dataset.auto2));
}


function makeLatteButtonClicked()
{
	//Go through every button, mark ones we have selected.
	var selected_button_divs = latteGetSelectedButtonDivs();
	if (selected_button_divs.length != 3)
	{
		//autoSelectIngredients();
		return;
	}
	
	var pwd = document.getElementById("latte_datastore").dataset.pwd;
	//choice.php
	//pwd
	//whichchoice=1329
	//option=1
	//l1=
	//l2=
	//l3=
	var parameters = {"pwd":pwd, "whichchoice":"1329", "option":"1",
	"l1":selected_button_divs[0].dataset.l1,
	"l2":selected_button_divs[1].dataset.l2,
	"l3":selected_button_divs[2].dataset.l3};
	
	postFormRequest("choice.php", parameters);
}