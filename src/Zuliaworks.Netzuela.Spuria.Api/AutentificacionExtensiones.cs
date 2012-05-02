//-----------------------------------------------------------------------
// <copyright file="AutentificacionExtensiones.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace Zuliaworks.Netzuela.Spuria.Api
{
	using log4net;
	
    using System;
    using System.Collections.Generic;
    using System.Data;                              // DataTable
    using System.Linq;
	using System.Net;								// HttpStatusCode
    using System.ServiceModel;                      // FaultException
    using System.Web;								// HttpContext, HttpRequest
	
	using Zuliaworks.Netzuela.Valeria.Comunes;		// DecodificarBase64
    using Zuliaworks.Netzuela.Valeria.Logica;       // Conexion	
	
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
     * Adaptado                                             [X]
     * Solo se cambiaron los nombres de las variables       []
     * 
     */
	
    /// <summary>
    /// Administra los credenciales enviados por el cliente.
    /// </summary>
    public static class AutentificacionExtensiones
    {
		public static bool ContieneEncabezadoAutorizacion(this HttpRequest peticion)
		{
			return !(string.IsNullOrWhiteSpace(peticion.Headers["Authorization"])) ? true : false;
		}
		
		public static void DenegarAutorizacion(this HttpContext contexto)
		{
			contexto.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
		    contexto.Response.StatusDescription = "Acceso Denegado";
		    contexto.Response.Write("401 Acceso Denegado");
		    contexto.Response.End();
		}
	}
}

