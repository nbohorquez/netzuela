using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Zuliaworks.Netzuela.Spuria.ServidorOAuth.Models
{
    public class AutorizacionModel
    {
        #region Propiedades

        public string AplicacionConsumidora { get; set; }
        public bool Aprobado { get; set; }
        public bool PeticionInsegura { get; set; }
        public string CodigoDeVerificacion { get; set; }

        #endregion
    }
}