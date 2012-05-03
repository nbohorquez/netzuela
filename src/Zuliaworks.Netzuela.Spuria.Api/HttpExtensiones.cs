namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Net;								// HttpStatusCode
	using System.ServiceModel.Channels;				// HttpRequestMessageProperty
	using System.Web;								// HttpContext, HttpRequest
		
	using Zuliaworks.Netzuela.Valeria.Comunes;		// DecodificarBase64

	public static class HttpExtensiones
	{
		public static bool ContieneEncabezado(this WebHeaderCollection encabezados, string palabra_clave)
		{
			return !(string.IsNullOrWhiteSpace(encabezados[palabra_clave])) ? true : false;
		}
		 
		public static string[] ObtenerEncabezadoAutorizacion(this System.Net.WebHeaderCollection encabezados)
		{
			string autorizacionCodificada = encabezados["Authorization"].Replace("Basic ", string.Empty);
			string autorizacionDecodificada = autorizacionCodificada.DecodificarBase64();
			string[] autorizacion = autorizacionDecodificada.Split(':');
			
			if (autorizacion.Length != 2 || string.IsNullOrEmpty(autorizacion[0]) || string.IsNullOrEmpty(autorizacion[1]))
			{
				return null;
			}
			
			return autorizacion;
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