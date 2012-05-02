namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security;                              // SecureString

    using Zuliaworks.Netzuela.Valeria.Comunes;          // ParametrosDeConexion
    using Zuliaworks.Netzuela.Valeria.Preferencias;     // CargarGuardar
	
	using System.Configuration;
    public static class Sesion
    {
		private static readonly ParametrosDeConexion parametros;
        //private static readonly SecureString[] credenciales;
		private static readonly string[] credenciales;

        static Sesion()
        {
            parametros = CargarGuardar.CargarParametrosDeConexion("Local");
            //credenciales = CargarGuardar.CargarCredenciales("Local");
			AutentificacionSection c = (AutentificacionSection)ConfigurationManager.GetSection("credenciales");
			
			List<string> dale = new List<string>();
			if(c != null)
			{
				foreach(UsuarioContrasenaElement usuCon in c.LlavesDeAcceso)
				{
					if(usuCon.ID == "Local")
					{
						dale.Add(usuCon.Usuario.DesencriptarS());
						dale.Add(usuCon.Contrasena.DesencriptarS());
					}
				}
			}
			
			credenciales = dale.ToArray();
					
			if (parametros == null || credenciales.Length != 2)
            {
                throw new Exception("Error interno del servidor. Por favor inténtelo más tarde");
            }
			
			throw new Exception("Usuario=" + credenciales[0] + ";Contrasena=" + credenciales[1]);
        }

        public static ParametrosDeConexion CadenaDeConexion
        {
            get { return parametros; }
		}
		
		/*
        public static SecureString[] Credenciales
        {
            get { return credenciales; }
		}
		*/
		
		public static SecureString[] Credenciales
        {
            get 
			{
				List<SecureString> asd = new List<SecureString>();
				
				foreach(string c in credenciales)
					asd.Add(c.ConvertirASecureString());
				
				return asd.ToArray(); 
			}
		}
    }
}