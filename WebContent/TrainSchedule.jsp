<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> Train Schedule Insertion </title>
<meta name="keywords" content="Home" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />
<link title="theme" type="text/css" href="timepicker/jquery-ui-1.8.17.custom.css" media="screen" rel="Stylesheet" id="themeCSS" />
<link rel="stylesheet" media="screen" href="timepicker/ui.timepickr.css" />
<script type="text/javascript" src="timepicker/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="timepicker/jquery.timepickr.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){ 
$('#timestart').timepickr({
		rangeMin: ['00','05','10','15','20','25','30','35','40','45','50','55'],
		convention: 24} ).focus(); //timestart.timepickr
}); //document ready
</script>

<script type="text/javascript">  
$(document).ready(function(){ 
	for(var i=1; i<60; i++){
		$('#timestart'+i).timepickr({
				rangeMin: ['00','05','10','15','20','25','30','35','40','45','50','55'],
				convention: 24} ).focus(); //timestart.timepickr
		}
	}
); //document ready

</script>


<%! 
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	public void jspInit(){
		try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/train","root","mysql");
		}
		catch(Exception e ){
			e.printStackTrace();
		}
		}
%>
<!-- Input Validation Script -->
<script type="text/javascript" src="InputValidation.js">
</script>


<script type="text/javascript">
function validate(){
	if(Empty(document.form1.arv1)){		//Empty Field Validation Call
		   if(Empty(document.form1.dep1)){
		     if(Empty(document.form1.arv2)){
			   if(Empty(document.form1.dep2)){
					document.form1.submit();
			   }
		     }
		   }
	}
}
</script>

<script type="text/javascript">
function num2(ele){
	var val = ele.value;
	var len = val.length;
	if(val.search(/[^0-9\:]/) != -1){			// \D is For Not A Digit searc i.e [^0-9]
		alert("Enter Only Digits and :");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
		return false;
 }
	 return true;
}
</script>
</head>
<body>

<div id="templatemo_wrapper">

	<div id="templatemo_header">
    
    	<div id="site_title">
            <h1><a href="home.jsp">
                <img src="./images/train_logo.PNG" width="494" height="110" />
             
            </a></h1>
        </div>
 
        <div id="templatemo_menu">
    
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="SearchTrain.jsp">Trains</a></li>
                <li><a href="SeatAvail.jsp">Booking</a></li>
                <li><a href="Pnr.jsp">PNR Status</a></li>
                <li><a href="contactus.html">Contact Us</a></li>
            </ul>    	
    
    	</div> <!-- end of templatemo_menu -->
        
        <div class="cleaner"></div>
	</div> <!-- end of header -->
    
    <div id="templatemo_content">


	<!-- Form Body -->

<div>


<form name="form1" action="./TrainSchedule1.jsp">
<h1 align="center"> Updation Of Train Schedule</h1>
	<%
	
	String trainno = request.getParameter("trainno");
	String tname= request.getParameter("tname");
	String type= request.getParameter("type");
	String src= request.getParameter("src");
	String dest= request.getParameter("dest");
		
	String srcid= request.getParameter("srcid");
	String destid= request.getParameter("destid");
	String km= request.getParameter("km");
	int sl = 0;
	int a1 = 0;
	int a2 = 0;
	int a3 = 0;
	
	try{
		sl =Integer.parseInt(request.getParameter("sl"));
		a1 = Integer.parseInt(request.getParameter("a1"));
		a2 = Integer.parseInt(request.getParameter("a2"));
		a3 = Integer.parseInt(request.getParameter("a3"));	
	}
	catch(Exception e){		//to catch exceptions of null values
		
	}
	String[] days = new String[7];
		
	String[] day=request.getParameterValues("days");
	
	   if (day != null)
	   {
	      for (int i = 0; i < day.length; i++)
	      {
	         days[i] = day[i];
	       %>
	       <input type="hidden" name="day" value=<%= days[i] %> />
	      <%
	      }
	   }
%>
	
<!-- Values to forward to the next page -->	
<input type="hidden" name="srcid" value=<%= srcid%> />
<input type="hidden" name="destid" value=<%= destid%> />
<input type="hidden" name="km" value=<%= km%> />
<input type="hidden" name="sl" value=<%= sl%> />
<input type="hidden" name="a1" value=<%= a1%> />
<input type="hidden" name="a2" value=<%= a2%> />
<input type="hidden" name="a3" value=<%= a3%> />


<div id="divHead">
<br />
<table align="center">
	<tr>
	  <th colspan="2"> Train Details </th>
	</tr>
		
	<tr>
		<td><label> Train No </label></td>
		<td><input type="text" name="trainno" value="<%= trainno %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Train Name </label></td>
		<td><input type = "text" name="tname" value="<%= tname%>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Type </label></td>
		<td><input type = "text" name="type" value="<%= type %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Source </label></td>
		<td><input type = "text" value="<%= src %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
	<tr>
		<td><label> Destination </label></td>
		<td><input type = "text" value="<%= dest %>" readonly="readonly" tabindex="-1"/></td>
	</tr>
