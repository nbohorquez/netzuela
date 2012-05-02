namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections.ObjectModel;
	using System.Collections.Generic;
	using System.Linq;
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Configuration;
	using System.ServiceModel.Description;
	using System.ServiceModel.Dispatcher;
	
	public class WcfBehaviorExtension : BehaviorExtensionElement, IServiceBehavior
	{
		#region Constructores
		
		public WcfBehaviorExtension ()
		{
		}
		
		#endregion

		#region Implementacion de interfaces

		public override Type BehaviorType 
		{
			get { return typeof(WcfBehaviorExtension); }
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
		}

		public void Validate (ServiceDescription description, ServiceHostBase serviceHostBase)
		{
		}
		
		#endregion
	}
}