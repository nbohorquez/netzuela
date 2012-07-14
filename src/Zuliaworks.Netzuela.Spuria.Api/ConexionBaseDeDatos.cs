namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;                              // SecureString
	
	using log4net;
    using Zuliaworks.Netzuela.Valeria.Comunes;          // ParametrosDeConexion
    using Zuliaworks.Netzuela.Valeria.Preferencias;     // CargarGuardar
	
    public static class ConexionBaseDeDatos
    {
		private static readonly ILog log;
		private static readonly ParametrosDeConexion parametros;
        private static readonly SecureString[] credenciales;
		
        static ConexionBaseDeDatos()
        {
			try
			{
				log = LogManager.GetLogger(typeof(ConexionBaseDeDatos));
	            parametros = CargarGuardar.CargarParametrosDeConexion("Local");
	            credenciales = CargarGuardar.CargarCredenciales("Local");
						
				if (parametros == null || credenciales.Length != 2)
	            {
	                throw new Exception("Error interno del servidor. Por favor inténtelo más tarde");
	            }
			}
			catch (Exception ex)
			{
				log.Fatal("Error al obtener los datos de conexion de la base de datos: " + ex.Message);
				throw new Exception("Error al obtener los datos de conexion de la base de datos", ex);
			}
        }

        public static ParametrosDeConexion CadenaDeConexion
        {
            get { return parametros; }
		}
		
        public static SecureString[] Credenciales
        {
            get { return credenciales; }
		}
    }
}