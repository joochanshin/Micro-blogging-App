function clicked(){
	var pass = document.getElementById("password").value;
	var validPass = false;
	for(let i = 0; i < pass.length; i++)
		if(isNumeric(pass[i])){
			validPass = true;
			break;
		}

	if(!validPass){
		alert("Enter at least one number!");
		document.getElementById("formNew").action = "/users/new";
		document.getElementById("formNew").method = "get";
	}
	
}

function isNumeric(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}