var request = new XMLHttpRequest();

request.open('GET' , 'https://persephone.shrubbery.org.za/test/myfirst.php');

request.onreadystatechange = function () {

	if ((request.status=200) && (request.readyState==4)) {
		console.log(request.status);
		console.log(request.responseText);
	}
}

request.send();
