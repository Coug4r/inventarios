package com.krakedev.inventarios.bdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.krakedev.inventarios.entidades.Documento;
import com.krakedev.inventarios.excepciones.KrakdevException;
import com.krakedev.inventarios.utils.ConexionBDD;

public class TipoDocumentos {
	public ArrayList<Documento> recuperar() throws KrakdevException{
		ArrayList<Documento> documentos = new ArrayList<Documento>();
		Connection con = null;
		PreparedStatement ps =null;
		ResultSet rs=null;
		Documento documento = null;
		
		try {
			con = ConexionBDD.obtenerConexcion();
			ps = con.prepareStatement("Select codigo,descripcion from tipo_documentos");
			rs = ps.executeQuery();
			while(rs.next()) {
				String codigo = rs.getString("codigo");
				String descripcion = rs.getString("descripcion");
				documento = new Documento(codigo,descripcion);
				documentos.add(documento);
			}
		} catch (KrakdevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return documentos;
	}
}
