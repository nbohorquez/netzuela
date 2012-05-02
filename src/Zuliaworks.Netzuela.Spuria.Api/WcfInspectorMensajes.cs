namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Xml;
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Dispatcher;
	
	public class WcfInspectorMensajes : IDispatchMessageInspector
	{
		#region Constructores
		
		public WcfInspectorMensajes ()
		{
		}
		
		#endregion

		#region Implementacion de interfaces
		
		public object AfterReceiveRequest (ref Message message, IClientChannel channel, InstanceContext context)
		{
			object propObj1, propObj2;
			/*
			OperationContext.Current.IncomingMessageProperties.TryGetValue(HttpRequestMessageProperty.Name, out propObj2); 
			HttpRequestMessageProperty reqProp2 = (HttpRequestMessageProperty)propObj2;
			string headerAuth2 = reqProp2.Headers["Authorization"];
			*/
			
			message.Properties.TryGetValue(HttpRequestMessageProperty.Name, out propObj1);
			HttpRequestMessageProperty reqProp1 = (HttpRequestMessageProperty)propObj1;
			string headerAuth1 = reqProp1.Headers["Host"];			
			
			return null;
		}

		public void BeforeSendReply (ref Message message, object instance)
		{
		}
		
		#endregion
	}
}