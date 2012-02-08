namespace Zuliaworks.Netzuela.Spuria.ServidorApi
{
    using System;
    using System.Collections.Generic;
    using System.Configuration;                             // ConfigurationManager
    using System.Data;                                      // DataSet
    using System.IdentityModel.Selectors;                   // UserNamePasswordValidator
    using System.IdentityModel.Tokens;                      // SecurityTokenException
    using System.IO;                                        // MemoryStream
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Security;                                  // SecureString
    using System.ServiceModel;                              // FaultException
    using System.ServiceModel.Web;
    using System.Text;
    
    using Zuliaworks.Netzuela.Spuria.Api;                   // IApiPublica
    using Zuliaworks.Netzuela.Valeria.Comunes;              // ParametrosDeConexion
    using Zuliaworks.Netzuela.Valeria.Logica;               // Conexion
    using Zuliaworks.Netzuela.Valeria.Preferencias;         // ConexionesSection

    /*
     * Para informacion sobre concurrencia ver: http://www.codeproject.com/KB/WCF/WCFConcurrency.aspx
     */

    [ServiceBehavior(
        Namespace = "http://netzuela.zuliaworks.com/spuria/api_publica",
        ConcurrencyMode = ConcurrencyMode.Multiple, 
        InstanceContextMode = InstanceContextMode.PerSession)]
    public class Api : IApiPublica
    {
        #region Variables

        private ParametrosDeConexion parametros;
        private Conexion conexion;

        #endregion

        #region Constructores

        public Api()
        {
            this.parametros = CargarGuardar.CargarParametrosDeConexion("Local");

            if (this.parametros != null)
            {
                this.conexion = new Conexion(this.parametros);

                SecureString[] credenciales = CargarGuardar.CargarCredenciales("Local");

                if (credenciales.Length > 0)
                {
                    this.conexion.Conectar(credenciales[0], credenciales[1]);

                    credenciales[0].Dispose();
                    credenciales[0] = null;

                    credenciales[1].Dispose();
                    credenciales[1] = null;
                }
            }
        }

        #endregion

        #region Implementacion de interfaces

        public string[] ListarBasesDeDatos()
        {
            List<string> resultadoFinal = new List<string>();

            try
            {
                string[] resultadoBruto = this.conexion.ListarBasesDeDatos();

                foreach (string s in resultadoBruto)
                {
                    resultadoFinal.Add(s);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de listado de base de datos", ex);
            }

            return resultadoFinal.ToArray();
        }

        public string[] ListarTablas(string baseDeDatos)
        {
            List<string> resultadoFinal = new List<string>();

            try
            {
                string[] resultadoBruto = this.conexion.ListarTablas(baseDeDatos);

                foreach (string s in resultadoBruto)
                {
                    resultadoFinal.Add(s);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de listado de tablas", ex);
            }

            return resultadoFinal.ToArray();
        }

        public DataTableXml LeerTabla(string baseDeDatos, string tabla)
        {
            DataTableXml datosAEnviar = null;

            try
            {
                DataTable t = this.conexion.LeerTabla(baseDeDatos, tabla);
                datosAEnviar = t.DataTableAXml(baseDeDatos, tabla);
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de lectura", ex);
            }

            return datosAEnviar;
        }

        public bool EscribirTabla(DataTableXml tablaXml)
        {
            bool resultado = false;

            try
            {
                DataTable tabla = tablaXml.XmlADataTable();
                this.conexion.EscribirTabla(tablaXml.BaseDeDatos, tablaXml.NombreTabla, tabla);

                resultado = true;
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de escritura", ex);
            }

            return resultado;
        }

        #endregion
    }
}
