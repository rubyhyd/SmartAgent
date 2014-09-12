  sensor_color = '#ddd'
  actuator_color = '#ddd' 
	var tx=0;
	var ty=0;
	var ax=0;
	var ay=0;
	var trigger_left;
	var trigger_top;
	var actuator_left;
	var actuator_top;
	var n=0;
	var window_width = $(window).width();
	var percent = 0.18;
	var flag = false;

	function dragstart(event)
	{	
		if(event.target.id == "triggercanvas")
		{
		
		trigger_left = parseInt($("#triggerdiv").css("left"));
		trigger_top = parseInt($("#triggerdiv").css("top"));
		tx = event.pageX;
		ty = event.pageY;
		
		
		
		
		}
		else if(event.target.id == "actuatorcanvas")
		{
		
		actuator_left = parseInt($("#actuatordiv").css("left"));
		actuator_top = parseInt($("#actuatordiv").css("top"));
		ax = event.pageX;
		ay = event.pageY;
		
		}
		
		
		//$("#triggerdiv").css({left:  100+ "px"});
		//$("#triggerdiv").css({top:  "100px"});
	}
	function fill(id,color)
	{
		var canvas = document.getElementById(id);
		var context = canvas.getContext('2d');
		context.strokeStyle=color;
		context.fillStyle = color;
		context.fill();
		context.stroke();
	}
	function drawtrigger(id,length,r)
	{
		
		var canvas = document.getElementById(id);
		canvas.setAttribute("width",length*1.21);
		canvas.setAttribute("height",length*1.01);
		
		
		if( canvas == null) return false;
	/*	
var ctx=canvas.getContext("2d");
ctx.beginPath();
ctx.beginPath();
ctx.moveTo(20,20);           // 创建开始点
ctx.lineTo(100,20);          // 创建水平线
ctx.arcTo(150,20,150,70,50); // 创建弧
ctx.lineTo(150,120);         // 创建垂直线
ctx.stroke();*/
		
		var context = canvas.getContext('2d');
		/*
		context.shadowColor = "#00CCEE";
		context.shadowBlur = 5;
		context.shadowOffsetX = 8;
		context.shadowOffsetY = 6;
		*/
		context.strokeStyle="#ddd";
		
		context.fillStyle = "#ddd";
		context.beginPath();
		context.beginPath();
		context.moveTo(0,r);
		context.lineTo(0,length-r);
		
		context.arcTo(0,length,r,length,r);
		
		context.lineTo(length-r,length);
		context.arcTo(length,length,length,length-r,r);
		context.lineTo(length,0.6*length);
		context.lineTo(1.2*length,0.6*length);
		context.lineTo(1.2*length,0.4*length);
		context.lineTo(length,0.4*length);
		context.lineTo(length,r);
		context.arcTo(length,0,length-r,0,r);
		context.lineTo(r,0);
		context.arcTo(0,0,0,r,r);
		context.closePath();
		context.fill();
		context.stroke();
		
		
	}
	function drawactuator(id,length,r)
	{
		var canvas = document.getElementById(id);
		canvas.setAttribute("width",length*1.00);
		canvas.setAttribute("height",length*1.01);
		
		if( canvas == null) return false;
		
		var context = canvas.getContext('2d');
		context.strokeStyle="#ddd";
		context.fillStyle = "#ddd";
		context.moveTo(0,r);
		context.lineTo(0,0.4*length);
		context.lineTo(0.2*length,0.4*length);
		context.lineTo(0.2*length,0.6*length);
		context.lineTo(0,0.6*length);
		context.lineTo(0,length-r);
		context.arcTo(0,length,r,length,r);
		context.lineTo(length-r,length);
		context.arcTo(length,length,length,length-r,r);
		context.lineTo(length,r);
		context.arcTo(length,0,length-r,0,r);
		context.lineTo(r,0);
		context.arcTo(0,0,0,r,r);
		context.closePath();
		context.fill();
		context.stroke();
		
	}
	function drag(event)
	{
//alert(""+triggerdiv.style.top);
		if(event.target.id=="triggercanvas")
		{
		var movex = event.pageX - tx + trigger_left;
		var movey = event.pageY - ty + trigger_top;
		$("#triggerdiv").css({top: movey+'px'});
		$("#triggerdiv").css({left: movex+'px'});
		
			if(actuator_left-movex<window_width*percent)
			{
				$("#triggerdiv").css({top: actuator_top+'px'});
				$("#triggerdiv").css({left: (actuator_left-window_width*percent)+'px'});
				flag = true;
			}
			else
			{
				flag = false;
			}
		
		}
		else if(event.target.id=="actuatorcanvas"){
		
			var movex = event.pageX - ax + actuator_left;
			var movey = event.pageY - ay + actuator_top;
			$("#actuatordiv").css({top: movey+'px'});
			$("#actuatordiv").css({left: movex+'px'});
			if(movex-trigger_left<window_width*percent)
			{
				$("#actuatordiv").css({top: trigger_top+'px'});
				$("#actuatordiv").css({left: (trigger_left+window_width*percent)+'px'});
				flag = true;
			}
			else
			{
				flag = false;
			}
		
		
		}
	
		//$("#output").html(event.pageX+" "+event.pageY+" "+movex+" "+movey);
		//$("#triggerdiv").css({top: +tops+movey+'px'});
		//$("#triggerdiv").css({left: +lefts+movex+'px'});
		
		
		//triggerdiv.style.top = parseInt(triggerdiv.style.top)+movey + "px";  
            	//triggerdiv.style.left = 400 + "px";
		
	}
	function drop(event)
	{
		
		event.preventDefault();
		if(event.target.id=="triggercanvas")
		{
			trigger_left = parseInt($("#triggerdiv").css("left"));
			trigger_top = parseInt($("#triggerdiv").css("top"));
		}
		else
		{
			actuator_left = parseInt($("#actuatordiv").css("left"));
			actuator_top = parseInt($("#actuatordiv").css("top"));
		}
		if(flag)
		{
			fill("actuatorcanvas","#99FF00");
			fill("triggercanvas","#99FF00");
      $('#hidden-a').trigger('click');
		}
		else
		{
			fill("actuatorcanvas", actuator_color);
			fill("triggercanvas", sensor_color);
			
		}
	}
	function allowdrop(event)
	{
		event.preventDefault();
	}
	
	function allowdrop2(event)
	{
		event.preventDefault();
		
	}

  cuidie_drag = function(){

		//alert($(window).width()+"**"+$(window).height());
	  //if(shuaxin==0) {
    //  shuaxin = 1; 
    //  window.location.reload();	
    //  }
	//shuaxin = 0
		//$("#triggercanvas").css({"width":window_width*percent,"height":300});
		
		drawtrigger('triggercanvas',window_width*percent,20);
		drawactuator('actuatorcanvas',window_width*percent,20);
		
		
		$("#triggerdiv").css({top: '0px'});
		$("#triggerdiv").css({left: window_width*0.2+'px'});
		
		$("#actuatordiv").css({top: '0px'});
		$("#actuatordiv").css({left: window_width*0.57+'px'});
		
		trigger_left = parseInt($("#triggerdiv").css("left"));
		trigger_top = parseInt($("#triggerdiv").css("top"));
		
		actuator_left = parseInt($("#actuatordiv").css("left"));
		actuator_top = parseInt($("#actuatordiv").css("top"));
		
		$("#sensorwslist img").click(function(){
			$("#sensorwslist img").parent().css({background:'#ffffff'});
			$(this).parent().css({background:'#cccccc'});
		});
		
		$("#createtriggerbutton").click(function(){
			$("#triggercontent").html('<img src="img/u1.png"/>');
		});
		
		
	};
	
	$(document).ready(cuidie_drag);



// modal tagsinput
function myfunc(){
	$("#mail-content").addTag("sth");
		//console.log("button click")}
}
function addTags(str){
	if(!$('#mail-content').tagExist(str))
		$('#mail-content').addTags(str);
}