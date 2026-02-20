package com.krakedev.inventarios.bdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.krakedev.inventarios.entidades.Documento;
import com.krakedev.inventarios.entidades.Proveedor;
import com.krakedev.inventarios.excepciones.KrakdevException;
import com.krakedev.inventarios.utils.ConexionBDD;

public class ProveedoresBDD {
	public ArrayList<Proveedor> buscar(String subCadena) throws KrakdevException{
		ArrayList<Proveedor> proveedores = new ArrayList<Proveedor>();
		Connection con = null;
		PreparedStatement ps =null;
		ResultSet rs=null;
		Proveedor proveedor = null;
		try {
			con = ConexionBDD.obtenerConexcion();
			ps = con.prepareStatement("Select prov.identificador, prov.tipo_documento, td.descripcion ,prov.nombre,prov.telefono,prov.correo,prov.direccion "
					+ "from proveedores prov, tipo_documentos td "
					+ "where prov.tipo_documento = td.codigo "
					+ "and upper(nombre) like ?");
			ps.setString(1, "%"+subCadena.toUpperCase()+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				String identificador = rs.getString("identificador");
				String codigo_tipo_documento = rs.getString("tipo_documento");
				String descripcion_tipo_documento = rs.getString("descripcion");
				String nombre = rs.getString("nombre");
				String telefono = rs.getString("telefono");
				String correo = rs.getString("correo");
				String direccion = rs.getString("direccion");
				Documento td = new Documento(codigo_tipo_documento,descripcion_tipo_documento);
				proveedor = new Proveedor(identificador,td,nombre,telefono,correo,direccion);
				proveedores.add(proveedor);
			}
		} catch (KrakdevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new KrakdevException("Error al consultar! Detalle"+e.getMessage());
		}
		return proveedores;
	}
	
	public void crear(Proveedor proveedor) throws KrakdevException {
		Connection con = null;
		PreparedStatement ps =null;
	
		try {
			con = ConexionBDD.obtenerConexcion();
			ps = con.prepareStatement("insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)\r\n"
					+ "values(?,?,?,?,?,?);");
			ps.setString(1, proveedor.getIdentificador());
			ps.setString(2,proveedor.getTipoDocumento().getCodigo());
			ps.setString(3, proveedor.getNombre());
			ps.setString(4, proveedor.getTelefono());
			ps.setString(5, proveedor.getCorreo());
			ps.setString(6, proveedor.getDireccion());
			ps.executeUpdate();
		} catch (KrakdevException e) {
			e.printStackTrace();
			throw e;
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}