using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;                              // ServiceContract, OperationContract

namespace Zuliaworks.Netzuela.Spuria.Api
{
    [ServiceContract]
    public interface IApiPublica
    {
        [OperationContract]
        string[] ListarBasesDeDatos();
        [OperationContract]
        string[] ListarTablas(string BaseDeDatos);
        [OperationContract]
        DataTableXML LeerTabla(string BaseDeDatos, string Tabla);
        [OperationContract]
        bool EscribirTabla(DataTableXML Tablas);
        /*
        [OperationContract]
        object CrearUsuario(SecureString Usuario, SecureString Contrasena, string[] Columnas, int Privilegios);
         * */
    }
}
