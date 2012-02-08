namespace Zuliaworks.Netzuela.Spuria.Api
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.ServiceModel;          // ServiceContract, OperationContract
    using System.Text;

    [ServiceContract(Namespace = "http://netzuela.zuliaworks.com/spuria/api_publica")]    
    public interface IApiPublica
    {
        [OperationContract]
        string[] ListarBasesDeDatos();
        [OperationContract]
        string[] ListarTablas(string baseDeDatos);
        [OperationContract]
        DataTableXml LeerTabla(string baseDeDatos, string tabla);
        [OperationContract]
        bool EscribirTabla(DataTableXml tablas);
    }
}
