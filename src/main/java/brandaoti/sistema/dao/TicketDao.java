package brandaoti.sistema.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import brandaoti.sistema.model.Ticket;

public interface TicketDao extends JpaRepository<Ticket, Integer> {
	
	@Query(" select t from Ticket t where aguardando = 1 and livre = 0  order by t.id asc ")
	List<Ticket> buscar_aguardando();
	
	@Query(" select t from Ticket t where atendido = 1 and livre = 0  order by t.atualizacao desc ")
	List<Ticket> buscar_atendido();
	
	@Query(" select t from Ticket t where faltou = 1 and livre = 0  order by t.atualizacao desc ")
	List<Ticket> buscar_faltou();
	
	@Query(" select t from Ticket t where prioridade = 1 and livre = 0 order by t.atualizacao desc ")
	List<Ticket> buscar_prioridade();

	@Query(" select t from Ticket t where livre = 1 order by t.id asc ")
	List<Ticket> buscar_livre();
	
	@Query(" select t from Ticket t where livre = 1 and prioridade = 1 order by t.id asc ")
	List<Ticket> buscar_livre_prioridade();
	
	
}



