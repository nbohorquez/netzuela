namespace Zuliaworks.Netzuela.Spuria.Api
{
	using log4net;
	
	using System;
	using System.Net;
	using System.Security.Principal;				// GenericIdentity, GenericPrincipal
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Dispatcher;
	using System.Xml;
	
	using Zuliaworks.Netzuela.Valeria.Comunes;
	
	public class WcfInspectorMensajes : IDispatchMessageInspector
	{
		#region Variables y Constantes
		
		private readonly ILog log;
		
		#endregion
		
		#region Constructores
		
		public WcfInspectorMensajes ()
		{
			log = LogManager.GetLogger(typeof(WcfInspectorMensajes));
		}
		
		#endregion

		#region Implementacion de interfaces
		
		public object AfterReceiveRequest (ref Message message, IClientChannel channel, InstanceContext context)
		{
			/*
			 * Servicio de autentificacion del usuario
			 * =======================================
			 * 
			 * En verdad esto es un hackeo burdo al sistema WCF porque legalmente tendria que implementar 
			 * una clase con la interfaz IAuthorizationPolicy como se explica en:
			 * 
			 * http://www.codeproject.com/Articles/33872/Custom-Authorization-in-WCF
			 * http://weblogs.asp.net/paolopia/archive/2005/12/08/432658.aspx
			 * 
			 * NOTA: Sin embargo, Mono todavia no ha implementado la propiedad <serviceAuthorization principalPermissionMode="Custom">
			 * que se emplea en este caso. Por lo que me tengo que quedar con esta solucion por los momentos.
			 * 
			 */
			
			log.Debug("AfterReceiveRequest");
			
			object propiedad;
					
			message.Properties.TryGetValue(HttpRequestMessageProperty.Name, out propiedad);
			HttpRequestMessageProperty peticion = (HttpRequestMessageProperty)propiedad;
			
			Autentificacion auten = new Autentificacion(peticion.Headers);
			if (auten.TieneEncabezadoAutorizacion)
			{
				if (auten.Autentificar())
			    {
					//OperationContext.Current.ServiceSecurityContext.PrimaryIdentity = new GenericIdentity(auth.Usuario.ToString());
					Sesion.Propiedades["Usuario"] = auten.Usuario;
			    }
				else
				{
					log.Fatal("Usuario=" + auten.Usuario.ToString() + " autentificado?=" + auten.Autentificado.ToString());
					throw new Exception("Usuario/contrasena invalido");
				}
					
				log.Debug("Usuario=" + auten.Usuario.ToString() + " autentificado?=" + auten.Autentificado.ToString());
			}
			
			return null;
		}

		public void BeforeSendReply (ref Message message, object instance)
		{
			Sesion.Propiedades["Usuario"] = Autentificacion.TipoDeUsuario.Anonimo;
		}
		
		#endregion
	}
}