package brandaoti.sistema.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Integer> {
	@Query(" select u from Usuario u where upper( u.email ) like upper( :email ) and upper( u.senha ) like upper( :senha ) ")
	Usuario fazerLogin(@Param("email") String email, @Param("senha") String senha);
	
	@Query(" select u from Usuario u where 1=1 and nome = '(:aluno.nome)' ")
	List<Usuario> filtro(@Param("aluno") Usuario aluno);
	
	@Query(" select u from Usuario u where 1=1 and u.perfil.cliente = TRUE and u.perfil.funcionario = FALSE and u.perfil.admin = FALSE and u.ativo = TRUE")
	List<Usuario> buscarClientes();
	
	@Query(" select u from Usuario u where 1=1 and u.perfil.funcionario = TRUE and u.ativo = TRUE")
	List<Usuario> buscarFuncionarios();
	
	@Query(" select u from Usuario u where upper( u.matricula ) like upper( :matricula ) ")
	Usuario buscarMatricula(@Param("matricula") String matricula);
	
	@Query(" select u from Usuario u where upper( u.matricula ) like upper( :matricula ) or upper( u.cpf ) like upper( :cpf ) and u.perfil.cliente = TRUE and u.ativo = TRUE")
	List<Usuario> buscarClientesRepetidos(@Param("matricula") String matricula, @Param("cpf") String cpf);
	
	@Query(" select u from Usuario u where upper( u.matricula ) like upper( :matricula ) or upper( u.cpf ) like upper( :cpf ) and u.perfil.funcionario = TRUE and u.ativo = TRUE")
	List<Usuario> buscarFuncionariosRepetidos(@Param("matricula") String matricula, @Param("cpf") String cpf);
	
	@Query(" select p from Usuario p where ativo = TRUE")
	List<Usuario> buscarTudo();
	
	@Query(" select p from Usuario p where extract(month from data_nascimento) = extract(month from sysdate) and extract(day from data_nascimento) = extract(day from sysdate) and ativo = TRUE ")
	List<Usuario> buscarAniversariantes();
	
	@Query(" select p from Usuario p where extract(month from dataDeCadastro) = extract(month from sysdate) and ativo = TRUE and YEAR(dataDeCadastro)=(YEAR(NOW())) ")
	List<Usuario> novosDoMes();
	
	@Query(" select u from Usuario u where u.cpf like (:cpf)")
	Usuario buscarCpf(@Param("cpf") String cpf);
	
	
}
