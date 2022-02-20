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
	        var quantidadeSenhas = ${listaTicketsGeral.size()};
	        var anterior = "${anterior}";
	        const tickets = [];
	        
        	function iniciando(){
        		
        		
        	}
        
			//Loading ---------------------------------------
			jQuery(function($){
				$(".loader").fadeOut("slow"); //retire o delay quando for copiar!
			});
			// Loading ---------------------------------------
			
			function add(prioridade){
				quantidadeSenhas++;
				document.getElementById("mensagem").style.display = "block";
				if(prioridade == 'sim'){
					tickets.push("P"+quantidadeSenhas);
					getPedirSenha("P"+quantidadeSenhas, prioridade);	
				} else{
					tickets.push("C"+quantidadeSenhas);
					getPedirSenha("C"+quantidadeSenhas, prioridade);
				}
			}
			
//AJAX ---------------------------------
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
//AJAX ---------------------------------

// Pedir Senha ------------------------------------------------------------------------------------
var requisicoesPedirSenha = 0;
function getPedirSenha(senha, prioridade) {
	if(requisicoesPedirSenha == 0){
		createRequest();
		var url = "/pedirSenha_{"+senha+"}_{"+prioridade+"}";
		request.open("GET", url, true);
		request.onreadystatechange = atualizaPaginaPedirSenha;
		request.send(null);
		requisicoesPedirSenha = 1;
	}
}
function atualizaPaginaPedirSenha() {
	if (request.readyState == 4) {
		var respostaDoServidor = request.responseText;
		json_PedirSenha(respostaDoServidor);
	}
}

function json_PedirSenha(json) {
	var result = json;
	var senha = result;
	requisicoesPedirSenha = 0;
	document.getElementById("folha_codigo").innerHTML = senha;
	document.getElementById("folha_data").innerHTML = dataAtualFormatada();
	document.getElementById("folha_hora").innerHTML = horaAtualFormatada();
	document.getElementById("mensagem").style.display = "none";
	imprimindo()
}

// Pedir Senha ------------------------------------------------------------------------------------

function imprimindo(){
	var divContents = document.getElementById("folha").innerHTML;
	var windowWidth = window.innerWidth;
	var windowHeight = window.innerHeight;
	var printWindow = window.open('', '', 'height='+windowHeight+',width='+windowWidth);
	printWindow.document.write('<html><head><title>IMPRIMIR</title>'); //henrique
	printWindow.document.write('</head><body >');
	printWindow.document.write(divContents);
	printWindow.document.write('</body></html>');
	printWindow.document.close();
	setTimeout(() => { printWindow.print(); }, 1000);
}
			
function dataAtualFormatada(){
    var data = new Date(),
        dia  = data.getDate().toString(),
        diaF = (dia.length == 1) ? '0'+dia : dia,
        mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
        mesF = (mes.length == 1) ? '0'+mes : mes,
        anoF = data.getFullYear();
    return diaF+"/"+mesF+"/"+anoF;
}
function horaAtualFormatada(){
    var data = new Date(),
        hora  = data.getHours(),
        min = data.getMinutes(),
        seg  = data.getSeconds();
    return hora+":"+min+":"+seg;
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
	
    
    
    <body class="fixed-center" onload="iniciando()" style="cursor:default">
    
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
		




<div class="content">
                    <div class="container">
                        <!-- Page-Title -->
                        <div class="row">
                        	<div class="col-md-12 col-lg-12"  style="cursor:default; padding:10px; position:absolute; top:20%;">
                                <div>
                                    <div class="text-center">
                                        <img src="/assets/images/avatar-1.webp" onerror="this.src='/assets/images/avatar-1.jpg" style="max-width:100px" />
                                        <br><br>
                                        <h1 class="text-white"><b class="counter">Clique abaixo para gerar a senha.</b></h1>
                                        <br><br>
                                        <input type="button" style="min-width:80%; min-height:50px" class="btn btn-primary" onclick="add('nao')" value="COMUM" />
                                        <br><br><br><br>
                                        <input type="button" style="min-width:80%; min-height:50px" class="btn btn-success" onclick="add('sim')" value="PRIORIDADE" />
                                        
                                    	<br>
                                    	<span id="mensagem" style="display:none">
	                                    	<span class="h1 text-white"><b class="counter">Imprimindo...</b></span><br>
	                                    	<span class='fa fa-spinner fa-spin fa-2x' style="color:white"></span>
                                    	</span>
                                    	<table id="folha" class="text-left" style="display:none">
                                    		<tr>
                                    		<td colspan="2" class="text-center" ><b><span id="folha_codigo">0000</span></b><br>
                                    		<tr>
                                    		<td><b>Data: </b><span id="folha_data">00/00/0000</span></b><br>
                                    		<tr>
                                    		<td><b>Horário: <span id="folha_hora">00:00:00</span></b><br>
                                    		<tr>
                                    		<td><br>Aguarde.<br>
                                    		<td>----------------------<br>
                                    	</table>
                                    </div>
                                    <div class="clearfix"></div>
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