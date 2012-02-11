namespace Zuliaworks.Netzuela.Spuria.Api
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.ServiceModel;          // ServiceContract, OperationContract
    using System.Text;

    /// <summary>
    /// Definición de la API pública de Spuria.
    /// </summary>
    [ServiceContract(Namespace = "http://netzuela.zuliaworks.com/spuria/api_publica")]    
    public interface IApiPublica
    {
        /// <summary>
        /// Lista las bases de datos disponibles en el servidor.
        /// </summary>
        /// <returns>Nombres de las bases de datos encontradas.</returns>
        [OperationContract]
        string[] ListarBasesDeDatos();

        /// <summary>
        /// Lista las tablas que pertenecen a la base de datos especificada.
        /// </summary>
        /// <param name="baseDeDatos">Nombre de la base de datos a consultar.</param>
        /// <returns>Nombres de las tablas encontradas.</returns>
        [OperationContract]
        string[] ListarTablas(string baseDeDatos);

        /// <summary>
        /// Consulta la tabla de la base de datos indicada.
        /// </summary>
        /// <param name="baseDeDatos">Base de datos a consultar.</param>
        /// <param name="tabla">Nombre de la tabla a leer.</param>
        /// <returns>Tabla leída.</returns>
        [OperationContract]
        DataTableXml LeerTabla(string baseDeDatos, string tabla);

        /// <summary>
        /// Escribe el contenido de la tabla en la base de datos.
        /// </summary>
        /// <param name="tablaXml">Tabla a escribir.</param>
        /// <returns>Indica si la operación de escritura tuvo éxito.</returns>
        [OperationContract]
        bool EscribirTabla(DataTableXml tablas);
    }
}
