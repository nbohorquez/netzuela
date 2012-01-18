using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;                              // ServiceContract, OperationContract

namespace Zuliaworks.Netzuela.Spuria.Contrato
{
    [ServiceContract]
    public interface ISpuria
    {
        [OperationContract]
        string[] ListarBasesDeDatos();
        [OperationContract]
        string[] ListarTablas(string BaseDeDatos);
        [OperationContract]
        DataSetXML LeerTabla(string BaseDeDatos, string Tabla);
        [OperationContract]
        bool EscribirTabla(DataSetXML Tablas);
        /*
        [OperationContract]
        object CrearUsuario(SecureString Usuario, SecureString Contrasena, string[] Columnas, int Privilegios);
         * */
    }
}
