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
using Zuliaworks.Netzuela.Spuria.ApiPublica;            // IApiPublica

namespace Zuliaworks.Netzuela.Spuria.Servidor
{
    // Para informacion sobre concurrencia ver: http://www.codeproject.com/KB/WCF/WCFConcurrency.aspx

    [ServiceBehavior(ConcurrencyMode=ConcurrencyMode.Multiple, InstanceContextMode=InstanceContextMode.PerSession)]
    public class ServidorRemoto : IApiPublica
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
            List<string> ResultadoFinal = new List<string>();

            try
            {
                string[] ResultadoBruto = _Conexion.ListarBasesDeDatos();

                foreach (string S in ResultadoBruto)
                    ResultadoFinal.Add(S);
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de listado de base de datos", ex);
            }

            return ResultadoFinal.ToArray();
        }

        public string[] ListarTablas(string BaseDeDatos)
        {
            List<string> ResultadoFinal = new List<string>();

            try
            {
                string[] ResultadoBruto = _Conexion.ListarTablas(BaseDeDatos);

                foreach (string S in ResultadoBruto)
                    ResultadoFinal.Add(S);
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de listado de tablas", ex);
            }

            return ResultadoFinal.ToArray();
        }

        public DataTableXML LeerTabla(string BaseDeDatos, string Tabla)
        {
            DataTableXML DatosAEnviar = null;

            try
            {
                DataTable T = _Conexion.LeerTabla(BaseDeDatos, Tabla);
                DatosAEnviar = T.DataTableAXml(BaseDeDatos, Tabla);
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de lectura", ex);
            }

            return DatosAEnviar;
        }

        public bool EscribirTabla(DataTableXML TablaXML)
        {
            bool Resultado = false;

            try
            {
                DataTable Tabla = TablaXML.XmlADataTable();
                _Conexion.EscribirTabla(TablaXML.BaseDeDatos, TablaXML.NombreTabla, Tabla);

                Resultado = true;
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de escritura", ex);
            }

            return Resultado;
        }

        #endregion
    }
}
