<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<jsp:include page="includes/modais/modalMensagem.jsp" />
<!-- HEADER -->
<!-- TAGS -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- TAGS -->
<!-- INICIO BODY -->

<script>
var quantidadeSenhas = ${listaTicketsGeral.size()};
var anterior = "${anterior}";
var tickets = [];
var tickets_ajax = [];
var prioridades_ajax = [];
var prioridades = []

window.onload = function () {
	refresh();
	setInterval(refresh, 1000);
}

function refresh(){
	getAtualizarTela()
	inicial();
	atualizar();
}


function liberarPainel(){
	var codigo = document.getElementById('codigo_atendendo').innerHTML;
	document.getElementById('msg').innerHTML = 'Em atendimento.';
	document.getElementById('bt_atender').innerHTML = '';
	getLiberarPainel(codigo)
}
function finalizar(){
	var codigo = document.getElementById('codigo_atendendo').innerHTML;
	getLiberarPainel(codigo)
	atualizar();
	document.getElementById('livre').style.display = 'block';
	document.getElementById('atendendo').style.display = 'none';
	document.getElementById('msg').innerHTML = 'Aguarde o cliente chegar para clicar em atender.';
	document.getElementById('bt_atender').innerHTML = '<input type="button" onclick="liberarPainel()" class="btn btn-success" value="ATENDER" />';
	
}
function inicial(){
	tickets = [];
	for (var i = 0; i < tickets_ajax.length; i++) {
		var codigo = tickets_ajax[i].codigo + '';
		tickets.push(codigo);
	}
	
	prioridades = [];
	for (var i = 0; i < prioridades_ajax.length; i++) {
		var codigo = prioridades_ajax[i].codigo + '';
		prioridades.push(codigo);
	}
	if(prioridades[0] != null){
		document.getElementById("prioridade").innerHTML = prioridades[0];	
	} else{
		document.getElementById("prioridade").innerHTML = "-";
	}
	
	
}
function atualizar(){
	document.getElementById("anterior").innerHTML = anterior;
	if(tickets[0] != null){
		document.getElementById("atual").innerHTML = tickets[0];
	} else{
		document.getElementById("atual").innerHTML = '-';
	}
	if(tickets[1] != null){
		document.getElementById("proximo").innerHTML = tickets[1];
	} else{
		document.getElementById("proximo").innerHTML = '-';
	}
	listarTodos();
}
function remove(){
	if(tickets[0] != null){
		getAtender(tickets[0])
		anterior = tickets[0]+"";
		tickets.shift();
	} else{
		anterior = "-";
	}
	atualizar();
	document.getElementById('codigo_atendendo').innerHTML = anterior;
	document.getElementById('atendendo').style.display = 'block';
	document.getElementById('livre').style.display = 'none';
}
function removePrioridade(){
	if(prioridades[0] != null){
		getAtender(prioridades[0])
		anterior = prioridades[0]+"";
		prioridades.shift();
	} else{
		anterior = "-";
	}
	atualizar();
	document.getElementById('codigo_atendendo').innerHTML = anterior;
	document.getElementById('atendendo').style.display = 'block';
	document.getElementById('livre').style.display = 'none';
}
function add(prioridade){
	quantidadeSenhas++;
	if(prioridade == 'sim'){
		tickets.push("P"+quantidadeSenhas);
		getPedirSenha("P"+quantidadeSenhas, prioridade);	
	} else{
		tickets.push("C"+quantidadeSenhas);
		getPedirSenha("C"+quantidadeSenhas, prioridade);
	}
	atualizar();
}
function listarTodos(){
	var lista = '';
	for (var i = 0; i < tickets.length; i++) {
		if(tickets[i] != null){
			if(i > 0){
				lista = lista + '<br>' + tickets[i]
			} else{
				lista = lista + '<span style="color:#83DC63">' + tickets[i] + ' - Atual</span>'
			}
		}
	}
	document.getElementById("todos").innerHTML = lista;
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
}
// Pedir Senha ------------------------------------------------------------------------------------



// Atender ------------------------------------------------------------------------------------
var requisicoesAtender = 0;
function getAtender(senha) {
	if(requisicoesAtender == 0){
		createRequest();
		var url = "/atender_{"+senha+"}";
		request.open("GET", url, true);
		request.onreadystatechange = atualizaPaginaAtender;
		request.send(null);
		requisicoesAtender = 1;
	}
}
function atualizaPaginaAtender() {
	if (request.readyState == 4) {
		var respostaDoServidor = request.responseText;
		json_Atender(respostaDoServidor);
	}
}
function json_Atender(json) {
	var result = json;
	var anterior = result;
	requisicoesAtender = 0;
}
// Atender ------------------------------------------------------------------------------------


// Liberar Painel ------------------------------------------------------------------------------------
var requisicoesLiberarPainel = 0;
function getLiberarPainel(senha) {
	if(requisicoesLiberarPainel == 0){
		createRequest();
		var url = "/liberarPainel_{"+senha+"}";
		request.open("GET", url, true);
		request.onreadystatechange = atualizaPaginaLiberarPainel;
		request.send(null);
		requisicoesLiberarPainel = 1;
	}
}
function atualizaPaginaLiberarPainel() {
	if (request.readyState == 4) {
		var respostaDoServidor = request.responseText;
		json_LiberarPainel(respostaDoServidor);
	}
}
function json_LiberarPainel(json) {
	var result = json;
	anterior = result;
	requisicoesLiberarPainel = 0;
}
// Liberar Painel ------------------------------------------------------------------------------------


