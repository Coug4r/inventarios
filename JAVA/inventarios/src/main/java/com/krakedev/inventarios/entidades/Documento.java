package com.krakedev.inventarios.entidades;

public class Documento {
	private String codigo;
	private String descripcion;
	
	public Documento() {}
	
	@Override
	public String toString() {
		return "Documento [codigo=" + codigo + ", descripcion=" + descripcion + "]";
	}

	public Documento(String codigo, String descripcion) {
		super();
		this.codigo = codigo;
		this.descripcion = descripcion;
	}

	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
}
