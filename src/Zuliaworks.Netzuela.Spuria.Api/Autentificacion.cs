//-----------------------------------------------------------------------
// <copyright file="AutentificacionExtensiones.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
    using System.Collections.Generic;
    using System.Data;                              // DataTable
    using System.Linq;
	using System.Net;								// WebHeaderCollection
	using System.ServiceModel.Channels;				// HttpRequestMessageProperty
	using System.Web;								// HttpContext, HttpRequest
	
	
	using Zuliaworks.Netzuela.Valeria.Comunes;
	using Zuliaworks.Netzuela.Valeria.Logica;
	
	/* 
     * Codigo importado
     * ================
     * 
     * Autor: Stefan Severin
     * Titulo: Secure your REST-based WCF service with WIF, part 1
     * Licencia: No especificada
     * Fuente: http://blog.jayway.com/2012/01/05/secure-your-rest-based-wcf-service-with-wif-part-1/
     * 
     * Tipo de uso
     * ===========
     * 
     * Textual                                              []
     * Adaptado                                             []
     * Solo se cambiaron los nombres de las variables       [X]
     * 
     */
	
    /// <summary>
    /// Administra los credenciales enviados por el cliente.
    /// </summary>
    public class Autentificacion
    {
		#region Variables y Constantes
		
		private string[] autorizacion;
		public enum TipoDeUsuario { Anonimo=-10 };
		
		#endregion
		
		#region Constructores
		
		public Autentificacion(WebHeaderCollection encabezados)
		{
			Encabezados = encabezados;
			Autentificado = false;
			Usuario = (int)TipoDeUsuario.Anonimo;
			
			TieneEncabezadoAutorizacion = encabezados.ContieneEncabezado("Authorization");
			if (TieneEncabezadoAutorizacion)
			{
				autorizacion = encabezados.ObtenerEncabezadoAutorizacion();
			}
		}
		
		#endregion
		
		#region Propiedades
		
		public WebHeaderCollection Encabezados { get; private set; }
		public bool TieneEncabezadoAutorizacion { get; private set; }
		public bool Autentificado { get; private set; }
		public int Usuario { get; private set; }
		
		#endregion
		
		public bool Autentificar()
		{
			using (Conexion conexion = new Conexion(Sesion.CadenaDeConexion))
            {
				bool resultado = false;
				
				conexion.Conectar(Sesion.Credenciales[0], Sesion.Credenciales[1]);
				string sql = "SELECT acceso_id FROM acceso WHERE correo_electronico = '" + autorizacion[0] + "' AND contrasena = '" + autorizacion[1] + "'";
                DataTable t = conexion.Consultar("spuria", sql);
				
                if (t.Rows.Count == 1)
                {
                    resultado = true;
					Usuario = (int)t.Rows[0].ItemArray[0];
				}
				
				Autentificado = resultado;
				return resultado;
            }
		}
	}
}