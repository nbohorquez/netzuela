namespace Zuliaworks.Netzuela.Spuria.Api
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Runtime.Serialization;
	
	using ServiceStack.FluentValidation;
	using ServiceStack.ServiceHost;							// RestService
	using ServiceStack.ServiceInterface;
	using ServiceStack.ServiceInterface.ServiceModel;
	using Zuliaworks.Netzuela.Valeria.Logica;
	
	[DataContract]
	[Authenticate()]
	[RestService("/listartablas")]
	public class ListarTablas
	{
		[DataMember]
		public string BaseDeDatos { get; set; }
	}

	public class ListarTablasValidador : AbstractValidator<ListarTablas> 
	{		
		public ListarTablasValidador()
		{
			RuleFor(x => x.BaseDeDatos).NotNull().NotEmpty().Must(Validadores.BaseDeDatos).WithMessage(Validadores.ERROR_BASE_DE_DATOS);
		}
	}

	[DataContract]
	public class ListarTablasResponse : IHasResponseStatus
	{
		[DataMember]
		public string[] Tablas { get; set; }
		[DataMember]
		public ResponseStatus ResponseStatus { get; set; }
	}
	
	public class ListarTablasServicio : ServiceBase<ListarTablas>
	{
		#region Funciones
		
		protected override object Run (ListarTablas request)
		{
			Sesion.Usuario = int.Parse(this.GetSession().FirstName);
			ListarTablasValidador validador = new ListarTablasValidador();
			validador.ValidateAndThrow(request);
			
			List<string> resultado = new List<string>();

			try
            {
                using (Conexion conexion = new Conexion(Sesion.CadenaDeConexion))
                {
                    conexion.Conectar(Sesion.Credenciales[0], Sesion.Credenciales[1]);
                    string[] tablas = conexion.ListarTablas(request.BaseDeDatos);

                    var tablasAMostrar = (from tabla in tablas
                                          where Permisos.EntidadesPermitidas[request.BaseDeDatos].Any(t => string.Equals(t.Nombre, tabla, StringComparison.OrdinalIgnoreCase))
                                          select tabla).ToList();

                    resultado = tablasAMostrar;
                }
            }
            catch (Exception ex)
            {
				//log.Fatal("Usuario: " + this.Cliente + ". Error de listado de base de tablas: " + ex.Message);
                throw new Exception("Error de listado de tablas", ex);
            }

            return new ListarTablasResponse { Tablas = resultado.ToArray() };
		}
		
		#endregion
	}
}