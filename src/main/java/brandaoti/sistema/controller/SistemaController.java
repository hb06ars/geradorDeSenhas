package brandaoti.sistema.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import antlr.collections.impl.LList;
import brandaoti.sistema.dao.PerfilDao;
import brandaoti.sistema.dao.TicketDao;
import brandaoti.sistema.dao.UsuarioDao;
import brandaoti.sistema.model.Perfil;
import brandaoti.sistema.model.Ticket;
import brandaoti.sistema.model.Usuario;


@RestController
@RequestMapping("/")
@CrossOrigin("*")
public class SistemaController extends HttpServlet {

		private static final long serialVersionUID = 1L;
		@Autowired
		private UsuarioDao usuarioDao;
		@Autowired
		private PerfilDao perfilDao;
		
		public static List<Ticket> listaTicketsGeral = new ArrayList<Ticket>();
		public static List<Ticket> listaPainel = new ArrayList<Ticket>();
		public static List<Ticket> listaTicketsPrioridade = new ArrayList<Ticket>();
		public static Integer quantidadeSenhas = 0;
		public static String anterior = "-";
		public static String anteriorPainel = "-";
		public static Date update = new Date();
		
		@RequestMapping(value = {"/","/index"}, produces = "text/plain;charset=UTF-8", method = RequestMethod.GET) // Pagina de Vendas
		public void login(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "nome", required = false, defaultValue = "Henrique Brandão") String nome) throws SQLException, ServletException, IOException { //Funcao e alguns valores que recebe...
			//Caso não haja registros
			HttpSession session = request.getSession();
			
			List<Usuario> u = usuarioDao.buscarTudo();
			List<Perfil> p = perfilDao.buscarTudo();
			
			if(p == null || p.size() == 0) {
				Perfil perfil = new Perfil();
				perfil.setAtivo(true);
				perfil.setCodigo("1");
				perfil.setNome("Administrador");
				perfil.setAdmin(true);
				perfil.setFuncionario(true);
				perfil.setCliente(true);
				perfilDao.save(perfil);
				
				perfil = new Perfil();
				perfil.setAtivo(true);
				perfil.setCodigo("2");
				perfil.setNome("Cliente");
				perfil.setAdmin(false);
				perfil.setFuncionario(false);
				perfil.setCliente(true);
				perfilDao.save(perfil);
				
				perfil = new Perfil();
				perfil.setAtivo(true);
				perfil.setCodigo("3");
				perfil.setNome("Funcionário");
				perfil.setAdmin(false);
				perfil.setFuncionario(true);
				perfil.setCliente(false);
				perfilDao.save(perfil);
				
			}
			
			
			
			if(u == null || u.size() == 0) {
				// Henrique
				Usuario h = new Usuario();
				h.setAtivo(true);
				h.setMatricula("adm");
				h.setCpf("22233344455");
				h.setEmail("adm@adm.com");
				h.setSenha("adm");
				h.setNome("Henrique");
				h.setTelefone("(11)98931-6271");
				h.setCelular("(11)98931-6271");
				h.setEndereco("Teste...");
				h.setCep("00000-000");
				h.setBairro("Jd da Alegria");
				h.setDataNascimento(LocalDate.now());
				h.setBairro("São Paulo");
				h.setEstado("SP");
				h.setMesa("123");
				h.setPerfil(perfilDao.buscarAdm().get(0));
				usuarioDao.save(h);
			}
			
			
			if(session.getAttribute("usuarioSessao") != null) {
				response.sendRedirect("/home");
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response); //retorna a variavel
			}
		}
		
		@RequestMapping(value = {"/","/index"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.POST}) // Pagina de Vendas
		public void index_post(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "usuarioVal", defaultValue = "") String usuarioVal, @RequestParam(value = "senhaVal", defaultValue = "") String senhaVal) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "index";
			Usuario usuarioSessao = usuarioDao.fazerLogin(usuarioVal, senhaVal);
			if(usuarioSessao != null && usuarioSessao.getId() != null) {
				session.setAttribute("usuarioSessao",usuarioSessao);
				response.sendRedirect("/home");
			} else {
				request.setAttribute("mensagem", "Usuário(a) / Senha incorreto(s).");
				request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
			}
		}
		
		@RequestMapping(value = "/deslogar", method = {RequestMethod.GET}) // Link que irÃ¡ acessar...
		public void deslogar(HttpServletRequest request, HttpServletResponse response ) throws IOException { //Funcao e alguns valores que recebe...
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect("/");
		}
		
		
		@RequestMapping(value = {"/home"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Vendas
		public void home(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "usuarioVal", defaultValue = "") String usuarioVal, @RequestParam(value = "senhaVal", defaultValue = "") String senhaVal) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "pages/deslogar";
			
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				usuarioSessao = usuarioDao.findById(usuarioSessao.getId()).get();
				request.setAttribute("anterior", anterior);
				request.setAttribute("listaTicketsGeral", listaTicketsGeral);
				request.setAttribute("listaTicketsPrioridade", listaTicketsPrioridade);
				request.setAttribute("usuarioSessao", usuarioSessao);
				link = "pages/home";
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}

		@RequestMapping(value = "/pedirSenha", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public void pedirSenhaPainel(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "pages/pedirSenha";
			request.setAttribute("anterior", anterior);
			request.setAttribute("listaTicketsGeral", listaTicketsGeral);
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		
		@RequestMapping(value = "/pedirSenha_{senha}_{prioridade}", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String pedirSenha(HttpServletRequest request, HttpServletResponse response, @PathVariable("senha") String senha, @PathVariable("prioridade") String prioridade) throws SQLException, ServletException, IOException {
			Boolean valido = true;
			senha = senha.replace("{", "").replace("}", "");
			prioridade = prioridade.replace("{", "").replace("}", "");
			if(prioridade.equals("sim")) {
				senha = senha.replace("C", "P");
			}
			
			for(Ticket l: listaTicketsGeral) {
				if(l.getCodigo().equals(senha)) {
					valido = false;
					break;
				}
			}
			if(valido) {
				Ticket t = new Ticket();
				t.setAguardando(true);
				t.setCodigo(senha);
				if(prioridade.equals("sim")) {
					t.setPrioridade(true);
					listaTicketsPrioridade.add(t);
				} else {
					t.setPrioridade(false);
				}
				listaTicketsGeral.add(t);
			}
			return senha;
		}
		/*
		@RequestMapping(value = "/solicitar_{tipo}", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String solicitar(HttpServletRequest request, HttpServletResponse response,@PathVariable("tipo") String tipo) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			tipo = tipo.replace("{", "").replace("}", "").replace("'", "");
			String codigo = "";
			Ticket tcAdd = new Ticket();
			if(tipo.equals("comum")) {
				for(Ticket tc: listaTicketsGeral) {
					if(!tc.getPrioridade() && tc.getLivre()) {
						tc.setPrioridade(false);
						tc.setEntrada(LocalDateTime.now());
						tc.setAguardando(true);
						tc.setAtendido(false);
						tc.setAtualizacao(LocalDateTime.now());
						tc.setFaltou(false);
						tc.setLivre(false);
						tc.setSaido(null);
						tcAdd = tc;
						codigo = tc.getCodigo()+"#"+tc.getEntrada();
						break;
					}
				} 
			} else {
				for(Ticket tc: listaTicketsGeral) {
					if(tc.getPrioridade() && tc.getLivre()) {
						tc.setPrioridade(true);
						tc.setEntrada(LocalDateTime.now());
						tc.setAguardando(true);
						tc.setAtendido(false);
						tc.setAtualizacao(LocalDateTime.now());
						tc.setFaltou(false);
						tc.setLivre(false);
						tc.setSaido(null);
						tcAdd = tc;
						codigo = tc.getCodigo()+"#"+tc.getEntrada();
						break;
					}
				} 
			}
			System.out.println(""+codigo);
			listaTicketsGeral.add(tcAdd);
			return codigo;
		}
		*/
		
		@RequestMapping(value = {"/painel"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public void painel(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			HttpSession session = request.getSession();
			String link = "pages/painel";
			request.setAttribute("anterior", anterior);
			request.setAttribute("anteriorPainel", anteriorPainel);
			request.setAttribute("listaTicketsGeral", listaTicketsGeral);
			request.setAttribute("listaPainel", listaPainel);
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		
		@RequestMapping(value = "/deletando", method = {RequestMethod.POST})
		public void deletando(HttpServletRequest request, HttpServletResponse response, String tabela,Integer id) throws ServletException, IOException { //Função e alguns valores que recebe...
			String link = "pages/deslogar";
			HttpSession session = request.getSession();
			Usuario usuarioSessao = new Usuario();
			if(session.getAttribute("usuarioSessao") != null) {
				usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				//Caso esteja logado.
				if(usuarioSessao.getPerfil().getFuncionario()) {
					if(tabela.equals("usuario") && usuarioSessao.getPerfil().getAdmin() ) {
						link = "pages/clientes";
						Usuario objeto = usuarioDao.findById(id).get();
						usuarioDao.delete(objeto);
						List<Usuario> usuarios = usuarioDao.buscarTudo();
						request.setAttribute("usuarios", usuarios);
					}
					if(tabela.equals("funcionario")  && usuarioSessao.getPerfil().getAdmin() ) {
						link = "pages/funcionarios";
						Usuario objeto = usuarioDao.findById(id).get();
						objeto.setAtivo(false);
						usuarioDao.save(objeto);
						List<Usuario> usuarios = usuarioDao.buscarFuncionarios();
						request.setAttribute("usuarios", usuarios);
					}
				}
			}
			request.setAttribute("usuario", usuarioSessao);
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
		}
		
		
		
		
		@RequestMapping(value = "/funcionarios", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET,RequestMethod.POST}) // Pagina de Vendas
		public void funcionarios(HttpServletRequest request, HttpServletResponse response, Usuario funcionario, String acao, String perfil_codigo, String grupo_codigo) throws SQLException, ServletException, IOException {
			String link = "pages/deslogar";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				link = "pages/funcionarios";
				//Gerando matrícula aleatória
				Boolean repetido = false;
				if(usuarioDao.buscarFuncionariosRepetidos(funcionario.getMatricula(), funcionario.getCpf()).size() > 0) {
					repetido = true;
				}
				if(funcionario.getMatricula() != null && (acao.equals("salvar")) && !repetido) {
					try {
						Usuario a = new Usuario();
						a = funcionario;
						a.setSenha(funcionario.getCpf().replace(".", "").replace("-", ""));
						if(usuarioSessao.getPerfil().getAdmin()) {
							a.setPerfil(perfilDao.buscarCodigo(perfil_codigo));
						} else {
							a.setPerfil(perfilDao.buscarFuncionario().get(0));
						}
						usuarioDao.save(a);
						String msg = "Solicitação confirmada com sucesso!";
						request.setAttribute("mensagem", msg);
						request.setAttribute("tipoMensagem", "info");
					} catch(Exception e) {
						request.setAttribute("erro", e);
						System.out.println("Erro: "+e);
					}
				} else if (funcionario.getMatricula() != null && (acao.equals("atualizar")) && repetido){
					Usuario a = usuarioDao.buscarMatricula(funcionario.getMatricula());
					a.setNome(funcionario.getNome());
					a.setDataNascimento(funcionario.getDataNascimento());
					a.setTelefone(funcionario.getTelefone());
					a.setCelular(funcionario.getCelular());
					a.setEndereco(funcionario.getEndereco());
					a.setEmail(funcionario.getEmail());
					a.setPathImagem(funcionario.getPathImagem());
					a.setCep(funcionario.getCep());
					a.setBairro(funcionario.getBairro());
					a.setCidade(funcionario.getCidade());
					a.setEstado(funcionario.getEstado());
					a.setMesa(funcionario.getMesa());
					a.setPerfil(perfilDao.buscarCodigo(perfil_codigo));
					usuarioDao.save(a);
					String msg = "Atualização confirmada com sucesso!";
					request.setAttribute("mensagem", msg);
					request.setAttribute("tipoMensagem", "info");
				} else if(funcionario.getMatricula() != null && (acao.equals("salvar")) && repetido) {
					request.setAttribute("mensagem", "Já existe este CPF / Matrícula.");
					request.setAttribute("tipoMensagem", "erro");    
				}
				List<Usuario> usuarios = usuarioDao.buscarFuncionarios();
				request.setAttribute("usuarios", usuarios);
				
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		
		
		
		@RequestMapping(value = "/alterarSenha", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET,RequestMethod.POST}) // Pagina de Vendas
		public void alterarSenha(HttpServletRequest request, HttpServletResponse response, Integer acao, String matricula,String senha,String novaSenha,String confirmaSenha) throws SQLException, ServletException, IOException {
			String link = "pages/deslogar";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				usuarioSessao = usuarioDao.findById(usuarioSessao.getId()).get();
				request.setAttribute("usuarioSessao", usuarioSessao);
				link = "pages/alterarSenha";
				String msg = "";
				if(acao != null) {
					if(acao > 0) {
						Usuario u = usuarioDao.fazerLogin(matricula, senha);
						if(u != null && (novaSenha.equals(confirmaSenha)) ) {
							u.setSenha(novaSenha);
							usuarioDao.save(u);
							msg = "Senha alterada com sucesso!";
							request.setAttribute("mensagem", msg);
							request.setAttribute("tipoMensagem", "info");
						} else {
							msg = "Usuário / Senha inválida!";
							request.setAttribute("mensagem", msg);
							request.setAttribute("tipoMensagem", "erro");
						}
					}
				}
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		
		
		
		
		
		@RequestMapping(value = "/meu_registro", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET,RequestMethod.POST}) // Pagina de Vendas
		public void meu_registro(HttpServletRequest request, HttpServletResponse response, Usuario funcionario, String acao, String perfil_codigo, String grupo_codigo) throws SQLException, ServletException, IOException {
			String link = "pages/deslogar";
			HttpSession session = request.getSession();
			if(session.getAttribute("usuarioSessao") != null) {
				Usuario usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
				usuarioSessao = usuarioDao.findById(usuarioSessao.getId()).get();
				request.setAttribute("usuarioSessao", usuarioSessao);
				link = "pages/meu_registro";
				//Gerando matrícula aleatória
				
				Boolean repetido = false;
				if(usuarioDao.buscarFuncionariosRepetidos(funcionario.getMatricula(), funcionario.getCpf()).size() > 0) {
					repetido = true;
				}
				if(funcionario.getMatricula() != null && (acao.equals("salvar")) && !repetido) {
					try {
						Usuario a = new Usuario();
						a = funcionario;
						a.setSenha(funcionario.getCpf().replace(".", "").replace("-", ""));
						if(usuarioSessao.getPerfil().getAdmin()) {
							a.setPerfil(perfilDao.buscarCodigo(perfil_codigo));
						} else {
							a.setPerfil(perfilDao.buscarFuncionario().get(0));
						}
						usuarioDao.save(a);
						String msg = "Solicitação confirmada com sucesso!";
						request.setAttribute("mensagem", msg);
						request.setAttribute("tipoMensagem", "info");
					} catch(Exception e) {
						request.setAttribute("erro", e);
						System.out.println("Erro: "+e);
					}
				} else if (funcionario.getMatricula() != null && (acao.equals("atualizar")) && repetido){
					Usuario a = usuarioDao.findById(usuarioSessao.getId()).get();
					a.setNome(funcionario.getNome());
					a.setDataNascimento(funcionario.getDataNascimento());
					a.setTelefone(funcionario.getTelefone());
					a.setCelular(funcionario.getCelular());
					a.setEndereco(funcionario.getEndereco());
					a.setEmail(funcionario.getEmail());
					a.setPathImagem(funcionario.getPathImagem());
					a.setCep(funcionario.getCep());
					a.setBairro(funcionario.getBairro());
					a.setCidade(funcionario.getCidade());
					a.setEstado(funcionario.getEstado());
					a.setMesa(funcionario.getMesa());
					a.setOutroResponsavel(funcionario.getOutroResponsavel());
					a.setPerfil(perfilDao.buscarCodigo(perfil_codigo));
					usuarioDao.save(a);
					String msg = "Atualização confirmada com sucesso!";
					request.setAttribute("mensagem", msg);
					request.setAttribute("tipoMensagem", "info");
				} else if(funcionario.getMatricula() != null && (acao.equals("salvar")) && repetido) {
					request.setAttribute("mensagem", "Já existe este CPF / Matrícula.");
					request.setAttribute("tipoMensagem", "erro");    
				}
				List<Usuario> usuarios = usuarioDao.buscarFuncionarios();
				request.setAttribute("usuarios", usuarios);
				
				
				
			}
			request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
		}
		
		
		
		@RequestMapping(value = "/liberarPainel_{senha}", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String liberarPainel(HttpServletRequest request, HttpServletResponse response, @PathVariable("senha") String senha) throws SQLException, ServletException, IOException {
			senha = senha.replace("{", "").replace("}", "");
			Ticket ticketLiberar = new Ticket();
			Boolean encontrou = false;
			for(Ticket l: listaPainel) {
				if(l.getCodigo().equals(senha)) {
					ticketLiberar = l;
					encontrou = true;
					break;
				}
			}
			if(encontrou) {
				anteriorPainel = ticketLiberar.getCodigo();
				listaPainel.remove(ticketLiberar);
				listaTicketsGeral.remove(ticketLiberar);
				listaTicketsPrioridade.remove(ticketLiberar);
				System.out.println("Liberar Painel: "+ticketLiberar.getCodigo());
			}
			return anteriorPainel;
		}
		
		
		@RequestMapping(value = "/atender_{senha}", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String atender(HttpServletRequest request, HttpServletResponse response, @PathVariable("senha") String senha) throws SQLException, ServletException, IOException {
			senha = senha.replace("{", "").replace("}", "");
			for(Ticket l: listaTicketsGeral) {
				if(l.getCodigo().equals(senha) && !l.getAtendido() && l.getAtendente() == null) {
					HttpSession session = request.getSession();
					Usuario u = (Usuario) session.getAttribute("usuarioSessao");
					l.setAtendente(u);
					listaPainel.add(l);
					listaTicketsGeral.remove(l);
					listaTicketsPrioridade.remove(l);
					anterior = l.getCodigo();
					update = new Date();
					break;
				}
			}
			System.out.println("Anterior: "+anterior);
			return anterior;
		}
		
		
		@RequestMapping(value = "/zerar", produces = "text/plain;charset=UTF-8", method = RequestMethod.GET) // Pagina de Vendas
		public void zerar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			listaTicketsGeral.clear();
			listaTicketsPrioridade.clear();
			listaPainel.clear();
			quantidadeSenhas = 0;
			anterior = "-";
			anteriorPainel = "-";
			update = new Date();
			response.sendRedirect("/home");
		}
		
		@RequestMapping(value = {"/atualizaTela"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String atualizaTela (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			String retorno = "";
			JSONObject jsonObj = new JSONObject();
			try {
				JSONObject objeto = new JSONObject();
				objeto = new JSONObject();
				objeto.put("anterior", anterior);
				objeto.put("listaTicketsGeral", listaTicketsGeral);
				objeto.put("listaTicketsPrioridade", listaTicketsPrioridade);
				objeto.put("anteriorPainel", anteriorPainel);
				jsonObj.append("labels", objeto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			retorno = ""+jsonObj;
			return retorno;
		}
		
		
		
		@RequestMapping(value = {"/atualizaTelaPainel"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String atualizaTelaPainel (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			String retorno = "";
			JSONObject jsonObj = new JSONObject();
			try {
				JSONObject objeto = new JSONObject();
				objeto = new JSONObject();
				objeto.put("listaPainel", listaPainel);
				objeto.put("anteriorPainel", anteriorPainel);
				objeto.put("update", update);
				jsonObj.append("labels", objeto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			retorno = ""+jsonObj;
			return retorno;
		}
		
		
		@RequestMapping(value = {"/desligar_apito"}, produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET}) // Pagina de Vendas
		public String desligar_apito (HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
			update = new Date();
			return update+"";
		}
		
				
}
	
	
	




