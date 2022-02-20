package brandaoti.sistema.model;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class Usuario {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; //Esse número é o ID automático gerado.
	
	@Column
	private String matricula;
	
	@Column
	private String senha;
	
	@Column
	private Boolean ativo = true;
	
	@Column
	//Você pode gerar o tamanho que desejar e se for obrigatório.
	private String nome;
	
	@Column
	//Você pode gerar o tamanho que desejar e se for obrigatório.
	private String email;
	
	@Column
	private String cpf;
	
	@Column
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate dataNascimento;
	
	@Column
	private String outroResponsavel;
	
	@Column
	private String telefone;
	
	@Column
	private String celular;
	
	@Column
	private String endereco;
	
	@Column
	private String cep;
	
	@Column
	private String bairro;

	@Column
	private String cidade;
	
	@Column
	private String estado;
	
	@OneToOne
	private Perfil perfil;

	@Column
	private String pathImagem = "/assets/images/imagemUsuario.png";
	
	@Column
	private String mesa;
	
	@Column
	private Date dataDeCadastro = new Date();
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMatricula() {
		return matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public LocalDate getDataNascimento() {
		return dataNascimento;
	}

	public void setDataNascimento(LocalDate dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getCelular() {
		return celular;
	}
	
	public String getCelularSomenteNumero() {
		String cel = celular;
		cel = cel.replace("(", "").replace(")", "").replace("-", "").replace(" ", "");
		return cel;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Perfil getPerfil() {
		return perfil;
	}

	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}

	

	public String getPathImagem() {
		return pathImagem;
	}

	public void setPathImagem(String pathImagem) {
		this.pathImagem = pathImagem;
	}

	public Date getDataDeCadastro() {
		return dataDeCadastro;
	}

	public void setDataDeCadastro(Date dataDeCadastro) {
		this.dataDeCadastro = dataDeCadastro;
	}
	public String getOutroResponsavel() {
		return outroResponsavel;
	}

	public void setOutroResponsavel(String outroResponsavel) {
		this.outroResponsavel = outroResponsavel;
	}

	public String getMesa() {
		return mesa;
	}

	public void setMesa(String mesa) {
		this.mesa = mesa;
	}

	
	
	
	
	
	
	
	
}
