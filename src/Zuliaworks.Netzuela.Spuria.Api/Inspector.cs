namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Dispatcher;
	
	public class Inspector : IDispatchMessageInspector
	{
		#region Constructores
		
		public Inspector ()
		{
		}
		
		#endregion

		#region Implementacion de interfaces
		
		public object AfterReceiveRequest (ref Message message, IClientChannel channel, InstanceContext context)
		{
			object propObj1, propObj2;
			
			message.Properties.TryGetValue(HttpRequestMessageProperty.Name, out propObj1);
			OperationContext.Current.IncomingMessageProperties.TryGetValue(HttpRequestMessageProperty.Name, out propObj2); 

			HttpRequestMessageProperty reqProp1 = (HttpRequestMessageProperty)propObj1;
			HttpRequestMessageProperty reqProp2 = (HttpRequestMessageProperty)propObj2;
			
			string headerAuth1 = reqProp1.Headers["Authorization"];
			string headerAuth2 = reqProp2.Headers["Authorization"];
			
			return null;
		}

		public void BeforeSendReply (ref Message message, object instance)
		{
		}
		
		#endregion
	}
}