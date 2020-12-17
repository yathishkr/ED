<!doctype html>
<%@page import="com.aklc.ed.model.User"%>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, maximum-scale=1">
<title>ED Portal</title>
<link rel="icon" href="favicon.png" type="image/png">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/linecons.css" rel="stylesheet" type="text/css">
<link href="css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="css/responsive.css" rel="stylesheet" type="text/css">
<link href="css/animate.css" rel="stylesheet" type="text/css">

<link
	href='https://fonts.googleapis.com/css?family=Lato:400,900,700,700italic,400italic,300italic,300,100italic,100,900italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Dosis:400,500,700,800,600,300,200'
	rel='stylesheet' type='text/css'>
<script type="text/javascript" src="js/jquery.1.8.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery-scrolltofixed.js"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/jquery.isotope.js"></script>
<script type="text/javascript" src="js/wow.js"></script>
<script type="text/javascript" src="js/classie.js"></script>

<script type="text/javascript">
	$(document).ready(function(e) {
		$('.res-nav_click').click(function() {
			$('ul.toggle').slideToggle(600)
		});

		$(document).ready(function() {
			$(window).bind('scroll', function() {
				if ($(window).scrollTop() > 0) {
					$('#header_outer').addClass('fixed');
				} else {
					$('#header_outer').removeClass('fixed');
				}
			});

		});

	});

	function resizeText() {
		var preferredWidth = 767;
		var displayWidth = window.innerWidth;
		var percentage = displayWidth / preferredWidth;
		var fontsizetitle = 25;
		var newFontSizeTitle = Math.floor(fontsizetitle * percentage);
		$(".divclass").css("font-size", newFontSizeTitle)
	}
</script>
</head>

