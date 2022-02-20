<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Sistema para Senhas">
        <meta name="author" content="Henrique Brandão">
        <meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <link rel="shortcut icon" href="/assets/images/avatar-1.jpg">
        <title>SENHAS</title>
        <!--calendar css-->
        <link href="/assets/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet" />
        <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/core.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/components.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/pages.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/responsive.css" rel="stylesheet" type="text/css" />
        
        <!-- SELECT2 -->
        <link href="/assets/plugins/bootstrap-tagsinput/css/bootstrap-tagsinput.css" rel="stylesheet" />
        <link href="/assets/plugins/switchery/css/switchery.min.css" rel="stylesheet" />
        <link href="/assets/plugins/multiselect/css/multi-select.css"  rel="stylesheet" type="text/css" />
        <link href="/assets/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" />
        <link href="/assets/plugins/bootstrap-touchspin/css/jquery.bootstrap-touchspin.min.css" rel="stylesheet" />
        <!-- SELECT2 -->
        <!-- TIMER -->
        <link href="/assets/plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet">
		<link href="/assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
		<link href="/assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet">
		<link href="/assets/plugins/clockpicker/css/bootstrap-clockpicker.min.css" rel="stylesheet">
		<link href="/assets/plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
		<!-- TIMER -->
		<link rel="shortcut icon" href="/assets/images/avatar-1.jpg">
		<script src="assets/outros/jqueryLoader.min.js"></script>
        <script src="/assets/js/modernizr.min.js"></script>
        
        <script>
			//Loading ---------------------------------------
			jQuery(function($){
				$(".loader").fadeOut("slow"); //retire o delay quando for copiar!
			});
			// Loading ---------------------------------------
			
			var quantidadeSenhas = ${listaPainel.size()};
			var anterior = "-";
			var tickets_ajax = [];
			var update = '';
			var updateAnterior = '';
			var apitar = false;
			var codigoAnterior = '-';
			var codigoAtual = '-';
			var primeiraChamada = 0;
			
			window.onload = function () {
				refresh();
				setInterval(refresh, 1000);
			}
			
			function refresh(){
				atualizar();
				getAtualizarTela()
			}
			
			
			
			function atualizar(){
				document.getElementById("anteriorPainel").innerHTML = anterior;
				codigoAnterior = codigoAtual;
				if(tickets_ajax[0] != null){
					if(tickets_ajax[0].atendente != null && tickets_ajax[0].codigo != '-' && tickets_ajax[0].codigo != ''){
						document.getElementById("codigo").innerHTML = tickets_ajax[0].codigo;
						document.getElementById("mesa").innerHTML = tickets_ajax[0].atendente.mesa;
					} else{
						document.getElementById("codigo").innerHTML = '-';
						document.getElementById("mesa").innerHTML = '-';
					}
					codigoAtual = document.getElementById("codigo").innerHTML;
					document.getElementById("guiche").innerHTML = '<span style="color:#A9E2F3"><b class="h1 counter"><span>GUICHÊ</span></b></span>';
					
					if(tickets_ajax[0].tipoPrioridade){
						document.getElementById("tipoPrioridade").innerHTML = '<span class="h1" style="color:#A9E2F3; "><b class="counter">CONVENCIONAL</b></span>';	
					} else{
						document.getElementById("tipoPrioridade").innerHTML = '<span class="h1" style="color:#A9E2F3; "><b class="counter">PRIORIDADE</b></span>';
					}
					
					
				} else{
					document.getElementById("codigo").innerHTML = '-';
					document.getElementById("mesa").innerHTML = '-';
				}
				
				
				
				if(tickets_ajax[1] != null){
					document.getElementById("proxima").innerHTML = tickets_ajax[1].codigo;
				} else{
					document.getElementById("proxima").innerHTML = '-';
				}
			}
			
			
			
			
			// AJAX ------------------------------------------------------------------------------------
			// Requisicao no AJAX ------------------------------------------------------------------------------------
			var request = null;
			  function createRequest() {
			    try {
			      request = new XMLHttpRequest();
			    } catch (trymicrosoft) {
			      try {
			        request = new ActiveXObject("Msxml2.XMLHTTP");
			      } catch (othermicrosoft) {
			        try {
			          request = new ActiveXObject("Microsoft.XMLHTTP");
			        } catch (failed) {
			          request = null;
			        }
			      }
			    }
			    if (request == null)
			      alert("Erro na requisição.");
			  }
			//Requisicao no AJAX ------------------------------------------------------------------------------------
			
			
			// ÚLTIMA ATUALIZAÇÃO ------------------------------------------------------------------------------------
			var requisicoesAtualizarTela = 0;
			function getAtualizarTela() {
				if(requisicoesAtualizarTela == 0){
					createRequest();
					var url = "/atualizaTelaPainel";
					request.open("GET", url, true);
					request.onreadystatechange = atualizaPaginaAtualizarTela;
					request.send(null);
					requisicoesAtualizarTela = 1;
				}
			}
			function atualizaPaginaAtualizarTela() {
				if (request.readyState == 4) {
					var respostaDoServidor = request.responseText;
					json_AtualizarTela(respostaDoServidor);
				}
			}
			function json_AtualizarTela(json) {
				var result = JSON.parse(json);
				var objeto = {};
				for (var i = 0, emp; i < result.labels.length; i++) {
				   emp = result.labels[i];
				   objeto[ emp.descricao ] = emp;
				   try { 
					   var listaPainel_ajax = objeto[emp.descricao].listaPainel;
					   anterior = objeto[emp.descricao].anteriorPainel;
					   tickets_ajax = [];
					   tickets_ajax = listaPainel_ajax;
					   updateAnterior = update;
					   update = objeto[emp.descricao].update;
				   } catch(err){
					   console.log('Erro: '+err);
				   }
				   
				}
				if(update != updateAnterior){
					apitar_maquina();
					getDesligarApito();
				}
				requisicoesAtualizarTela = 0;
			}
			//ÚLTIMA ATUALIZAÇÃO ------------------------------------------------------------------------------------

			
			// DESLIGAR APITO ------------------------------------------------------------------------------------
			var requisicoesDesligarApito = 0;
			function getDesligarApito() {
				if(requisicoesDesligarApito == 0){
					createRequest();
					var url = "/desligar_apito";
					request.open("GET", url, true);
					request.onreadystatechange = atualizaPaginaDesligarApito;
					request.send(null);
					requisicoesDesligarApito = 1;
				}
			}
			function atualizaPaginaDesligarApito() {
				if (request.readyState == 4) {
					var respostaDoServidor = request.responseText;
					json_DesligarApito(respostaDoServidor);
				}
			}
			function json_DesligarApito(json) {
				var result = json;
				requisicoesDesligarApito = 0;
			}
			//DESLIGAR APITO ------------------------------------------------------------------------------------

			
			
			
		// AJAX ------------------------------------------------------------------------------------
		function apitar_maquina(){
			apitar = true;
			document.addEventListener("keydown", chamarSom);
		}
		
		function chamarSom(){
			//APITAR
			document.getElementById('myAudio').innerHTML = '<source src="/som/beep.mp3" type="audio/mpeg">';
			if( apitar && (codigoAnterior != codigoAtual || primeiraChamada == 0) ){
				primeiraChamada = 1;
				apitar = false;
				var sound = document.getElementById('myAudio');
				sound.loop = false;
				sound.play();
				sound.loop = false;
				sound.stop();
				document.getElementById('myAudio').innerHTML = '';
			}
		}
			
			
		</script>
		
    </head>
    
    <style>
    .loader {
			position: fixed;
			left: 0px;
			top: 0px;
			width: 100%;
			height: 100%;
			z-index: 9999;
			background-color: white;
		}
	
	</style>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	
    
    
    <body class="fixed-center" style="cursor:default">
    
    	<div id="loader" class="loader">
				<div class="col-sm-12 text-center" style="top:30%; color: #302010">
					<div class="col-sm-12 text-center">
						<img src="/assets/images/avatar-1.webp" onerror="this.src='/assets/images/avatar-1.jpg" style="max-width:100px" />
						<br>
						Aguarde...
						<br>
					</div>
					<div class="col-sm-12 text-center">
						<span class='fa fa-spinner fa-spin fa-2x'></span>
					</div>
				</div>
		</div>
		
