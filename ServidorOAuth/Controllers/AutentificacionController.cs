using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Zuliaworks.Netzuela.Spuria.ServidorOAuth;             // OAuth
using Zuliaworks.Netzuela.Spuria.ServidorOAuth.Models;      // AutorizacionModel

namespace Zuliaworks.Netzuela.Spuria.ServidorOAuth.Controllers
{
    public class AutentificacionController : Controller
    {
        //
        // GET: /Autentificacion/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Autorizar()
        {
            if (OAuth.PeticionDeAutorizacionPendiente == null)
            {
                return RedirectToAction("Index", "Inicio");
            }

            var model = new AutorizacionModel
            {
                //AplicacionConsumidora = OAuthServiceProvider.PendingAuthorizationConsumer.Name,
                PeticionInsegura = OAuth.PeticionDeAutorizacionPendiente.IsUnsafeRequest
            };

            return View(model);
        }
    }
}
