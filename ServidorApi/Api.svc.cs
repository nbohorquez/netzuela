//-----------------------------------------------------------------------
// <copyright file="Api.svc.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

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
    using System.Security.Principal;                        // IIdentity
    using System.ServiceModel;                              // FaultException
    using System.ServiceModel.Web;
    using System.Text;
    
    using Zuliaworks.Netzuela.Spuria.Api;                   // IApiPublica
    using Zuliaworks.Netzuela.Spuria.Datos;                 // SpuriaEntities
    //using Zuliaworks.Netzuela.Valeria.Comunes;              // ParametrosDeConexion
    //using Zuliaworks.Netzuela.Valeria.Logica;               // Conexion
    //using Zuliaworks.Netzuela.Valeria.Preferencias;         // ConexionesSection

    /*
     * Para informacion sobre concurrencia ver: http://www.codeproject.com/KB/WCF/WCFConcurrency.aspx
     */

    /// <summary>
    /// Implementación de la API de Spuria.
    /// </summary>
    [ServiceBehavior(
        Namespace = "http://netzuela.zuliaworks.com/spuria/api_publica",
        ConcurrencyMode = ConcurrencyMode.Multiple, 
        InstanceContextMode = InstanceContextMode.PerSession)]
    public class Api : IApiPublica
    {
        #region Variables

        private readonly int tiendaId;
        private readonly SpuriaEntities datos;
        //private ParametrosDeConexion parametros;
        //private Conexion conexion;
        
        #endregion

        #region Constructores

        /// <summary>
        /// Inicializa una nueva instancia de la clase Api.
        /// </summary>
        public Api()
        {
            /*
            this.parametros = CargarGuardar.CargarParametrosDeConexion("Local");
            SecureString[] credenciales = CargarGuardar.CargarCredenciales("Local");

            if (this.parametros == null || !(credenciales.Length > 0))
            {
                throw new Exception("Error interno del servidor. Por favor inténtelo más tarde");
            }

            this.conexion = new Conexion(this.parametros);
            this.conexion.Conectar(credenciales[0], credenciales[1]);

            credenciales[0].Dispose();
            credenciales[0] = null;

            credenciales[1].Dispose();
            credenciales[1] = null;
            */

            datos = Proveedor.Spuria;

            acceso cuenta = datos.acceso.First(c => c.CorreoElectronico == Cliente);
            cliente cliente = cuenta.usuario.cliente.First(c => c.usuario.UsuarioID == cuenta.AccesoID);
            tienda tienda = cliente.tienda.First(t => t.cliente.RIF == cliente.RIF);
            tiendaId = tienda.TiendaID;
        }

        #endregion

        #region Propiedades

        private string Cliente
        {
            get { return OperationContext.Current.ServiceSecurityContext.PrimaryIdentity.Name; }
        }

        #endregion

        #region Implementacion de interfaces

        /// <summary>
        /// Lista las bases de datos disponibles en el servidor.
        /// </summary>
        /// <returns>Nombres de las bases de datos encontradas.</returns>
        public string[] ListarBasesDeDatos()
        {
            List<string> resultadoFinal = new List<string>();
            /*
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
            */
            return resultadoFinal.ToArray();
        }

        /// <summary>
        /// Lista las tablas que pertenecen a la base de datos especificada.
        /// </summary>
        /// <param name="baseDeDatos">Nombre de la base de datos a consultar.</param>
        /// <returns>Nombres de las tablas encontradas.</returns>
        public string[] ListarTablas(string baseDeDatos)
        {
            List<string> resultadoFinal = new List<string>();
            /*
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
            */
            return resultadoFinal.ToArray();
        }

        /// <summary>
        /// Consulta la tabla de la base de datos indicada.
        /// </summary>
        /// <param name="baseDeDatos">Base de datos a consultar.</param>
        /// <param name="tabla">Nombre de la tabla a leer.</param>
        /// <returns>Tabla leída.</returns>
        public DataTableXml LeerTabla(string baseDeDatos, string tabla)
        {
            DataTableXml datosAEnviar = null;
            /*
            try
            {
                DataTable t = this.conexion.LeerTabla(baseDeDatos, tabla);
                datosAEnviar = t.DataTableAXml(baseDeDatos, tabla);
            }
            catch (Exception ex)
            {
                throw new Exception("SPURIA: Error de lectura", ex);
            }
            */
            return datosAEnviar;
        }

        /// <summary>
        /// Escribe el contenido de la tabla en la base de datos.
        /// </summary>
        /// <param name="tablaXml">Tabla a escribir.</param>
        /// <returns>Indica si la operación de escritura tuvo éxito.</returns>
        public bool EscribirTabla(DataTableXml tablaXml)
        {
            bool resultado = false;
            /*
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
            */
            return resultado;
        }

        #endregion
    }
}
