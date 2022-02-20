<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<!-- HEADER -->
<!-- TAGS -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- TAGS -->
<!-- INICIO BODY -->

<!-- DOWNLOAD EXCEL -->
<jsp:include page="includes/jquery/excel/downloadExcel.jsp" />
<!-- DOWNLOAD EXCEL -->


<script>
function redirecionar(site){
	window.location.href=site;
}
function fMasc(objeto,mascara) {
	obj=objeto
	masc=mascara
	setTimeout("fMascEx()",1)
}
function fMascEx() {
	obj.value=masc(obj.value)
}
function mTel(tel) {
	tel=tel.replace(/\D/g,"")
	tel=tel.replace(/^(\d)/,"($1")
	tel=tel.replace(/(.{3})(\d)/,"$1)$2")
	if(tel.length == 9) {
		tel=tel.replace(/(.{1})$/,"-$1")
	} else if (tel.length == 10) {
		tel=tel.replace(/(.{2})$/,"-$1")
	} else if (tel.length == 11) {
		tel=tel.replace(/(.{3})$/,"-$1")
	} else if (tel.length == 12) {
		tel=tel.replace(/(.{4})$/,"-$1")
	} else if (tel.length > 12) {
		tel=tel.replace(/(.{4})$/,"-$1")
	}
	return tel;
}
function mCNPJ(cnpj){
	cnpj=cnpj.replace(/\D/g,"")
	cnpj=cnpj.replace(/^(\d{2})(\d)/,"$1.$2")
	cnpj=cnpj.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3")
	cnpj=cnpj.replace(/\.(\d{3})(\d)/,".$1/$2")
	cnpj=cnpj.replace(/(\d{4})(\d)/,"$1-$2")
	return cnpj
}
function mCPF(cpf){
	cpf=cpf.replace(/\D/g,"")
	cpf=cpf.replace(/(\d{3})(\d)/,"$1.$2")
	cpf=cpf.replace(/(\d{3})(\d)/,"$1.$2")
	cpf=cpf.replace(/(\d{3})(\d{1,2})$/,"$1-$2")
	return cpf
}
function mCEP(cep){
	cep=cep.replace(/\D/g,"")
	cep=cep.replace(/^(\d{5})(\d)/,"$1-$2")
	return cep
}
function mNum(num){
	num=num.replace(/\D/g,"")
	return num
}
function acao(valor){
	document.getElementById("acao").value = valor;
}
function cancelar(){
	document.getElementById("matricula").value = ${matriculaPadrao };
	document.getElementById("nome").value = '';
	document.getElementById("cpf").value = '';
	document.getElementById("dataNascimento").value = '';
	document.getElementById("telefone").value = '';
	document.getElementById("celular").value = '';
	document.getElementById("email").value = '';
	document.getElementById("endereco").value = '';
	document.getElementById("bairro").value = '';
	document.getElementById("cidade").value = '';
	document.getElementById("estado").value = '';
	document.getElementById("cep").value = '';
	document.getElementById("pathImagem").value = '';
	document.getElementById("perfil").value = 0;
	document.getElementById("grupo").value = 0;
	document.getElementById("acao").value = '';
	document.getElementById("atualizar").style.display = "none";
	document.getElementById("salvar").style.display = "block";
	document.getElementById("cancelar").style.display = "none";
}
function editar(id){
	document.getElementById("acao").value = 'atualizar';
	document.getElementById("atualizar").style.display = "block";
	document.getElementById("salvar").style.display = "none";
	document.getElementById("cancelar").style.display = "block";
	
	var inicio = 'x';
	var fim = 'x';
	<c:forEach items="${usuarios }" var="u" varStatus="s">
		if(${u.id} == id){
			document.getElementById("matricula").value = '${u.matricula}';
			document.getElementById("nome").value = '${u.nome}';
			document.getElementById("cpf").value = '${u.cpf}';
			document.getElementById("dataNascimento").value = '${u.dataNascimento}';
			document.getElementById("telefone").value = '${u.telefone}';
			document.getElementById("celular").value = '${u.celular}';
			document.getElementById("email").value = '${u.email}';
			document.getElementById("endereco").value = '${u.endereco}';
			document.getElementById("bairro").value = '${u.bairro}';
			document.getElementById("cidade").value = '${u.cidade}';
			document.getElementById("estado").value = '${u.estado}';
			document.getElementById("cep").value = '${u.cep}';
			document.getElementById("pathImagem").value = '${u.pathImagem}';
			document.getElementById("perfil").value = ${u.perfil.codigo};
		}
	</c:forEach>
		
}
</script>


