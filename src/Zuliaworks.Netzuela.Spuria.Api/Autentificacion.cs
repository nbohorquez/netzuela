//-----------------------------------------------------------------------
// <copyright file="Autentificacion.cs" company="Zuliaworks">
//     Copyright (c) Zuliaworks. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace Zuliaworks.Netzuela.Spuria.Api
{
    using System;
    using System.Collections.Generic;
    using System.Data;                              // DataTable
    using System.IdentityModel.Selectors;           // UserNamePasswordValidator
    using System.IdentityModel.Tokens;              // SecurityTokenException
    using System.Linq;
    using System.ServiceModel;                      // FaultException
    using System.Web;

    using Zuliaworks.Netzuela.Valeria.Logica;       // Conexion

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
            using (Conexion conexion = new Conexion(Sesion.CadenaDeConexion))
            {
                conexion.Conectar(Sesion.Credenciales[0], Sesion.Credenciales[1]);

                if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
                {
                    throw new SecurityTokenException("Se requiere usuario y contraseña");
                }

                string sql = "SELECT AccesoID FROM Acceso WHERE CorreoElectronico = '" + userName + "' AND Contrasena = '" + password + "'";
                DataTable t = conexion.Consultar("spuria", sql);

                if (t.Rows.Count != 1)
                {
                    throw new FaultException(string.Format("Usuario ({0}) o contraseña incorrecta", userName));
                }
                
                /*
                acceso acceso = Proveedor.Spuria.acceso.DefaultIfEmpty(null).FirstOrDefault(a => a.CorreoElectronico == userName);

                if (acceso == null)
                {
                    throw new FaultException(string.Format("Usuario ({0}) o contraseña incorrecta", userName));
                }

                if (acceso.Contrasena != password)
                {
                    throw new FaultException(string.Format("Usuario ({0}) o contraseña incorrecta", userName));
                }
                 */
            }
        }
    }
}