<body>

	<!--Header_section-->
	<header id="header_outer">
		<div class="container">
			<div class="header_section">
				<nav class="nav" id="nav">
					<ul class="toggle">
						<li><a href="welcome.jsp">Welcome</a></li>
						<li><a href="udpateprofile.jsp">Edit Profile</a></li>
						<li><a href="changepassword.jsp">Change Password</a></li>
						<li><a href="login.jsp">Delete Profile</a></li>
						<li><a href="login.jsp">Logout</a></li>
					</ul>
					<ul class="">
						<li><a href="welcome.jsp">Welcome</a></li>
						<li><a href="encryption.jsp">Encryption</a></li>
						<li><a href="decryption.jsp">Decryption</a></li>

						<li><a href="udpateprofile.jsp">Edit Profile</a></li>
						<li><a href="changepassword.jsp">Change Password</a></li>
						<li><a href="user?req_type=deleteprofile">Delete Profile</a></li>
						<li><a href="login.jsp">Logout</a></li>
					</ul>
				</nav>
				<a style='font-weight: bold; font-size: 26px;'
					href="javascript:void(0)">ED PORTAL</a>
			</div>
		</div>
	</header>
	<!--Header_section-->


	<!--Service-->
	<section id="service">
		<div class="container">
		
			<%
				String msg = request.getParameter("msg");
			%>
			
			<%
				if (msg != null)
				{
			%>
			
			<hr/>
			<h3><%=msg %></h3>
			<hr/>
			
			<% } %>
		
		
		
			<h2>Update Profile Page</h2>
			<div class="service_area">
				<div class="row">
					
					<%
						User model = (User) session.getAttribute("model");
					%>
					

					<form action='user' >
						<input type=hidden name='req_type' value='updateprofile' />
						<label>Email:</label> 
						<input name='email' readonly="readonly" value='<%=model.getEmail()%>'
						 type=text class='form-control' placeholder='Email' /> <br /> 
						
						<label>Update Your First Name:</label> 
						<input name='fname' value='<%=model.getFirstname() %>' type=text class='form-control' placeholder='First Name' /> 
							<br /> 

						<label>Update Your Last Name:</label> 
						<input name='lname' value='<%=model.getLastname() %>' type=text class='form-control' placeholder='Last Name' /> <br /> 
						
						<% 
							if (model.getGender().equals("Male"))
							{
								%>
						<label>Select Your Gender</label> <br /> 
						<input checked="checked" type=radio value='Male' name='gender' /> Male &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type=radio name='gender' value='Female' /> Female <br />
								
								<%
							}
							else
							{
								%>
						<label>Select Your Gender</label> <br /> 
						<input type=radio value='Male' name='gender' /> Male &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<input checked="checked"  type=radio name='gender' value='Female' /> Female <br />
								
								<%
							}
						
						%>
						
						
						
			
						<br /> 
						
						<label>Update Your Mobile Number:</label> 
						<input name='mobile' value='<%=model.getMobile() %>' type=text class='form-control' placeholder='Mobile Number' /> <br /> 

						<label>Update Your	Address:</label>
						<textarea name='address' class='form-control' placeholder='Address'><%=model.getAddress() %></textarea>
						<br /> 
						
						<input type=submit value='Update Profile'
							class='btn btn-primary' />
					</form>



				</div>
			</div>
		</div>
	</section>
	<div class="container">
		<div class="footer_bottom">
			<span>© ED Portal</span>
			<div class="credits">
				Designed by <a href="http://vtuprojects.com/">Ashok Kumar
					Learning Center (AKLC)</a>
			</div>
		</div>
	</div>
	</footer>
	<script type="text/javascript">
		$(document).ready(function(e) {
			$('#header_outer').scrollToFixed();
			$('.res-nav_click').click(function() {
				$('.main-nav').slideToggle();
				return false

			});

		});
	</script>
	<script>
		wow = new WOW({
			animateClass : 'animated',
			offset : 100
		});
		wow.init();
		document.getElementById('').onclick = function() {
			var section = document.createElement('section');
			section.className = 'wow fadeInDown';
			section.className = 'wow shake';
			section.className = 'wow zoomIn';
			section.className = 'wow lightSpeedIn';
			this.parentNode.insertBefore(section, this);
		};
	</script>
	<script type="text/javascript">
		$(window).load(function() {

			$('a').bind('click', function(event) {
				var $anchor = $(this);

				$('html, body').stop().animate({
					scrollTop : $($anchor.attr('href')).offset().top - 91
				}, 1500, 'easeInOutExpo');
				/*
				if you don't want to use the easing effects:
				$('html, body').stop().animate({
					scrollTop: $($anchor.attr('href')).offset().top
				}, 1000);
				 */
				event.preventDefault();
			});
		})
	</script>

	<script type="text/javascript">
		jQuery(document)
				.ready(
						function($) {
							// Portfolio Isotope
							var container = $('#portfolio-wrap');

							container.isotope({
								animationEngine : 'best-available',
								animationOptions : {
									duration : 200,
									queue : false
								},
								layoutMode : 'fitRows'
							});

							$('#filters a').click(function() {
								$('#filters a').removeClass('active');
								$(this).addClass('active');
								var selector = $(this).attr('data-filter');
								container.isotope({
									filter : selector
								});
								setProjects();
								return false;
							});

							function splitColumns() {
								var winWidth = $(window).width(), columnNumb = 1;

								if (winWidth > 1024) {
									columnNumb = 4;
								} else if (winWidth > 900) {
									columnNumb = 2;
								} else if (winWidth > 479) {
									columnNumb = 2;
								} else if (winWidth < 479) {
									columnNumb = 1;
								}

								return columnNumb;
							}

							function setColumns() {
								var winWidth = $(window).width(), columnNumb = splitColumns(), postWidth = Math
										.floor(winWidth / columnNumb);

								container.find('.portfolio-item').each(
										function() {
											$(this).css({
												width : postWidth + 'px'
											});
										});
							}

							function setProjects() {
								setColumns();
								container.isotope('reLayout');
							}

							container.imagesLoaded(function() {
								setColumns();
							});

							$(window).bind('resize', function() {
								setProjects();
							});

						});
		$(window).load(function() {
			jQuery('#all').click();
			return false;
		});
	</script>
	<script src="contactform/contactform.js"></script>

</body>
</html>