<!-- start: page -->
<div class="row">
<form action="/meu_registro" method="post" accept-charset="utf-8">
	<div class="col-md-12">
		<div data-collapsed="0" class="panel">
			<div class="panel-heading">
				<div class="panel-title">
					<div class="panel-actions">
						<a href="#" class="panel-action panel-action-toggle" data-panel-toggle></a>
						<a href="#" class="panel-action panel-action-dismiss" data-panel-dismiss></a>
					</div>
					<h2 class="panel-title" id="">Meu Registro </h2>
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-3 form-group">
						<input type="text" placeholder="Login" name="matricula" id="matricula" class="form-control" value="${usuarioSessao.matricula }" readonly>
					</div>
					<div class="col-md-4 form-group">
						<input type="text" placeholder="Nome" name="nome" id="nome" class="form-control" value="${usuarioSessao.nome }" required>
					</div>
					<div class="col-md-2 form-group">
						<input type="text" id="cpf" name="cpf" maxlength="14" placeholder="CPF" minlength="14" value="${usuarioSessao.cpf }" onkeydown="javascript: fMasc( this, mCPF );" class="form-control" required>
					</div>
					<div class="col-md-3 form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-birthday-cake"></i>
							</span>
							<input type="date" name="dataNascimento" id="dataNascimento" class="form-control" value="${usuarioSessao.dataNascimento }" />
						</div>
					</div>
					<div class="col-md-4 form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-phone"></i>
							</span>
							<input type="text" id="telefone" name="telefone" placeholder="Telefone" maxlength="14" minlength="13" onkeydown="javascript: fMasc( this, mTel );" value="${usuarioSessao.telefone }" class="form-control" >
						</div>
					</div>
					<div class="col-md-4 form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-phone"></i>
							</span>
							<input type="text" id="celular" name="celular" placeholder="Celular" maxlength="14" minlength="14" onkeydown="javascript: fMasc( this, mTel );" value="${usuarioSessao.celular }" class="form-control" >
						</div>
					</div>
					<div class="col-md-4 form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-envelope"></i>
							</span>
							<input type="email" name="email" id="email" class="form-control" value="${usuarioSessao.email }" placeholder="eg.: email@email.com" />
						</div>
					</div>
					<div class="col-md-4 form-group">
						<input type="text" placeholder="Endereço" id="endereco" name="endereco" value="${usuarioSessao.endereco }" class="form-control">
					</div>
					<div class="col-md-3 form-group">
						<input type="text" placeholder="Bairro" id="bairro" name="bairro" value="${usuarioSessao.bairro }" class="form-control">
					</div>
					<div class="col-md-3 form-group">
						<input type="text" placeholder="Cidade" id="cidade" name="cidade" value="${usuarioSessao.cidade }" class="form-control">
					</div>
					<div class="col-md-2 form-group">
						<input type="text" placeholder="Estado" id="estado" maxlength="2" minlength="2" value="${usuarioSessao.estado }" name="estado" class="form-control">
					</div>
					<div class="col-md-2 form-group">
						<input type="text" id="cep" name="cep" placeholder="99999-999" maxlength="9" minlength="9" value="${usuarioSessao.cep }" onkeydown="javascript: fMasc( this, mCEP );" class="form-control" >
					</div>
					<div class="col-md-7 form-group">
						<input type="text" placeholder="Link da Foto" id="pathImagem" name="pathImagem" value="${usuarioSessao.pathImagem }" class="form-control">
					</div>
					
					<c:if test="${usuarioSessao.perfil.funcionario }" >
						<div class="col-md-3 form-group">
							<select id="perfil" name="perfil_codigo" class="form-control">
								<option value="${usuarioSessao.perfil.codigo }">${usuarioSessao.perfil.nome }</option>
							</select>
						</div>
					</c:if>
					
					<div class="col-md-4 form-group">
						<label>MESA:</label>
						<input type="text" placeholder="Mesa / Balcão. Exemplo: 001" id="mesa" name="mesa" value="${usuarioSessao.mesa }" class="form-control">
					</div>
					
					
					<div class="col-md-2 form-group" id="atualizar" >
						<label>&nbsp</label><br>
						<input type="submit" class="btn btn-primary" onclick="acao('atualizar')" value="Atualizar">
					</div>
					<input type="hidden" id="acao" name="acao" value="atualizar">
				</div>
			</div>
		</div>
	</div>
</form>


	

</div>















<!-- end: page -->
	</section>
</div>







<!-- FIM BODY -->
</div>
<!-- FIM BODY -->
<!-- MAIN NO HEADER -->
</main>
<!-- HEADER -->
<jsp:include page="includes/footer.jsp" />
<!-- HEADER -->