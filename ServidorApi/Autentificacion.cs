//-----------------------------------------------------------------------
// <copyright file="Autentificacion.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace Zuliaworks.Netzuela.Spuria.ServidorApi
{
    using System;
    using System.Collections.Generic;
    using System.IdentityModel.Selectors;       // UserNamePasswordValidator
    using System.IdentityModel.Tokens;          // SecurityTokenException
    using System.Linq;
    using System.ServiceModel;                  // FaultException
    using System.Web;

    /// <summary>
    /// Administra los credenciales enviados por el cliente.
    /// </summary>
    public class Autentificacion : UserNamePasswordValidator
    {
        /// <summary>
        /// Genera una excepción en caso de no reconocer los credenciales otorgados por el cliente.
        /// </summary>
        /// <param name="userName">Nombre de usuario.</param>
        /// <param name="password">Contraseña de usuario.</param>
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