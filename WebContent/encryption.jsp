<%@page import="com.aklc.ed.model.EncryptionHistory"%>
<%@page import="java.util.List"%>
<%@page import="com.aklc.ed.model.User"%>
<%@page import="com.aklc.ed.dao.EncryptionHistoryDAO"%>
<%
	String loggedin = (String) session.getAttribute("loggedin");
	if (loggedin == null || !loggedin.equals("yes"))
	{
		response.sendRedirect("login.jsp?msg=Session Expired. Please login again");
	}
	else
	{
	
%>




<!doctype html>
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

	<link href='https://fonts.googleapis.com/css?family=Lato:400,900,700,700italic,400italic,300italic,300,100italic,100,900italic' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Dosis:400,500,700,800,600,300,200' rel='stylesheet' type='text/css'>
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
						<li><a href="encryption.jsp">Encryption</a></li>
						<li><a href="decryption.jsp">Decryption</a></li>
						<li><a href="updateprofile.jsp">Edit Profile</a></li>
						<li><a href="changepassword.jsp">Change Password</a></li>
						<li><a href="login.jsp">Delete Profile</a></li>
						<li><a href="login.jsp">Logout</a></li>
					</ul>
					<ul class="">
						<li><a href="welcome.jsp">Welcome</a></li>
						<li><a href="encryption.jsp">Encryption</a></li>
						<li><a href="decryption.jsp">Decryption</a></li>
						<li><a href="updateprofile.jsp">Edit Profile</a></li>
						<li><a href="changepassword.jsp">Change Password</a></li>
						<li><a href="user?req_type=deleteprofile">Delete Profile</a></li>
						<li><a href="user?req_type=logout">Logout</a></li>
					</ul>
				</nav>
				<a style='font-weight: bold; font-size: 26px;' href="javascript:void(0)">ED PORTAL</a> </div>
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
		
		
		
			<h2>Encryption Operation</h2>
			<hr/>
			<div class="service_area">
				<div class="row">
					
					<h3>Encryption of Plain Text</h3>
					<hr/>
					
					<%
						String cipher = request.getParameter("cipher");
						if (cipher != null && cipher.length() > 0)
						{
							%>
									<hr/>
									<p>Cipher Text is: </p>
									<h4><%=cipher %></h4>
									<hr/>
							<%
						}
					%>
					
					
					<form action='encrypt'>
						<input type=hidden name='req_type' value='plaintext' />
						<label>Enter the plain text</label>
						<input name='text' type=text class='form-control' placeholder='Plain Text' />
						<br/>
						<input type=submit value='Encrypt' class='btn btn-primary'/>
					</form>
					<hr/>
					<h3>Encryption of Text File</h3>
					<hr/>
					<form action='encrypt?req_type=textfile' method="post" enctype="multipart/form-data">
						<label>Chose the text file</label>
						<input type=file name='file' class='form-control' placeholder='Plain Text' />
						<br/>
						<input type=submit value='Encrypt' class='btn btn-primary'/>
					</form>
					<hr/>
					<h3>Encryption History</h3>
					<hr/>				
					
					<% 
						EncryptionHistoryDAO ehDao = new EncryptionHistoryDAO();
						User uModel = (User) session.getAttribute("model");	
						try
						{
							List<EncryptionHistory> result = ehDao.read(uModel.getEmail());
							if (result != null && result.size() > 0)
							{
								%>
					<table class='table'>
						<tr>
							<th>Email</th>
							<th>Type</th>
							<th>Entry Time</th>							
						</tr>					
						
								
								<%
								
								for (EncryptionHistory eh: result)
								{
									%>
						<tr>
							<td> <%=eh.getEmail() %></td>
							<td> <%=eh.getEncryption_type()%></td>
							<td> <%=eh.getEntry_time() %></td>
						</tr>									
									<%
								}
								
								%>
						</table>
								
								<%
							}
							else
							{
								%>
									<h4>No Encryption History Found </h4>
								<%
							}
						} 
						catch (Exception e)
						{
							%>
								<h4>Error while querying the database</h4>
							<%
						}
						
					%>
					
						
				</div>
			</div>
		</div>
	</section>
		<div class="container">
			<div class="footer_bottom">
				<span>© ED Portal</span>
				<div class="credits">
					Designed by <a href="http://vtuprojects.com/">Ashok Kumar Learning Center (AKLC)</a>
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
			animateClass: 'animated',
			offset: 100
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
					scrollTop: $($anchor.attr('href')).offset().top - 91
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
		jQuery(document).ready(function($) {
			// Portfolio Isotope
			var container = $('#portfolio-wrap');


			container.isotope({
				animationEngine: 'best-available',
				animationOptions: {
					duration: 200,
					queue: false
				},
				layoutMode: 'fitRows'
			});

			$('#filters a').click(function() {
				$('#filters a').removeClass('active');
				$(this).addClass('active');
				var selector = $(this).attr('data-filter');
				container.isotope({
					filter: selector
				});
				setProjects();
				return false;
			});


			function splitColumns() {
				var winWidth = $(window).width(),
					columnNumb = 1;


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
				var winWidth = $(window).width(),
					columnNumb = splitColumns(),
					postWidth = Math.floor(winWidth / columnNumb);

				container.find('.portfolio-item').each(function() {
					$(this).css({
						width: postWidth + 'px'
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


<% } %>
