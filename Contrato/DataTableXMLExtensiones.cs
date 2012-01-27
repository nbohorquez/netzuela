using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;                          // DataTable, DataSet, DataRowCollection, DataRowState
using System.IO;                            // MemoryStream

namespace Zuliaworks.Netzuela.Spuria.Contrato
{
    public static class DataTableXMLExtensiones
    {
        #region Funciones

        public static DataTable XmlADataTable(this DataTableXML TablaXML)
        {
            DataTable Tabla = null;

            try
            {
                DataSet SetTemporal = new DataSet();

                SetTemporal.ReadXmlSchema(new MemoryStream(Encoding.Unicode.GetBytes(TablaXML.EsquemaXML)));
                SetTemporal.ReadXml(new MemoryStream(Encoding.Unicode.GetBytes(TablaXML.XML)));

                Tabla = SetTemporal.Tables[0];
                Tabla.AcceptChanges();

                DataRowCollection Fila = Tabla.Rows;

                for (int i = 0; i < Fila.Count; i++)
                {
                    switch (TablaXML.EstadoFilas[i])
                    {
                        case DataRowState.Added:
                            Fila[i].SetAdded();
                            break;
                        case DataRowState.Deleted:
                            Fila[i].Delete();
                            break;
                        case DataRowState.Detached:
                            //Fila[i].Delete();
                            break;
                        case DataRowState.Modified:
                            Fila[i].SetModified();
                            break;
                        case DataRowState.Unchanged:
                            break;
                        default:
                            throw new Exception("No se reconoce el estado de la fila");
                    }
                }

                List<DataColumn> Columnas = new List<DataColumn>();

                foreach(int Columna in TablaXML.ClavePrimaria)
                {
                    Columnas.Add(Tabla.Columns[Columna]);
                }

                Tabla.PrimaryKey = Columnas.ToArray();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al convertir el DataTableXML a un DataTable", ex);
            }

            return Tabla;
        }

        public static DataTableXML DataTableAXml(this DataTable Tabla, string BaseDeDatos, string NombreTabla)
        {
            DataTableXML DatosAEnviar = null;

            try
            {
                DataSet SetTemporal = null;

                if (Tabla.DataSet != null)
                {
                    SetTemporal = Tabla.DataSet;
                }
                else
                {
                    SetTemporal = new DataSet(NombreTabla);
                    SetTemporal.Tables.Add(Tabla);
                }

                DatosAEnviar = new DataTableXML(BaseDeDatos, NombreTabla, SetTemporal.GetXmlSchema(), SetTemporal.GetXml());
                List<DataRowState> EstadoFilas = new List<DataRowState>();

                foreach (DataRow Fila in Tabla.Rows)
                {
                    EstadoFilas.Add(Fila.RowState);
                }

                DatosAEnviar.EstadoFilas = EstadoFilas.ToArray();

                List<int> ClavePrimaria = new List<int>();

                foreach (DataColumn Columna in Tabla.PrimaryKey)
                {
                    ClavePrimaria.Add(Columna.Ordinal);
                }

                DatosAEnviar.ClavePrimaria = ClavePrimaria.ToArray();
                
            }
            catch (Exception ex)
            {
                throw new Exception("Error al convertir el DataTable a un DataTableXML", ex);
            }

            return DatosAEnviar;
        }

        #endregion
    }
}
