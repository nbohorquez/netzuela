namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.ServiceModel.Dispatcher;
	
	public class WcfInspectorParametros : IParameterInspector
	{
		#region Constructores
		
		public WcfInspectorParametros ()
		{
		}
		
		#endregion

		#region Implementation de interfaces
		
		public void AfterCall (string operationName, object[] outputs, object returnValue, object correlationState)
		{
		}

		public object BeforeCall (string operationName, object[] inputs)
		{
			return new object();
		}
		
		#endregion
	}
}

