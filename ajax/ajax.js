		$(document).ready(function() {
			$('#getFeed').click(function(data) {
			$.getJSON('https://persephone.shrubbery.org.za/test/myfirst.php', function(data) {
				if(data) {
					$.each(data, function(key, value) {
						$('#feedContainerList').append(
							"<li>Student name is " + value.studentid + " and student name is " + value.firstname + " " + value.lastname + "</li>");
						});
					}
				});
			});
		});
