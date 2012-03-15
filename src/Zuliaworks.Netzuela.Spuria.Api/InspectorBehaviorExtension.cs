namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Configuration;
	using System.ServiceModel.Description;
	using System.ServiceModel.Dispatcher;
	
	public class InspectorBehaviorExtension : BehaviorExtensionElement, IServiceBehavior
	{
		public InspectorBehaviorExtension ()
		{
		}

		#region Implementacion de interfaces
		
		public override Type BehaviorType 
		{
			get { return typeof(InspectorBehaviorExtension); }
		}
		
		protected override object CreateBehavior ()
		{
			return this;
		}
		
		public void AddBindingParameters (ServiceDescription description, ServiceHostBase serviceHostBase, System.Collections.ObjectModel.Collection<ServiceEndpoint> endpoints, BindingParameterCollection parameters)
		{
		}

		public void ApplyDispatchBehavior (ServiceDescription description, ServiceHostBase serviceHostBase)
		{
			foreach (ChannelDispatcher chDisp in serviceHostBase.ChannelDispatchers)
			{
				foreach (EndpointDispatcher epDisp in chDisp.Endpoints)
				{
					epDisp.DispatchRuntime.MessageInspectors.Add(new Inspector());
					/*
					foreach (DispatchOperation op in epDisp.DispatchRuntime.Operations)
					{
						op.ParameterInspectors.Add(new InspectorDeMensajes());
					}
					*/
				}
			}
		}

		public void Validate (ServiceDescription description, ServiceHostBase serviceHostBase)
		{
		}
		
		#endregion
	}
}