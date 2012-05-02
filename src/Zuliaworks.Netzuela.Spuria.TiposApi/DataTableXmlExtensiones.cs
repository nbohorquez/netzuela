namespace Zuliaworks.Netzuela.Spuria.TiposApi
{
    using System;
    using System.Collections.Generic;
    using System.Data;                  // DataTable, DataSet, DataRowCollection, DataRowState
    using System.IO;                    // MemoryStream
    using System.Linq;
    using System.Text;
    
    public static class DataTableXmlExtensiones
    {
        #region Funciones

        public static DataTable XmlADataTable(this DataTableXml tablaXml)
        {
            /*
             * Con codigo de: http://pstaev.blogspot.com/2008/04/passing-dataset-to-wcf-method.html
             */

            DataTable tabla = null;

            try
            {
                DataSet setTemporal = new DataSet();

                setTemporal.ReadXmlSchema(new MemoryStream(Encoding.Unicode.GetBytes(tablaXml.EsquemaXml)));
                setTemporal.ReadXml(new MemoryStream(Encoding.Unicode.GetBytes(tablaXml.Xml)));

                tabla = setTemporal.Tables[0];
                tabla.AcceptChanges();

                DataRowCollection fila = tabla.Rows;

                for (int i = 0; i < fila.Count; i++)
                {
                    switch (tablaXml.EstadoFilas[i])
                    {
                        case DataRowState.Added:
                            fila[i].SetAdded();
                            break;
                        case DataRowState.Deleted:
                            fila[i].Delete();
                            break;
                        case DataRowState.Detached:
                            // Fila[i].Delete();
                            break;
                        case DataRowState.Modified:
                            fila[i].SetModified();
                            break;
                        case DataRowState.Unchanged:
                            break;
                        default:
                            throw new Exception("No se reconoce el estado de la fila");
                    }
                }

                List<DataColumn> columnas = new List<DataColumn>();

                foreach (int columna in tablaXml.ClavePrimaria)
                {
                    columnas.Add(tabla.Columns[columna]);
                }

                tabla.PrimaryKey = columnas.ToArray();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al convertir el DataTableXML a un DataTable", ex);
            }

            return tabla;
        }

        public static DataTableXml DataTableAXml(this DataTable tabla, string baseDeDatos, string nombreTabla)
        {
            DataTableXml datosAEnviar = null;

            try
            {
                DataSet setTemporal = null;

                if (tabla.DataSet != null)
                {
                    setTemporal = tabla.DataSet;
                }
                else
                {
                    setTemporal = new DataSet(nombreTabla);
                    setTemporal.Tables.Add(tabla);
                }

                datosAEnviar = new DataTableXml(baseDeDatos, nombreTabla, setTemporal.GetXmlSchema(), setTemporal.GetXml());
                List<DataRowState> estadoFilas = new List<DataRowState>();

                foreach (DataRow fila in tabla.Rows)
                {
                    estadoFilas.Add(fila.RowState);
                }

                datosAEnviar.EstadoFilas = estadoFilas.ToArray();

                List<int> clavePrimaria = new List<int>();

                foreach (DataColumn columna in tabla.PrimaryKey)
                {
                    clavePrimaria.Add(columna.Ordinal);
                }

                datosAEnviar.ClavePrimaria = clavePrimaria.ToArray();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al convertir el DataTable a un DataTableXML", ex);
            }

            return datosAEnviar;
        }
		
		public static object ConvertirEnObjetoDinamico(this DataTableXml xml, System.Reflection.Assembly ensamblado)
		{
			DataTableXmlDinamico dinamico = new	DataTableXmlDinamico(ensamblado);
			dinamico.BaseDeDatos = xml.BaseDeDatos;
			dinamico.NombreTabla = xml.NombreTabla;
			dinamico.EsquemaXml = xml.EsquemaXml;
			dinamico.Xml = xml.Xml;
			dinamico.EstadoFilas = xml.EstadoFilas;
			dinamico.ClavePrimaria = xml.ClavePrimaria;
			
			return dinamico.ObjectInstance;
		}
		
        #endregion
    }
}
