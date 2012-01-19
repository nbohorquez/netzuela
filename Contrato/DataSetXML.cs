using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;         // DataMember, DataContract
using System.ServiceModel;
using System.ServiceModel.Web;

namespace Zuliaworks.Netzuela.Spuria.Contrato
{
	// Esta informacion es empleada por el servidor y los clientes
    [DataContract]
    public class DataSetXML
    {
        public DataSetXML() { }

        public DataSetXML(string BaseDeDatos, string NombreTabla, string EsquemaXML, string XML)
        {
            this.BaseDeDatos = BaseDeDatos;
            this.NombreTabla = NombreTabla;            
            this.EsquemaXML = EsquemaXML;
            this.XML = XML;
        }

        [DataMember]
        public string BaseDeDatos { get; set; }
        [DataMember]
        public string NombreTabla { get; set; }
        [DataMember]
        public string EsquemaXML { get; set; }
        [DataMember]
        public string XML { get; set; }
    }
}
