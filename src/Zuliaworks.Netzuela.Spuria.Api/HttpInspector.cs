//-----------------------------------------------------------------------
// <copyright file="InspectorHttp.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace Zuliaworks.Netzuela.Spuria.Api
{
	using log4net;
	
	using System;
	using System.Collections.Generic;
	using System.Data;
	using System.Globalization;
	using System.Linq;
	using System.Net;
	using System.Text;
	using System.Web;
	
	using Zuliaworks.Netzuela.Valeria.Comunes;
	using Zuliaworks.Netzuela.Valeria.Logica;
	
	public class HttpInspector : IHttpModule
	{
		#region Variables y Constantes
		
		private readonly ILog log;
		
		#endregion
		
		#region Constructores
		
		public HttpInspector ()
		{
			log = LogManager.GetLogger(typeof(HttpInspector));
		}
		
		#endregion 
		
		#region Funciones
		
		private void AutentificarPeticion(object remitente, EventArgs e)
		{
			HttpContext contexto = HttpContext.Current;			
			if (contexto.Request.ContieneEncabezadoAutorizacion())
			{
				try
				{
					if (!Autentificar(contexto.Request))
				    {
						contexto.DenegarAutorizacion();
				    }
				}
				catch(Exception ex)
				{
					log.Fatal("Error autentificando el usuario");
					throw new Exception("SPURIA: Error autentificando el usuario"  + Sesion.Credenciales[0].ConvertirAUnsecureString() + ";" + Sesion.Credenciales[1].ConvertirAUnsecureString(), ex);
				}
			}
		}
		
		private void FinalizarPeticion(object remitente, EventArgs e)
		{
			var contexto = (HttpApplication)remitente;
		    if (contexto.Response.StatusCode == (int)HttpStatusCode.Unauthorized)
		    {
		        string realm = String.Format(CultureInfo.InvariantCulture, "BASIC Realm=\"{0}\"", contexto.Request.Url.AbsolutePath);
		        contexto.Response.AppendHeader("WWW-Authenticate", realm);
		    }
		}
		
		public bool Autentificar(HttpRequest peticion)
		{
			string autorizacionCodificada = peticion.Headers["Authorization"].Replace("Basic ", string.Empty);
			string autorizacionDecodificada = autorizacionCodificada.DecodificarBase64();
			string[] autorizacion = autorizacionDecodificada.Split(':');
			
			if (autorizacion.Length != 2 || string.IsNullOrEmpty(autorizacion[0]) || string.IsNullOrEmpty(autorizacion[1]))
			{
				return false;
			}
				
			using (Conexion conexion = new Conexion(Sesion.CadenaDeConexion))
            {
				log.Debug("Intento de conexion con base de datos con usuario=" + Sesion.Credenciales[0].ConvertirAUnsecureString() + ";contrasena=" + Sesion.Credenciales[1].ConvertirAUnsecureString());
                conexion.Conectar(Sesion.Credenciales[0], Sesion.Credenciales[1]);

				string sql = "SELECT acceso_id FROM acceso WHERE correo_electronico = '" + autorizacion[0] + "' AND contrasena = '" + autorizacion[1] + "'";
                DataTable t = conexion.Consultar("spuria", sql);

                if (t.Rows.Count != 1)
                {
                    return false;
                }
				
				return true;
            }
		}
		
		#endregion
		
		#region Implementacion de interfaces
		
		public void Dispose ()
		{
			throw new NotImplementedException ();
		}

		public void Init (HttpApplication context)
		{
			context.AuthenticateRequest += new EventHandler(AutentificarPeticion);
			context.EndRequest += new EventHandler(FinalizarPeticion);
		}
		
		#endregion
	}
}

