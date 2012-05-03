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
	using System.Security.Principal;				// GenericIdentity, GenericPrincipal
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
		
		private void ComenzarPeticion(object remitente, EventArgs e)
		{
		}
		
		private void AutentificarPeticion(object remitente, EventArgs e)
		{
			Autentificacion auth = new Autentificacion((WebHeaderCollection)HttpContext.Current.Request.Headers);
			
			if (auth.TieneEncabezadoAutorizacion)
			{
				try
				{
					if (auth.Autentificar())
				    {
						GenericIdentity identidad = new GenericIdentity(auth.Usuario.ToString());
						HttpContext.Current.User = new GenericPrincipal(identidad, new string[] { "Tienda" } );
				    }
					else
					{
						HttpContext.Current.DenegarAutorizacion();
					}
					
					log.Debug("Usuario=" + HttpContext.Current.User.Identity.Name + " autentificado?=" + HttpContext.Current.User.Identity.IsAuthenticated.ToString());
				}
				catch(Exception ex)
				{
					log.Fatal("Error autentificando el usuario");
					throw new Exception("SPURIA: Error autentificando el usuario", ex);
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
		
		#endregion
		
		#region Implementacion de interfaces
		
		public void Dispose ()
		{
			throw new NotImplementedException ();
		}

		public void Init (HttpApplication context)
		{
			context.BeginRequest += new EventHandler(ComenzarPeticion);
			//context.AuthenticateRequest += new EventHandler(AutentificarPeticion);
			context.EndRequest += new EventHandler(FinalizarPeticion);
		}
		
		#endregion
	}
}

