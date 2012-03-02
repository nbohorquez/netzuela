namespace Zuliaworks.Netzuela.Spuria.Api
{
    using System;
    using System.Collections.Generic;
    using System.Data;                  // DataRowState
    using System.Linq;
    using System.Reflection;            // Assembly, Type
    using System.Text;

    using WcfSamples.DynamicProxy;      // DynamicProxyFactory, DynamicObject

    public class DataTableXmlDinamico : DynamicObject
    {
        #region Constantes

        private const string Tipo = "Zuliaworks.Netzuela.Spuria.Api.DataTableXml";
        private const string BaseDeDatosPropiedad = "BaseDeDatos";
        private const string NombreTablaPropiedad = "NombreTabla";
        private const string EsquemaXmlPropiedad = "EsquemaXml";
        private const string XmlPropiedad = "Xml";
        private const string EstadoFilasPropiedad = "EstadoFilas";
        private const string ClavePrimariaPropiedad = "ClavePrimaria";

        #endregion

        #region Constructores

        public DataTableXmlDinamico(Assembly ensamblado)
            : this(GetType(ensamblado))
        {
        }

        public DataTableXmlDinamico(Type tipoDelEmpleado)
            : base(tipoDelEmpleado)
        {
            CallConstructor();
        }

        public DataTableXmlDinamico(object dataTableXml)
            : base(dataTableXml)
        {
        }

        #endregion

        #region Propiedades

        public string BaseDeDatos
        {
            get { return (string)GetProperty(BaseDeDatosPropiedad); }
            set { SetProperty(BaseDeDatosPropiedad, value); }
        }

        public string NombreTabla
        {
            get { return (string)GetProperty(NombreTablaPropiedad); }
            set { SetProperty(NombreTablaPropiedad, value); }
        }

        public string EsquemaXml
        {
            get { return (string)GetProperty(EsquemaXmlPropiedad); }
            set { SetProperty(EsquemaXmlPropiedad, value); }
        }

        public string Xml
        {
            get { return (string)GetProperty(XmlPropiedad); }
            set { SetProperty(XmlPropiedad, value); }
        }

        public DataRowState[] EstadoFilas
        {
            get { return (DataRowState[])GetProperty(EstadoFilasPropiedad); }
            set { SetProperty(EstadoFilasPropiedad, value); }
        }

        public int[] ClavePrimaria
        {
            get { return (int[])GetProperty(ClavePrimariaPropiedad); }
            set { SetProperty(ClavePrimariaPropiedad, value); }
        }

        #endregion

        #region Funciones

        public static Type GetType(Assembly ensamblado)
        {
            return ensamblado.GetType(Tipo, true, true);
        }

        #endregion
    }
}
