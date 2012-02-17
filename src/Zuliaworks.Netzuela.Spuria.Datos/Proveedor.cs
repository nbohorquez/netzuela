namespace Zuliaworks.Netzuela.Spuria.Datos
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    public class Proveedor
    {
        #region Variables

        private static SpuriaEntities spuria;
       
        #endregion

        #region Constructores

        static Proveedor()
        {
            spuria = new SpuriaEntities();
        }

        #endregion

        #region Propiedades

        public static SpuriaEntities Spuria
        {
            get { return spuria; }
        }

        #endregion
    }
}
