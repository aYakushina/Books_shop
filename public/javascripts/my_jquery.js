//закрашивание строк в таблице
$(document).ready(function(){
			$('table.list').find('tr:odd').css("background-color","#101010"); 
		
$("#listing a:first").css("color","white");

		 $("#listing a").click(function(){	
				$("#listing a").css("color","#1e90ff");
         $(this).css("color","white");
					});  

	//гармошка
    $(".list .accordion:first").addClass("active");
    $(".list #description").hide(); 
    $(".list .accordion").click(function(){
 
        $(this).next("#description").fadeToggle();
        $(this).toggleClass("active");
        $(this).siblings(".accordion").removeClass("active");
     });  

		//подсказки		 
		get_tips();

		//меню
     //$('#menu #item a').hover(
      //  function (e) {          
					//	$(this).parent().animate({
  		//			  'left': '+=1%'
  			//		},300);
     //   },
      //  function () {
			//				$(this).parent().animate({
  		//			  'left': '-=1%'
  		//			},300);
      //  }
  	//  );

		//перчик
		
		$('#circle').hide();
    $('.circle').click(function (e) {	
					$('.bottom_menu').animate({
									'left': '-120px'
									},300)
				$('#circle').show();
				$('#circle').offset({top: 450, left: 300});	
		}); 		

		$('#circle').hover(function (e) { 
				
					var x = e.pageX,
   				y = e.pageY,
					ch = $(this).offset(),
					n = 8, m = 1,
					direction = Math.floor( Math.random( ) * (n - m + 1) ) + m,
					width = $(window).width(), height =  $(window).height() ;
 					
					m=40; n=60;
					var res_x=ch.left, res_y=ch.top,
					delta =  Math.floor( Math.random( ) * (n - m + 1) ) + m;
						if(direction == 1){res_x +=  delta;}
						if(direction == 2){res_x -=  delta;}
						if(direction == 3){res_y +=  delta;}
						if(direction == 4){res_y -=  delta;}
						if(direction == 5){res_x +=  delta; res_y +=  delta;}
						if(direction == 6){res_x +=  delta; res_y -=  delta;}
						if(direction == 7){res_x -=  delta; res_y +=  delta;}
						if(direction == 8){res_x -=  delta; res_y -=  delta;}
						
						//$(this).offset({top: res_y, left: res_x});	
						$(this).animate({
  						 'left': res_x,
						   'top': res_y
  					},100);
					//$('#inform').html(" координаты:" + x + ",  "+ y + " " + ch.top + "  " + ch.left + " direction: " + direction + " delta" + delta +" h" + height+" w" + width);
        }  
  	 );

		//стрелка для .bottom_menu
		$('.arrow').click(function (e) {
						$('.bottom_menu').animate({
								'left': '0'
								},300);
		}); 

		//модальное окно
		$('a[name=modal]').click(function(e) {
			$('.bottom_menu').animate({
									'left': '-120px'
									},300)
    //e.preventDefault();
    var id = $(this).attr('href');
    var maskHeight = $(document).height();
    var maskWidth = $(document).width();
    $('#mask').css({'width':maskWidth,'height':maskHeight});
    $('#mask').fadeTo("fast",0.8); 
    var winH = $(document).height();
    var winW = $(document).width();
		    
    $(id).fadeIn(300); 
  
		//рисовалка
			 $('#rafael').html('');
			var paper = Raphael(document.getElementById("rafael"), $(id).width(), $(id).height()-10);
			var rect = paper.rect(1, 0, $(id).width()-1, $(id).height()-10);
			
			rect.mousedown(function (event) {
					
			});




			//var c = paper.circle(0,0,1000).attr({
		//			fill: "black",
		//			stroke: "none"
		//	});

			//var start = function () {
			// storing original coordinates
			//this.ox = this.attr("cx");
			//this.oy = this.attr("cy");
			//var path = paper.path("M" + this.ox + " " + this.oy));
		//	},

			//move = function (dx, dy) {
			// move will be called with dx and dy
			//var path = paper.path("M" + (this.ox + dx)+ " " + (this.oy + dy) + "L" + (this.ox + dx-1) + " " + (this.oy + dy-1));
				//this.translate((this.ox + dx),(this.oy + dy));
			
		//	paper.circle(this.ox + dx, this.oy + dy, 10).attr({fill: "blue", stroke: "none"});
		
			//},

			//up = function () {
		  // restoring state
//};

			//c.drag(move, start, up);
			
		 

 });
  
		
    $('.window .close').click(function (e) {	
				e.preventDefault();
   			$('#mask, .window').hide();
				}); 
 
   

});

function get_tips(){
$('[rel=tooltip]').bind('mouseover', function(){ //для всех элементов у которых rel равен tootltip при наведениии курсора выполняется функция	 
	var theMessage = $(this).attr('content');// переменной themessage приравниваем значения поля content
	$('	<div class="tooltip">' + theMessage + '</div>').appendTo('body').fadeIn('fast');//themessage выводим между тегами div с классом tootltip
	$(this).bind('mousemove', function(e){ //функция определяет положение мыши и переносит за ним подскаску
	            /*$('div.tooltip').css({
	                'top': e.pageY - ($('div.tooltip').height())-10,
	                'left': e.pageX + 25
	            });*/
						smtMouseCoordsX=e.pageX;
						smtMouseCoordsY=e.pageY;
						var cursor_tip_margin_x=0;  //Промежуток по горизонтали между курсором и подсказкой
						var cursor_tip_margin_y=24; //Промежуток по вертикали между курсором и подсказкой
						var leftOffset=smtMouseCoordsX+cursor_tip_margin_x+$('div.tooltip').outerWidth();
						var topOffset=smtMouseCoordsY+cursor_tip_margin_y+$('div.tooltip').outerHeight();
						if(leftOffset<=$(window).width()){
							$('div.tooltip').css("left",smtMouseCoordsX+cursor_tip_margin_x);
						} else {
							var thePosX=smtMouseCoordsX-(cursor_tip_margin_x)-$(smtTip).width();
							$('div.tooltip').css("left",thePosX);
						}
						if(topOffset<=$(window).height()){
							$('div.tooltip').css("top",smtMouseCoordsY+cursor_tip_margin_y);
						} else {
							var thePosY=smtMouseCoordsY-(cursor_tip_margin_y)-$(smtTip).height();
							$('div.tooltip').css("top",thePosY);
						}

	        });
	    }).bind('mouseout', function(){ //функция убирает подсказку если мышка не на объекте
	        $('div.tooltip').fadeOut('fast', function(){
	            $(this).remove();
        });
	    });
}


