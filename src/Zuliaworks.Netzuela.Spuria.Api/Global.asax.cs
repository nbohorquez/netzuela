namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections;
	using System.ComponentModel;
	using System.Runtime.Serialization;
	using System.Web;
	using System.Web.SessionState;
	
	using log4net;
	using ServiceStack.CacheAccess;							// ICacheClient
	using ServiceStack.CacheAccess.Providers;				// MemoryCacheClient
	using ServiceStack.ServiceHost;							// RestService
	using ServiceStack.ServiceInterface;					// ServiceBase
	using ServiceStack.ServiceInterface.Auth;				// AuthUserSession
	using ServiceStack.ServiceInterface.ServiceModel;		// IHasResponseStatus
	using ServiceStack.WebHost.Endpoints;					// AppHostBase

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
		public string[] Resultado { get; set; }
		[DataMember]
		public ResponseStatus ResponseStatus { get; set; }
	}

	public class ListarTiendasServicio : ServiceBase<ListarTiendas>
	{
		#region Implementacion de interfaces
		
		protected override object Run (ListarTiendas peticion)
		{
			AuthUserSession sesion = (AuthUserSession)this.GetSession();
			return new ListarTiendasResponse { Resultado = new string[] { "Ahorita no te puedo atender, intenta mas tarde" } };
		}
		
		#endregion
	}
	
	public class Global : System.Web.HttpApplication
	{		
		#region Implementacion de interfaces
		
		protected void Application_Start(object sender, EventArgs e)
		{
			var anfitrion = new Servidor();
			anfitrion.Init();
		}
		
		#endregion
		
		#region Tipos anidados
		
		public class Servidor : AppHostBase
		{
			
			#region Constructores
			
			public Servidor() 
				: base("API de Netzuela", typeof(ListarTiendasServicio).Assembly) 
			{
			}
			
			#endregion
			
			#region Funciones
			
			public override void Configure(Funq.Container container) 
			{ 
				this.Plugins.Add(new AuthFeature(() => new AuthUserSession(), new IAuthProvider[] {
	            	new Autentificacion()
	        	}));
			    container.Register<ICacheClient>(new MemoryCacheClient());
			}
			
			#endregion
		}
		
		#endregion
	}
}