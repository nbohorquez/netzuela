using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetOpenAuth.Messaging;                 // MessageReceivingEndpoint
using DotNetOpenAuth.OAuth;                     // ServiceProvider
using DotNetOpenAuth.OAuth.ChannelElements;     // HmacSha1SigningBindingElement
using DotNetOpenAuth.OAuth.Messages;            // UserAuthorizationRequest, AuthorizedTokenRequest
using System.Web.SessionState;                  // IRequiresSessionState

namespace Zuliaworks.Netzuela.Spuria.ServidorOAuth
{
    /// <summary>
    /// Descripción breve de OAuth
    /// </summary>
    public class OAuth : IHttpHandler, IRequiresSessionState
    {
        #region Variables
        
        private ServiceProvider _Proveedor;
        private readonly Uri _UrlRaiz;
        private readonly ServiceProviderDescription _AutoDescripcion;
        private const string ClavePeticionDeAutorizacionPendienteDeSesion = "PeticionDeAutorizacionPendiente";

        #endregion

        #region Constructores

        public OAuth()
        {
            string _StringRaiz = HttpContext.Current.Request.ApplicationPath;
            if (!_StringRaiz.EndsWith("/", StringComparison.Ordinal))
            {
                _StringRaiz += "/";
            }

            _UrlRaiz = new Uri(HttpContext.Current.Request.Url, _StringRaiz);

            _AutoDescripcion = new ServiceProviderDescription
            {
                AccessTokenEndpoint = new MessageReceivingEndpoint(new Uri(_UrlRaiz, "/OAuth.ashx"), HttpDeliveryMethods.PostRequest),
                RequestTokenEndpoint = new MessageReceivingEndpoint(new Uri(_UrlRaiz, "/OAuth.ashx"), HttpDeliveryMethods.PostRequest),
                UserAuthorizationEndpoint = new MessageReceivingEndpoint(new Uri(_UrlRaiz, "/OAuth.ashx"), HttpDeliveryMethods.PostRequest),
                TamperProtectionElements = new ITamperProtectionChannelBindingElement[] { new HmacSha1SigningBindingElement() }
            };

            _Proveedor = new ServiceProvider(_AutoDescripcion, new AdministradorDeTokens());
        }

        #endregion

        #region Propiedades

        public bool IsReusable
        {
            get { return true; }
        }

        public static UserAuthorizationRequest PeticionDeAutorizacionPendiente
        {
            get { return HttpContext.Current.Session[ClavePeticionDeAutorizacionPendienteDeSesion] as UserAuthorizationRequest; }
            set { HttpContext.Current.Session[ClavePeticionDeAutorizacionPendienteDeSesion] = value; }
        }

        #endregion

        #region Funciones

        public void ProcessRequest(HttpContext context)
        {
            UnauthorizedTokenRequest PeticionDeToken;
            UserAuthorizationRequest PeticionDeAutorizacion;
            AuthorizedTokenRequest PeticionDeTokenDeAcceso;

            try
            {
                IProtocolMessage Peticion = _Proveedor.ReadRequest();

                if ((PeticionDeToken = Peticion as UnauthorizedTokenRequest) != null)
                {
                    var Respuesta = _Proveedor.PrepareUnauthorizedTokenMessage(PeticionDeToken);
                    _Proveedor.Channel.Send(Respuesta);
                }
                else if ((PeticionDeAutorizacion = Peticion as UserAuthorizationRequest) != null)
                {
                    PeticionDeAutorizacionPendiente = PeticionDeAutorizacion;
                    HttpContext.Current.Response.Redirect("~/Autentificacion/Autorizar");
                }
                else if ((PeticionDeTokenDeAcceso = Peticion as AuthorizedTokenRequest) != null)
                {
                    var Respuesta = _Proveedor.PrepareAccessTokenMessage(PeticionDeTokenDeAcceso);
                    _Proveedor.Channel.Send(Respuesta);
                }
                else
                {
                    throw new InvalidOperationException();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al procesar la petición", ex);
            }
        }

        #endregion
    }
}