namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	
	using ServiceStack.CacheAccess;							// ICacheClient
	using ServiceStack.CacheAccess.Providers;				// MemoryCacheClient
	using ServiceStack.ServiceInterface;					// AuthFeature
	using ServiceStack.ServiceInterface.Auth;				// IAuthProvider
	using ServiceStack.WebHost.Endpoints;					// AppHostBase
	
	public class Anfitrion : AppHostBase
	{
		#region Constructores
		
		public Anfitrion()
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
}