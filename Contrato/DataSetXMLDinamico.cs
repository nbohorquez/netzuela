using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using WcfSamples.DynamicProxy;                      // DynamicProxyFactory, DynamicObject
using System.Reflection;                            // Assembly, Type

namespace Zuliaworks.Netzuela.Spuria.Contrato
{
    public class DataSetXMLDinamico : DynamicObject
    {
        #region Constantes

        const string Tipo = "Zuliaworks.Netzuela.Spuria.Contrato.DataSetXML";
        const string BaseDeDatosPropiedad = "BaseDeDatos";
        const string NombreTablaPropiedad = "NombreTabla";
        const string EsquemaXMLPropiedad = "EsquemaXML";
        const string XMLPropiedad = "XML";
        const string EstadoFilasPropiedad = "EstadoFilas";

        #endregion

        #region Constructores

        public DataSetXMLDinamico(Assembly Ensamblado)
            : this(GetType(Ensamblado))
        {
        }

        public DataSetXMLDinamico(Type TipoDelEmpleado)
            : base(TipoDelEmpleado)
        {
            CallConstructor();
        }

        public DataSetXMLDinamico(object Datasetxml)
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

        public DataSetXML.EstadoFila[] EstadoFilas
        {
            get { return (DataSetXML.EstadoFila[])GetProperty(EstadoFilasPropiedad); }
            set { SetProperty(EstadoFilasPropiedad, value); }
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
