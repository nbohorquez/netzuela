namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections.Generic;
	using System.Data;
	using System.Linq;
	using System.Runtime.Serialization;
	
	using ServiceStack.FluentValidation;
	using ServiceStack.ServiceHost;							// RestService
	using ServiceStack.ServiceInterface;
	using ServiceStack.ServiceInterface.Auth;
	using ServiceStack.ServiceInterface.ServiceModel;
	using Zuliaworks.Netzuela.Spuria.TiposApi;
	using Zuliaworks.Netzuela.Valeria.Logica;
		
	[DataContract]
	[Authenticate()]
	[RestService("/escribirtabla")]
	public class EscribirTabla
	{
		[DataMember]
		public int TiendaId { get; set; }
		[DataMember]
		public DataTableXml TablaXml { get; set; }
	}
	
	public class EscribirTablaValidador : AbstractValidator<EscribirTabla>
	{		
		public EscribirTablaValidador()
		{
			RuleFor(x => x.TiendaId).NotNull().GreaterThan(0).Must(Validadores.TiendaId).WithMessage(Validadores.ERROR_TIENDA_ID);
			RuleFor(x => x.TablaXml).NotNull().SetValidator(new DataTableXmlValidador());
		}
	}
	
	public class DataTableXmlValidador : AbstractValidator<DataTableXml>
	{		
		public DataTableXmlValidador()
		{
			RuleFor(x => x.BaseDeDatos).NotNull().NotEmpty().Must(Validadores.BaseDeDatos).WithMessage(Validadores.ERROR_BASE_DE_DATOS);
			RuleFor(x => x.NombreTabla).NotNull().NotEmpty().Must((x, tabla) => Validadores.Tabla(x.BaseDeDatos, tabla)).WithMessage(Validadores.ERROR_TABLA);
			RuleFor(x => x.EsquemaXml).NotNull().NotEmpty();
			RuleFor(x => x.Xml).NotNull().NotEmpty();			
		}
	}

	[DataContract]
	public class EscribirTablaResponse : IHasResponseStatus
	{
		[DataMember]
		public bool Exito { get; set; }
		[DataMember]
		public ResponseStatus ResponseStatus { get; set; }
	}
			
	public class EscribirTablaServicio : ServiceBase<EscribirTabla>
	{
		protected override object Run (EscribirTabla request)
		{
            bool resultado = false;

            try
            {
                using (Conexion conexion = new Conexion(Sesion.CadenaDeConexion))
                {
                    conexion.Conectar(Sesion.Credenciales[0], Sesion.Credenciales[1]);

                    Permisos.DescriptorDeTabla descriptor =
                        Permisos.EntidadesPermitidas[request.TablaXml.BaseDeDatos].First(e => string.Equals(e.Nombre, request.TablaXml.NombreTabla, StringComparison.OrdinalIgnoreCase));
					
                    DataTable tablaRecibida = request.TablaXml.XmlADataTable();					
					DataTable tablaProcesada = tablaRecibida.Copy();
					
					// Si la tabla original poseia una columna tienda_id, debemos colocarsela de nuevo
					if (descriptor.TiendaId != null)
					{
						List<DataRow> filasEliminadas = new List<DataRow>();
	                    DataColumn col = new DataColumn(descriptor.TiendaId, request.TiendaId.GetType());
	                    tablaProcesada.Columns.Add(col);
						
						for (int i = 0; i < tablaProcesada.Rows.Count; i++)
						{
							if (tablaProcesada.Rows[i].RowState == DataRowState.Deleted)
							{
								tablaProcesada.Rows[i].RejectChanges();
								tablaProcesada.Rows[i][col] = request.TiendaId;
								filasEliminadas.Add(tablaProcesada.Rows[i]);
								tablaProcesada.Rows[i].AcceptChanges();
							}
							else
							{
								tablaProcesada.Rows[i][col] = request.TiendaId;
							}
						}
						
						// Agregamos tienda_id al conjunto de claves primarias
						List<DataColumn> cp = new List<DataColumn>();
						
						foreach (string pk in descriptor.ClavePrimaria)
						{
							cp.Add(tablaProcesada.Columns[pk]);
						}
						
						tablaProcesada.PrimaryKey = cp.ToArray();
						filasEliminadas.ToList().ForEach(f => f.Delete());
					}
						
					// Reordenamos las columnas
                    for (int i = 0; i < descriptor.Columnas.Length; i++)
                    {
                        tablaProcesada.Columns[descriptor.Columnas[i]].SetOrdinal(i);
                    }
					
                    conexion.EscribirTabla(request.TablaXml.BaseDeDatos, request.TablaXml.NombreTabla, tablaProcesada);
					
					tablaRecibida.Dispose();
					tablaProcesada.Dispose();
					tablaRecibida = null;
					tablaProcesada = null;
					
					resultado = true;
                }
            }
            catch (Exception ex)
            {
				//log.Fatal("Usuario: " + this.Cliente + ". Error de escritura de tabla: " + ex.Message);
                throw new Exception("Error de escritura de tabla", ex);
            }

            return new EscribirTablaResponse { Exito = resultado };
		}
	}
}