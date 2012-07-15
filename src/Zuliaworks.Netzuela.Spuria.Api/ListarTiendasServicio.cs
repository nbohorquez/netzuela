namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections.Generic;
	using System.Data;
	using System.Runtime.Serialization;
	
	using ServiceStack.ServiceHost;							// RestService
	using ServiceStack.ServiceInterface;
	using ServiceStack.ServiceInterface.Auth;
	using ServiceStack.ServiceInterface.ServiceModel;		// IHasResponseStatus
	using Zuliaworks.Netzuela.Valeria.Logica;
	
	[DataContract]
	[Authenticate()]
	[RestService("/listartiendas")]
	public class ListarTiendas
	{
	}

	[DataContract]
	public class ListarTiendasResponse : IHasResponseStatus
	{
		[DataMember]
		public string[] Tiendas { get; set; }
		[DataMember]
		public ResponseStatus ResponseStatus { get; set; }
	}
	
	public class ListarTiendasServicio : ServiceBase<ListarTiendas>
	{
		#region Implementacion de interfaces
		
		protected override object Run (ListarTiendas request)
		{
			AuthUserSession sesion = (AuthUserSession)this.GetSession();
			List<string> resultado = new List<string>();
			
			try
			{
				using (Conexion conexion = new Conexion(ConexionBaseDeDatos.CadenaDeConexion))
	            {
					conexion.Conectar(ConexionBaseDeDatos.Credenciales[0], ConexionBaseDeDatos.Credenciales[1]);
					
					string sql = "SELECT t.tienda_id, c.nombre_legal "
								+ "FROM tienda AS t "
								+ "JOIN cliente AS c ON t.cliente_p = c.rif "
								+ "JOIN usuario AS u ON c.propietario = u.usuario_id "
								+ "WHERE u.usuario_id = " + sesion.UserName;
					DataTable t = conexion.Consultar(Constantes.BaseDeDatos, sql);
					
					foreach(DataRow r in t.Rows)
					{
						resultado.Add(r[0].ToString() + ":" + r[1].ToString());
					}
	            }
			}
			catch (Exception ex)
			{
				//log.Fatal("Usuario: " + sesion.UserName + ". Error de listado de base de datos: " + ex.Message);
                throw new Exception("Error de listado de base de datos", ex);
			}
			
			return new ListarTiendasResponse { Tiendas = resultado.ToArray() };
		}
		
		#endregion
	}
}