<audio id="myAudio">
  <source src="/som/beep.mp3" type="audio/mpeg">
</audio>


<div class="content">
                    <div class="container" id="id_container">
                        <!-- Page-Title -->
                        <div class="row" style="cursor:default; padding:5px;" >
                        	<div class="col-md-8 col-lg-8"  style="padding:10px; border: 1px solid white ">
                                <div class="text-left" style="position:relative; padding-bottom:43px;">
                                	<span id="tipoPrioridade">
	                                	<span class="h1" style="color:#A9E2F3; "><b class="counter">CONVENCIONAL</b></span>
                                	</span>
                                </div>
                                <div class="text-center" style="position:relative; padding-bottom:0px;">
                                			<span class="h1" style="color:#A9E2F3; font-size:200px; ">
	                                			<b class="counter">
	                                				<span id="codigo">-</span>
	                                			</b>
	                                		</span>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4" style="cursor:default; padding:10px; border: 1px solid white">
                                 <div class="text-left" style="position:relative; padding-bottom:100px;">
                                 	<span id="guiche">
                                 		<span style="color:#A9E2F3"><b class="h1 counter"><span>GUICHÊ</span></b></span>
                                 	</span>
                                </div>
                                <div class="text-center" style="position:relative; padding-bottom:100px;">
                                	<h1 style="color:#A9E2F3; font-size:200px;">
                                		<b class="counter">
                                			<span id="mesa">
	                                			-
                                			</span>
                                		</b>
                                	</h1>
                                </div>
                            </div>
                            
                            
                            
                            <div class="col-md-6 col-lg-6"  style="padding:10px; border: 1px solid white ">
                                <div class="text-left" style="position:relative; padding-bottom:50px;">
                                	<h1 style="color:red" class="text-white"><b class="counter">Anterior</b></h1>
                                </div>
                                <div class="text-center" style="position:relative; padding-bottom:50px;">
                                	<h1 style="font-size:200px; color:red " class="text-white"><b>
                                		<span id="anteriorPainel">
                                			-
                                		</span>
                                	</b></h1>
                                </div>
                            </div>
                             <div class="col-md-6 col-lg-6"  style="padding:10px; border: 1px solid white ">
                                <div class="text-left" style="position:relative; padding-bottom:50px;">
                                	<h1 style="color:yellow"><b class="counter">Próxima</b></h1>
                                </div>
                                <div class="text-center" style="position:relative; padding-bottom:50px;">
                                	<h1 style="font-size:200px; color:yellow" class="text-white"><b>
                                		<span id="proxima">
	                                		-
                                		</span>
                                	</b></h1>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                    </div> <!-- container -->
                </div> <!-- content -->

<!-- end: page -->


 
    
        <script>
            var resizefunc = [];
        </script>

        <!-- jQuery  -->
        <script src="/assets/js/jquery.min.js"></script>
        <script src="/assets/js/bootstrap.min.js"></script>
        <script src="/assets/js/detect.js"></script>
        <script src="/assets/js/fastclick.js"></script>
        <script src="/assets/js/jquery.slimscroll.js"></script>
        <script src="/assets/js/jquery.blockUI.js"></script>
        <script src="/assets/js/waves.js"></script>
        <script src="/assets/js/wow.min.js"></script>
        <script src="/assets/js/jquery.nicescroll.js"></script>
        <script src="/assets/js/jquery.scrollTo.min.js"></script>


        <script src="/assets/js/jquery.core.js"></script>
        <script src="/assets/js/jquery.app.js"></script>

        <script src="/assets/plugins/jquery-ui/jquery-ui.min.js"></script>

        <!-- BEGIN PAGE SCRIPTS -->
        <script src="/assets/plugins/moment/moment.js"></script>
        <script src="/assets/plugins/fullcalendar/js/fullcalendar.min.js"></script>
        <script src="/assets/pages/jquery.fullcalendar.js"></script>

	
	</body>
</html>
<!-- FOOTER -->