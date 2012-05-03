namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;                              // SecureString

    using Zuliaworks.Netzuela.Valeria.Comunes;          // ParametrosDeConexion
    using Zuliaworks.Netzuela.Valeria.Preferencias;     // CargarGuardar
	
    public static class Sesion
    {
		private static readonly ParametrosDeConexion parametros;
        private static readonly SecureString[] credenciales;
		private static Dictionary<string, object> propiedades;
		
        static Sesion()
        {
            parametros = CargarGuardar.CargarParametrosDeConexion("Local");
            credenciales = CargarGuardar.CargarCredenciales("Local");
			propiedades = new Dictionary<string, object>() 
			{
				{ "Usuario", string.Empty }
			};
					
			if (parametros == null || credenciales.Length != 2)
            {
                throw new Exception("Error interno del servidor. Por favor inténtelo más tarde");
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
		
		public static Dictionary<string, object> Propiedades 
		{ 
			get { return propiedades; }
		}
    }
}