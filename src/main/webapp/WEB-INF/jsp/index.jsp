<!DOCTYPE html>
<html lang="en">
<head>
	<title>SENHAS</title>
	<meta charset="UTF-8">
	<meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Sistema para Senhas">
        <meta name="author" content="Henrique Brandão">
        <meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <link rel="shortcut icon" href="/assets/images/avatar-1.jpg">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/login/fonts/vendor/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/login/css/util.css">
	<link rel="stylesheet" type="text/css" href="/login/css/main.css">
	<script src="assets/outros/jqueryLoader.min.js"></script>
	
	<script>
		//Loading ---------------------------------------
		jQuery(function($){
			$(".loader").fadeOut("slow"); //retire o delay quando for copiar!
		});
		// Loading ---------------------------------------
	</script>
<!--===============================================================================================-->
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
	
<body onload="iniciando()" style="background-color: #666666;">

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

<jsp:include page="pages/includes/modais/modalMensagem.jsp" />

<script>
function iniciando(){
	if('${mensagem}' != null && '${mensagem}' != ''){
		modalMensagem('${mensagem}');
	}
}


</script>

	
	<div class="limiter">
		<div class="container-login100">
			<div style="padding-top:0px" class="wrap-login100">
				<form style="padding-top:40px" class="login100-form validate-form" action="/" method="post" accept-charset="utf-8">
					<span class="login100-form-title p-b-43">
						<span class="h1">SENHAS</span><br>
						<span style="max-width:50px">
							<svg style="max-width:50px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" 	 viewBox="0 0 354.856 354.856" style="enable-background:new 0 0 354.856 354.856;" xml:space="preserve"> <g> 	<path style="fill:#333E48;" d="M307.943,199.173c16.571-15.084,26.979-36.832,26.979-61.008c0-45.55-36.925-82.474-82.474-82.474 		c-33.914,0-63.045,20.476-75.713,49.737c15.541,17.534,24.992,40.582,24.992,65.8c0,21.149-6.804,41.654-19.089,58.524 		c11.606,10.24,21.178,22.617,28.169,36.35h144.049C348.867,237.946,331.568,213.976,307.943,199.173z"/> 	<path style="fill:#61B4E4;" d="M0,299.166h204.811c-5.986-28.155-23.285-52.126-46.912-66.929 		c16.573-15.084,26.979-36.832,26.979-61.009c0-45.549-36.924-82.474-82.474-82.474c-45.545,0-82.471,36.925-82.471,82.474 		c0,24.177,10.404,45.925,26.978,61.009C23.284,247.04,5.986,271.01,0,299.166z"/> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> <g> </g> </svg>
						</span>
					</span>
					
					
					<div class="wrap-input100 validate-input" data-validate = "Email inválido, exemplo: seuemail@provedor">
						<input autocomplete="off" class="input100" type="email" name="usuarioVal" required>
						<span class="focus-input100"></span>
						<span class="label-input100">Email</span>
					</div>
					
					
					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input autocomplete="off" class="input100" type="password" name="senhaVal" required>
						<span class="focus-input100"></span>
						<span class="label-input100">Password</span>
					</div>

					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<div>
							<a href="#" class="txt1">
								Esqueceu sua senha?
							</a>
						</div>
					</div>
			

					<div id="botaoEntrar" class="container-login100-form-btn">
						<button class="login100-form-btn">
							<span>Entrar</span>
						</button>
					</div>
				</form>

				<div class="login100-more" style="background-image: url('login/images/bg-01.jpg');">
				</div>
			</div>
		</div>
	</div>
	
	

	
	
<!--===============================================================================================-->
	<script src="/login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/login/vendor/bootstrap/js/popper.js"></script>
	<script src="/login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="/login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/login/js/css/main.js"></script>

</body>
</html>