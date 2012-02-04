using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;                  // DataRowState    
using System.Reflection;            // Assembly, Type
using WcfSamples.DynamicProxy;      // DynamicProxyFactory, DynamicObject

namespace Zuliaworks.Netzuela.Spuria.ApiPublica
{
    public class DataTableXMLDinamico : DynamicObject
    {
        #region Constantes

        const string Tipo = "Zuliaworks.Netzuela.Spuria.ApiPublica.DataTableXML";
        const string BaseDeDatosPropiedad = "BaseDeDatos";
        const string NombreTablaPropiedad = "NombreTabla";
        const string EsquemaXMLPropiedad = "EsquemaXML";
        const string XMLPropiedad = "XML";
        const string EstadoFilasPropiedad = "EstadoFilas";
        const string ClavePrimariaPropiedad = "ClavePrimaria";

        #endregion

        #region Constructores

        public DataTableXMLDinamico(Assembly Ensamblado)
            : this(GetType(Ensamblado))
        {
        }

        public DataTableXMLDinamico(Type TipoDelEmpleado)
            : base(TipoDelEmpleado)
        {
            CallConstructor();
        }

        public DataTableXMLDinamico(object Datasetxml)
            : base(Datasetxml)
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

        public string EsquemaXML
        {
            get { return (string)GetProperty(EsquemaXMLPropiedad); }
            set { SetProperty(EsquemaXMLPropiedad, value); }
        }

        public string XML
        {
            get { return (string)GetProperty(XMLPropiedad); }
            set { SetProperty(XMLPropiedad, value); }
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

        public static Type GetType(Assembly Ensamblado)
        {
            return Ensamblado.GetType(Tipo, true, true);
        }

        #endregion
    }
}
