namespace Zuliaworks.Netzuela.Spuria.TiposApi
{
    using System;
    using System.Collections.Generic;
    using System.Data;                          // DataRowState, DataColumn
    using System.Linq;
    using System.Runtime.Serialization;         // DataMember, DataContract
    using System.ServiceModel;
    using System.ServiceModel.Web;
    using System.Text;

    [DataContract(Namespace = Constantes.Namespace)]
    public class DataTableXml
    {
        #region Constructores

        public DataTableXml() 
        { 
        }

        public DataTableXml(string baseDeDatos, string nombreTabla, string esquemaXml, string xml)
        {
            this.BaseDeDatos = baseDeDatos;
            this.NombreTabla = nombreTabla;
            this.EsquemaXml = esquemaXml;
            this.Xml = xml;
        }
		
		public DataTableXml(DataTableXmlDinamico dinamico)
		{
			this.BaseDeDatos = dinamico.BaseDeDatos;
			this.NombreTabla = dinamico.NombreTabla;
			this.EsquemaXml = dinamico.EsquemaXml;
			this.Xml = dinamico.Xml;
			this.EstadoFilas = dinamico.EstadoFilas;
			this.ClavePrimaria = dinamico.ClavePrimaria;
		}

        #endregion

        #region Propiedades

        [DataMember]
        public string BaseDeDatos { get; set; }
        [DataMember]
        public string NombreTabla { get; set; }
        [DataMember]
        public string EsquemaXml { get; set; }
        [DataMember]
        public string Xml { get; set; }
        [DataMember]
        public DataRowState[] EstadoFilas { get; set; }
        [DataMember]
        public int[] ClavePrimaria { get; set; }

        #endregion
    }        
}