// ÚLTIMA ATUALIZAÇÃO ------------------------------------------------------------------------------------
var requisicoesAtualizarTela = 0;
function getAtualizarTela() {
	if(requisicoesAtualizarTela == 0){
		createRequest();
		var url = "/atualizaTela";
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
		   var listaTicketsGeral_ajax = objeto[emp.descricao].listaTicketsGeral;
		   anterior = objeto[emp.descricao].anterior;
		   tickets_ajax = [];
		   tickets_ajax = listaTicketsGeral_ajax;
		   //Prioridades abaixo.
		   var listaTicketsPrioridades_ajax = objeto[emp.descricao].listaTicketsPrioridade;
		   prioridades_ajax = [];
		   prioridades_ajax = listaTicketsPrioridades_ajax;
	   } catch(err){
		   console.log('Erro: '+err);
	   }
	   
	}
	
	requisicoesAtualizarTela = 0;
}
//ÚLTIMA ATUALIZAÇÃO ------------------------------------------------------------------------------------


// AJAX ------------------------------------------------------------------------------------


</script>
<!-- Script -->











<div class="content">
                    <div class="container">
                    	<div class="row" id="atendendo" style="display:none">
                        	<div class="col-12 col-md-12 col-lg-12 text-center"  style="cursor:pointer;padding-bottom:15px">
                        		<span class="h1" style="color:#E0ECF8"><span id="msg">Aguarde o cliente chegar para clicar em atender.</span><br>
                        		<span style="color:#81C868" >CÓDIGO: <span id="codigo_atendendo"></span> </span><br>
                        		<span id="bt_atender" >
                        			<input type="button" onclick="liberarPainel()" class="btn btn-success" value="ATENDER" />
                        		</span>
                        		<br><br><br>
                        		Para pular para o próximo cliente ou finalizar o atendimento, clique no botão abaixo:</span>
								<br><br><br>
								<input type="button" onclick="finalizar()" class="btn btn-danger" value="FINALIZAR ATENDIMENTO" />
	                        </div>
	                    
	                    </div>
                        <div class="row" id="livre">
                        	<div class="col-6 col-md-6 col-lg-6 text-right"  style="cursor:pointer;padding-bottom:15px">
								<input type="button" onclick="remove()" class="btn btn-success" value="ATENDER" />
	                        </div>
	                        <div class="col-6 col-md-6 col-lg-6 text-right"  style="cursor:pointer;padding-bottom:15px">
								<input type="button" onclick="removePrioridade()" class="btn btn-warning" value="ATENDER PRIORIDADE" />
	                        </div>
	                        
	                        <div class="col-md-3 col-lg-3"  style="cursor:pointer">
                                <div class="widget-bg-color-icon card-box" style="min-height:165px">
                                    <div class="bg-icon bg-icon-pink pull-left">
                                        <i class="md  md-thumb-down text-pink"></i>
                                    </div>
                                    <div class="text-right">
                                    	<h4 style="color:#FB6D9D" class="text-dark"><b class="counter" >ANTERIOR</b> </h4>
                                        <h2 style="color:#FB6D9D" class="text-muted" id="anterior">-</h2>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-3 col-lg-3"  style="cursor:pointer">
                                <div class="widget-bg-color-icon card-box" style="min-height:165px">
                                    <div class="bg-icon bg-icon-success pull-left">
                                        <i class="md  md-error text-success"></i>
                                    </div>
                                    <div class="text-center" >
                                    	<h4 style="color:#83DC63" class="text-dark"><b class="counter" >ATUAL</b> </h4>
                                        <h2 style="color:#83DC63" class="text-muted" id="atual">-</h2>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-3 col-lg-3"  style="cursor:pointer">
                                <div class="widget-bg-color-icon card-box" style="min-height:165px">
                                    <div class="bg-icon bg-icon-primary pull-left">
                                        <i class="md  md-search text-primary"></i>
                                    </div>
                                    <div class="text-right">
                                    	<h4 style="color:#5D9CEC" class="text-dark"><b class="counter" >PRÓXIMO</b> </h4>
                                        <h2 style="color:#5D9CEC" class="text-muted" id="proximo">-</h2>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-3 col-lg-3"  style="cursor:pointer">
                                <div class="widget-bg-color-icon card-box" style="min-height:165px">
                                    <div class="bg-icon bg-icon-warning pull-left">
                                        <i class="md  md-search text-warning"></i>
                                    </div>
                                    <div class="text-right">
                                    	<h4 style="color: orange" class="text-dark"><b class="counter" >PRIORIDADE</b> </h4>
                                        <h2 style="color: orange" class="text-muted" id="prioridade">-</h2>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-12 col-lg-12 text-left"  style="cursor:pointer;">
                            	<span class="h4 text-dark"><b class="counter" >FILA:</b> </span>
                                <div class="card-box" style="max-height:165px; overflow:auto;">
                                    <span class="h2 text-muted" id="todos">-</span>
                                </div>
                            </div>
                    </div>
                </div> 
</div>
                


<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->