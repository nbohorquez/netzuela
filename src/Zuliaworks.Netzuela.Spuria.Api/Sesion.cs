namespace Zuliaworks.Netzuela.Spuria.Api
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;                              // SecureString
    using System.Web;

    using Zuliaworks.Netzuela.Valeria.Comunes;          // ParametrosDeConexion
    using Zuliaworks.Netzuela.Valeria.Preferencias;     // CargarGuardar

    public static class Sesion
    {
        private static readonly ParametrosDeConexion parametros;
        private static readonly SecureString[] credenciales;

        static Sesion()
        {
            parametros = CargarGuardar.CargarParametrosDeConexion("Local");
            credenciales = CargarGuardar.CargarCredenciales("Local");

            if (parametros == null || !(credenciales.Length > 0))
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
    }
}