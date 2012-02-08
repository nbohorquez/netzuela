namespace Zuliaworks.Netzuela.Spuria.ServidorApi
{
    using System;
    using System.Collections.Generic;
    using System.IdentityModel.Selectors;       // UserNamePasswordValidator
    using System.IdentityModel.Tokens;          // SecurityTokenException
    using System.Linq;
    using System.ServiceModel;                  // FaultException
    using System.Web;

    public class Autentificacion : UserNamePasswordValidator
    {
        public override void Validate(string userName, string password)
        {
            if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
            {
                throw new SecurityTokenException("Se requiere usuario y contraseña");
            }

            if (!(userName == "prueba" && password == "1234"))
            {
                throw new FaultException(string.Format("Usuario ({0}) o contraseña incorrecta", userName));
            }
        }
    }
}