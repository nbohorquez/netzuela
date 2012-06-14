namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.ServiceModel;
	using System.ServiceModel.Activation;
	using System.ServiceModel.Description;
	using System.ServiceModel.Security;
	
	using log4net;

	public class FabricaDeAnfitriones : ServiceHostFactory
	{
		#region Variables
		
		private readonly ILog log;
		
		#endregion
		
		#region Constructores
		
		public FabricaDeAnfitriones ()
		{
			log = LogManager.GetLogger(typeof(FabricaDeAnfitriones));
			log.Debug("Se creo");
		}
		
		#endregion 
		
		#region Funciones
		
		protected override ServiceHost CreateServiceHost(Type serviceType, Uri[] baseAddresses)
		{
			/*
			 * Referencias
			 * ===========
			 * 
			 * http://blogs.msdn.com/b/carlosfigueira/archive/2011/06/14/wcf-extensibility-servicehostfactory.aspx
			 * http://www.codeproject.com/Articles/29167/A-custom-ServiceHostFactory
			 * http://msdn.microsoft.com/en-us/library/ms730137.aspx
			 * 
			 */
			
			log.Debug("Entrando a CreateServiceHost");
		    ServiceHost anfitrion = new ServiceHost(serviceType, baseAddresses);
			
			// Se agregan los "bindings"
		    foreach (Uri direccion in baseAddresses)
		    {
				log.Debug("Direccion base=" + direccion.ToString() + ";nombre=" + serviceType.Name + ";contrato=" + serviceType.GetInterfaces()[0].ToString());
		        BasicHttpBinding b = new BasicHttpBinding(BasicHttpSecurityMode.Transport);
				b.Name = serviceType.Name;
		        anfitrion.AddServiceEndpoint(serviceType.GetInterfaces()[0], b, direccion);
		    }
			
			// Se configuran los comportamientos del servicio ("service behaviors")
			ServiceMetadataBehavior metadata = new ServiceMetadataBehavior() { HttpsGetEnabled = true };
			ServiceDebugBehavior depuracion = new ServiceDebugBehavior() { IncludeExceptionDetailInFaults = true };
			ServiceCredentials credenciales = new ServiceCredentials();
			credenciales.UserNameAuthentication.UserNamePasswordValidationMode = UserNamePasswordValidationMode.Custom;
			credenciales.UserNameAuthentication.CustomUserNamePasswordValidator = new ValidadorCredenciales();
			
			anfitrion.Description.Behaviors.Add(metadata);
			anfitrion.Description.Behaviors.Add(depuracion);
			anfitrion.Description.Behaviors.Add(credenciales);
			anfitrion.Description.Behaviors.Add(new ExtensionServicio());
			
			log.Debug("Saliendo de CreateServiceHost");
		    return anfitrion;
		}
		
		#endregion
	}
}

