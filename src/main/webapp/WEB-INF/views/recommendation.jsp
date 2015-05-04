<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Linked | Recommnedations</title>
 <style>

.link {
  stroke: #ccc;
}

.node text {
  pointer-events: none;
  font: 10px sans-serif;
}

</style>
<link rel='stylesheet' href='../resources/stylesheets/madhur.css' />
<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.7.2.0/prototype.js"></script>
<script type = "text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script charset = "utf-8" type = "text/javascript">
//Constants for the SVG

$(document).ready(function(){ 
	
	var width = 500,
    height = 500;

//Set up the colour scale
var color = d3.scale.category20();

//Set up the force layout
var force = d3.layout.force()
    .charge(-120)
    .linkDistance(80)
    .size([width, height]);

//Append a SVG to the body of the html page. Assign this SVG as an object to svg
var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

//var myjson = JSON.parse('${recommendations}');

    var datam = '${recommendations}';
    var abc = jQuery.parseJSON( datam );
	console.log(abc);
	console.log(abc.nodes);
	console.log(abc.links);
	
	
//Creates the graph data structure out of the json data
force.nodes(abc.nodes)
    .links(abc.links)
    .start();

//Create all the line svgs but without locations yet
var link = svg.selectAll(".link")
    .data(abc.links)
    .enter().append("line")
    .attr("class", "link")
    //.style("marker-end",  "url(#suit)") 
    .style("stroke-width", function (d) {
    return Math.sqrt(d.value);
});

//Do the same with the circles for the nodes - no 
//Changed
var node = svg.selectAll(".node")
    .data(abc.nodes)
    .enter().append("g")
    .attr("class", "node")
    .call(force.drag);

node.append("circle")
    .attr("r", 8)
    .style("fill", function (d) {
    return color(d.group);
})

node.append("text")
      .attr("dx", 10)
      .attr("dy", ".35em")
      .text(function(d) { return d.name });
//End changed


//Now we are giving the SVGs co-ordinates - the force layout is generating the co-ordinates which this code is using to update the attributes of the SVG elements
force.on("tick", function () {
    link.attr("x1", function (d) {
        return d.source.x;
    })
        .attr("y1", function (d) {
        return d.source.y;
    })
        .attr("x2", function (d) {
        return d.target.x;
    })
        .attr("y2", function (d) {
        return d.target.y;
    });

    //Changed
    
    d3.selectAll("circle").attr("cx", function (d) {
        return d.x;
    })
        .attr("cy", function (d) {
        return d.y;
    });

    d3.selectAll("text").attr("x", function (d) {
        return d.x;
    })
        .attr("y", function (d) {
        return d.y;
    });
    node.each(collide(0.5)); 
    //End Changed

});

var padding = 1, // separation between circles
    radius=10;



function collide(alpha) {
  var quadtree = d3.geom.quadtree(abc.nodes);
  return function(d) {
    var rb = 2*radius + padding,
        nx1 = d.x - rb,
        nx2 = d.x + rb,
        ny1 = d.y - rb,
        ny2 = d.y + rb;
    
    quadtree.visit(function(quad, x1, y1, x2, y2) {
      if (quad.point && (quad.point !== d)) {
        var x = d.x - quad.point.x,
            y = d.y - quad.point.y,
            l = Math.sqrt(x * x + y * y);
          if (l < rb) {
          l = (l - rb) / l * alpha;
          d.x -= x *= l;
          d.y -= y *= l;
          quad.point.x += x;
          quad.point.y += y;
        }
      }
      return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
    });
  };
}
	
	
});






</script>
</head>
<body>
<div id="header" style="position:absolute"
		class="global-header responsive-header nav-v5-2-header responsive-1 remote-nav"
		>
		<div id="top-header">
			<div class="wrapper">
				<div class="header-section first-child">
					<h2 class="logo-container" tabindex="0">
						<img class="logo" width="30" height="30" style="top:4px;position:absolute;left:5px;" alt="LinkedIn"
							src="../resources/images/logo.png">
					</h2>
					
					
					
		
				</div>
				<a style="float: right" href="${pageContext.request.contextPath}/signout"> <b><font
						color="white">SignOut</font></b>
				</a>
			</div>
		</div>
		<div class="responsive-nav">
<div class="wrapper">
<ul id="control_gen_4" class="nav main-nav">
<li class="nav-item">
<a href="${pageContext.request.contextPath}/home/<%=request.getSession().getAttribute("user") %>" class="nav-link">
Home
</a>
</li>
<li class="nav-item">
<a href="${pageContext.request.contextPath}/search" class="nav-link">
Search
</a>
</li>
<li class="nav-item">
<a href="" class="nav-link">
Profile
</a>
<ul class="sub-nav" id="profile-sub-nav">
<li>
<a href="${pageContext.request.contextPath}/user-profile/<%= request.getSession().getAttribute("user")%>">
Edit Profile
</a>
</li>

</ul>
</li>
<li class="nav-item">
<button id="nav-link-interests" class="nav-link no-link">
Interests
</button>
<ul class="sub-nav" id="interests-sub-nav">
<li>
<a href="${pageContext.request.contextPath}/company">
Companies
</a>
</li>
</ul>
</li>
<li class="nav-item">
<a href="${pageContext.request.contextPath}/recommend/career-path" class="nav-link">
Career Path
</a>
</li>
</ul>
<b style="float:right"><font color="white"><%=request.getSession().getAttribute("name") %></font></b><br>
<b style="float:right"><font color="white">Last login time: <%=request.getSession().getAttribute("lastLogin") %></font></b>
</div>
</div>

<br>
<br>

		</div>
 
<div class="main">
  <h3>Hello</h3>
</div>
   
  

</body>
</html>