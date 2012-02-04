using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;                          // DataRowState, DataColumn
using System.Runtime.Serialization;         // DataMember, DataContract
using System.ServiceModel;
using System.ServiceModel.Web;

namespace Zuliaworks.Netzuela.Spuria.Api
{
	// Esta informacion es empleada por el servidor y los clientes
    [DataContract]
    public class DataTableXML
    {
        #region Constructores

        public DataTableXML() { }

        public DataTableXML(string BaseDeDatos, string NombreTabla, string EsquemaXML, string XML)
        {
            this.BaseDeDatos = BaseDeDatos;
            this.NombreTabla = NombreTabla;            
            this.EsquemaXML = EsquemaXML;
            this.XML = XML;
        }

        #endregion

        #region Propiedades

        [DataMember]
        public string BaseDeDatos { get; set; }
        [DataMember]
        public string NombreTabla { get; set; }
        [DataMember]
        public string EsquemaXML { get; set; }
        [DataMember]
        public string XML { get; set; }
        [DataMember]
        public DataRowState[] EstadoFilas { get; set; }
        [DataMember]
        public int[] ClavePrimaria { get; set; }

        #endregion
    }        
}
