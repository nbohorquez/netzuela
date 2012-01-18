using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

using System.Configuration;                             // ConfigurationManager
using System.Data;                                      // DataSet
using System.IO;                                        // MemoryStream
using System.Security;                                  // SecureString
using Zuliaworks.Netzuela.Valeria.Comunes;              // ParametrosDeConexion
using Zuliaworks.Netzuela.Valeria.Logica;               // Conexion
using Zuliaworks.Netzuela.Valeria.Preferencias;         // ConexionesSection
using Zuliaworks.Netzuela.Spuria.Contrato;              // ISpuria

namespace Zuliaworks.Netzuela.Spuria.Servidor
{
    // Para informacion sobre concurrencia ver: http://www.codeproject.com/KB/WCF/WCFConcurrency.aspx

    [ServiceBehavior(ConcurrencyMode=ConcurrencyMode.Multiple, InstanceContextMode=InstanceContextMode.PerSession)]
    public class ServidorRemoto : ISpuria
    {
        #region Variables

        private ParametrosDeConexion _Parametros;
        private Conexion _Conexion;

        #endregion

        #region Constructores

        public ServidorRemoto()
        {
            _Parametros = CargarGuardar.CargarParametrosDeConexion("Local");

            if (_Parametros != null)
            {
                _Conexion = new Conexion(_Parametros);

                SecureString[] Credenciales = CargarGuardar.CargarCredenciales("Local");

                if (Credenciales.Length > 0)
                {
                    _Conexion.Conectar(Credenciales[0], Credenciales[1]);

                    Credenciales[0].Dispose();
                    Credenciales[0] = null;

                    Credenciales[1].Dispose();
                    Credenciales[1] = null;
                }
            }
        }

        #endregion

        #region Implementacion de interfaces

        public string[] ListarBasesDeDatos()
        {
            string[] Resultado = _Conexion.ListarBasesDeDatos();
            return Resultado;
        }

        public string[] ListarTablas(string BaseDeDatos)
        {
            string[] Resultado = _Conexion.ListarTablas(BaseDeDatos);
            return Resultado;
        }

        public DataSetXML LeerTabla(string BaseDeDatos, string Tabla)
        {
            DataTable T = _Conexion.LeerTabla(BaseDeDatos, Tabla);

            DataSet Set = new DataSet(Tabla);
            Set.Tables.Add(T);

            DataSetXML DatosAEnviar = new DataSetXML(Set.GetXmlSchema(), Set.GetXml());
            return DatosAEnviar;
        }

        public bool EscribirTabla(DataSetXML Tabla)
        {
            // Con codigo de: http://pstaev.blogspot.com/2008/04/passing-dataset-to-wcf-method.html

            DataSet Tablas = new DataSet();
            bool Resultado = false;

            try
            {
                Tablas.ReadXmlSchema(new MemoryStream(Encoding.Unicode.GetBytes(Tabla.EsquemaXML)));
                Tablas.ReadXml(new MemoryStream(Encoding.Unicode.GetBytes(Tabla.XML)));
                Tablas.WriteXml(Tablas.Tables[0].TableName + ".xml");

                Resultado = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return Resultado;
        }

        #endregion
    }
}