</table>
</div>

<div id="divTable" align="center" style="">

<br />
<hr />
<h4> Schedule Table </h4>
<span style=" font-size: 14px; color: red;"> Use 24hr Format</span>
<table id="table1" border="1" bordercolor=#333333>
<tr bgcolor=#333333 style="color: white">
    	<th> Station No </th>
    	<th> Kilometers</th>
        <th> Station Name </th>
        <th> Arrival Time </th>
        <th> Departure Time </th>
    </tr>

<%

String id = request.getParameter("srcid");		//TO FETCH THE SOURCE STATION ID 
int len = id.length();
String id1 = id.substring(0,len-2);			//To get the starting digits of station id by eliminating the last to digits
id1 = id1 + "%%";		//Adding %% to find the stations which come under the range of station id ex: 1%% i.e 100 to 199
String sql1="select * from route where station_id like '"+id1+"' ";		//SQL Query that gets station id's which come under one route

pstmt = con.prepareStatement(sql1);

rs = pstmt.executeQuery();

int i =1;

while(rs.next()){
%>
	<tr>
	<td> <input type="text" name="station<%=i %>" size="4" readonly="readonly" tabindex="-1" value="<%= rs.getInt("station_id") %>" /> </td>
	<td> <input type="text" size="5" readonly="readonly" tabindex="-1" value="<%= rs.getInt("km")%>" /> </td>
	<td> <input type="text" readonly="readonly" tabindex="-1" value="<%= rs.getString("station_name")%>" /> </td>
	<td> <input type="text" id="timestart<%=i %>" readonly="readonly" name="arv<%=i %>" size="8" maxlength="5" onkeyup="num2(this)" onkeydown="num2(this)" style="font-weight: bold;  background-color: white;" /> </td>
	<td> <input type="text" id="timestart<%=i+20 %>" readonly="readonly" name="dep<%=i %>" size="8" maxlength="5" onkeyup="num2(this)" onkeydown="num2(this)" style="font-weight: bold; background-color: white;" /> </td>
	</tr>
<%
	i=i+1;
}

%>

</table>


<p>
<input type="button" value="Save" onclick="validate()" />
</p>

</div>

</form>

</div>
	<!-- Form Body -->

    </div> <!-- end of templatemo_content -->
    
    <div id="templatemo_sidebar">
    		<div id="request_a_quote">
        <%
        	try{
			if(session.isNew()){			//session.isNew is true for the first time when the page is loaded
			}
			else{
			String uname = (String)session.getAttribute("uname");
			String ssid = (String)session.getAttribute("sid");
			String author = (String)session.getAttribute("author");
			String error = (String)session.getAttribute("error");
			String sessionid = (String)session.getId();
				if(error=="Y"){				//error=Y is set when the email and password are mismatched
				}
				else if(ssid == sessionid) {			//To verify the session id of page and sid i.e session id set during session creation match
				%>
					<h2> Login Details</h2><br/>
					<p style="font-size: 12pt">
					<label style="color:#DD0000;"> UserName</label> &nbsp; <%= uname %>	<br/>
					<label style="color:#DD0000;"> Authority </label> &nbsp; <%= author.toUpperCase() %>	<br/>
					<br/>
					<a href="<%= author%>home.jsp"> <%= author.toUpperCase() %>	Home</a>
					<a href='Logout.jsp'> Logout</a>
					</p>
				<%
				}
				else{			//if all cases fail login is prompted
				}
			}
        }
        catch(Exception e){       	
        }
		%>
        </div>
    
      <div id="sidebar_featured_project">
			<div class="cleaner"></div>
            <div class="cleaner"></div>
            <div class="cleaner"></div>
            <div class="cleaner"></div>      
            <h3>Information</h3>
            <div class="right" >
            
              <h6 ><a href="SearchTrain.jsp">Trains Btw Stations</a></h6>
              <h6><a href="SearchSchedule.jsp">Train Schedules</a></h6>
              <h6><a href="ViewFare.jsp">Fare List</a></h6>
              <h6><a href="http://www.indianrail.gov.in" target="_new">Other Railway Websites </a></h6>
         
            </div>
            
             <div class="cleaner"></div>
            
        </div>
        <div class="cleaner"></div>
    </div>
    
    <div id="templatemo_footer">

        <ul class="footer_menu">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="SearchTrain.jsp">Train Between Stations</a></li>
            <li><a href="feedback.jsp">FeedBack</a></li>
            <li class="last_menu"><a href="contactus.html">Contact Us</a></li>
        </ul>
    
       Copyright &copy; 2012 <a href="#">Railway Reservation</a> | <a href="http://www.sjrc.edu.in/" target="_new">SJRC</a> 
<p>Center For Railway Information Systems, Designed and Hosted by Nabeel Ahmed and Nikhil C Padia.</p>
    
    </div> <!-- end of footer -->

</div> <!-- end of wrapper -->


</body>
</html>
