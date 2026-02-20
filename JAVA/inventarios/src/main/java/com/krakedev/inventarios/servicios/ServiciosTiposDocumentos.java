package com.krakedev.inventarios.servicios;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.krakedev.inventarios.bdd.TipoDocumentos;
import com.krakedev.inventarios.entidades.Documento;
import com.krakedev.inventarios.excepciones.KrakdevException;
@Path("tiposdocumento")
public class ServiciosTiposDocumentos {
	@Path("recuperar")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response recuperar(){
		TipoDocumentos tipDoc=new TipoDocumentos();
		ArrayList<Documento> documentos=null;
		try {
			documentos = tipDoc.recuperar();
			return Response.ok(documentos).build();
		} catch (KrakdevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
}
