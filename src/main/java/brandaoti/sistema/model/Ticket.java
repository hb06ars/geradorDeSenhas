package brandaoti.sistema.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Ticket {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id; //Esse número é o ID automático gerado.
	
	@Column
	private Boolean livre = true;
	
	@Column
	private String codigo;
	
	@Column
	private Boolean aguardando = true;

	@Column
	private Boolean atendido = false;

	@Column
	private Boolean faltou = false;

	@Column
	private Boolean prioridade = false;

	@ManyToOne
	private Usuario atendente;

	@Column
	private LocalDateTime entrada = LocalDateTime.now();

	@Column
	private LocalDateTime saido;

	@Column
	private LocalDateTime atualizacao = LocalDateTime.now();
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getAguardando() {
		return aguardando;
	}

	public void setAguardando(Boolean aguardando) {
		this.aguardando = aguardando;
	}

	public Boolean getAtendido() {
		return atendido;
	}

	public void setAtendido(Boolean atendido) {
		this.atendido = atendido;
	}

	public Boolean getFaltou() {
		return faltou;
	}

	public void setFaltou(Boolean faltou) {
		this.faltou = faltou;
	}

	public Usuario getAtendente() {
		return atendente;
	}

	public void setAtendente(Usuario atendente) {
		this.atendente = atendente;
	}

	public LocalDateTime getEntrada() {
		return entrada;
	}

	public void setEntrada(LocalDateTime entrada) {
		this.entrada = entrada;
	}

	public LocalDateTime getSaido() {
		return saido;
	}

	public void setSaido(LocalDateTime saido) {
		this.saido = saido;
	}

	public Boolean getPrioridade() {
		return prioridade;
	}

	public void setPrioridade(Boolean prioridade) {
		this.prioridade = prioridade;
	}

	public LocalDateTime getAtualizacao() {
		return atualizacao;
	}

	public void setAtualizacao(LocalDateTime atualizacao) {
		this.atualizacao = atualizacao;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public Boolean getLivre() {
		return livre;
	}

	public void setLivre(Boolean livre) {
		this.livre = livre;
	}
	
	

	
		
	
}
