namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections.ObjectModel;
	using System.Collections.Generic;
	using System.Linq;
	using System.ServiceModel;
	using System.ServiceModel.Activation;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Configuration;
	using System.ServiceModel.Description;
	using System.ServiceModel.Dispatcher;
	
	using log4net;
	
	public class ExtensionServicio : BehaviorExtensionElement, IServiceBehavior
	{
		#region Variables
		
		private readonly ILog log;
		
		#endregion
		
		#region Constructores
		
		public ExtensionServicio ()
		{
			log = LogManager.GetLogger(typeof(ExtensionServicio));
			log.Debug("Se creo");
		}
		
		#endregion

		#region Implementacion de interfaces

		public override Type BehaviorType 
		{
			get { return typeof(ExtensionServicio); }
		}

		protected override object CreateBehavior ()
		{
			return this;
		}
		
		public void AddBindingParameters (ServiceDescription description, ServiceHostBase serviceHostBase, Collection<ServiceEndpoint> endpoints, BindingParameterCollection parameters)
		{
		}

		public void ApplyDispatchBehavior (ServiceDescription description, ServiceHostBase serviceHostBase)
		{
			log.Debug("Entrando a ApplyDispatchBehavior");
			/*
			var intervenibles = (from dispatcher in serviceHostBase.ChannelDispatchers.Cast<ChannelDispatcher>()
							 	from endpoint in dispatcher.Endpoints
							 	from operation in endpoint.DispatchRuntime.Operations
							 	select new { Endpoints = endpoint, Operations = operation }).SingleOrDefault();

			((SynchronizedCollection<EndpointDispatcher>)(intervenibles.Endpoints)).ToList().ForEach(endpoint => endpoint.DispatchRuntime.MessageInspectors.Add(new InspectorWcfMensajes()));
			((SynchronizedCollection<DispatchOperation>)(intervenibles.Operations)).ToList().ForEach(operation => operation.ParameterInspectors.Add(new InspectorWcfParametros()));
			*/
			
			foreach (ChannelDispatcher chDisp in serviceHostBase.ChannelDispatchers)
			{
				foreach (EndpointDispatcher epDisp in chDisp.Endpoints)
				{
					epDisp.DispatchRuntime.MessageInspectors.Add(new WcfInspectorMensajes());
					
					foreach (DispatchOperation op in epDisp.DispatchRuntime.Operations)
					{
						op.ParameterInspectors.Add(new WcfInspectorParametros());
					}
				}
			}
			
			log.Debug("Saliendo de ApplyDispatchBehavior");
		}

		public void Validate (ServiceDescription description, ServiceHostBase serviceHostBase)
		{
			/*
			log.Debug("Entrando a Validate");
			
			Type tipo = serviceHostBase.Description.ServiceType;
			serviceHostBase.Description.Name = tipo.ToString();
			log.Debug("Nombre servicio=" + serviceHostBase.Description.Name + "Namespace=" + serviceHostBase.Description.Namespace + "tipo=" + serviceHostBase.Description.ServiceType.ToString());
			
			// Se agregan los "bindings"
		    foreach (Uri direccion in serviceHostBase.BaseAddresses)
		    {
				log.Debug("Direccion base=" + direccion.ToString() + ";servicio=" + tipo.Name + ";contrato=" + tipo.GetInterfaces()[0].ToString());
		        BasicHttpBinding https = new BasicHttpBinding();
				https.Security.Mode = BasicHttpSecurityMode.Transport;
				https.Security.Transport.ClientCredentialType = HttpClientCredentialType.Basic;
				https.Security.Transport.ProxyCredentialType = HttpProxyCredentialType.None;
				https.Security.Transport.Realm = string.Empty;
				https.Name = tipo.Name;
				serviceHostBase.AddServiceEndpoint(tipo.GetInterfaces()[0].ToString(), https, direccion);
				
				log.Debug("protocolo servicio=" + https.Scheme);
				
				BindingElement bindingElement = new HttpsTransportBindingElement();
				CustomBinding mex = new CustomBinding(bindingElement);
				ServiceMetadataBehavior metadataBehavior = serviceHostBase.Description.Behaviors.Find<ServiceMetadataBehavior>();
				if (metadataBehavior == null)
				{
					log.Debug("No tenia metadata behavior");					
   					metadataBehavior = new ServiceMetadataBehavior();
					metadataBehavior.HttpsGetEnabled = true;
   					serviceHostBase.Description.Behaviors.Add(metadataBehavior);
				}
				else
				{
					log.Debug("Si tenia metadata behavior");	
				}
				serviceHostBase.AddServiceEndpoint(ServiceMetadataBehavior.MexContractName, mex, "mex");
				
				log.Debug("protocolo metadata=" + mex.Scheme);
		    }
		    
		    log.Debug("Saliendo de Validate");
			*/
		}
		
		#endregion
	}
}