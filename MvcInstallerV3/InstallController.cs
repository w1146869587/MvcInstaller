﻿// Copyright (c) 2010, Gizmo Beach.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// - Neither  the  name  of  the  Gizmo Beach  nor   the   names  of  its
//   contributors may be used to endorse or  promote  products  derived  from  this
//   software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT  NOT  LIMITED TO, THE IMPLIED
// WARRANTIES  OF  MERCHANTABILITY   AND  FITNESS  FOR  A  PARTICULAR  PURPOSE  ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT  OF  SUBSTITUTE  GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)  HOWEVER  CAUSED AND ON
// ANY  THEORY  OF  LIABILITY,  WHETHER  IN  CONTRACT,  STRICT  LIABILITY,  OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE)  ARISING  IN  ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

using System;
using System.Web.Mvc;

using MvcInstaller.Settings;

namespace MvcInstaller
{
    public class InstallController : Controller
    {
        private string path;

        public ActionResult Index()
        {
            // Now check if the application has already been installed.
            if (InstallWizard.Installed)
            {
                return RedirectToAction("Index", "Home");
            }

            path = Server.MapPath("~/");

            // Deserialize the installer.config xml file.
            InstallerConfig config = Serializer<InstallerConfig>.Deserialize(path + @"installer.config");

            return View(config);
        }

        /// <summary>
        /// This action method is called from an Ajax request in the 
        /// /install/index.aspx view to run the installation.
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Run()
        {
            // Set the base path of the web application.
            path = Server.MapPath("~/");

            // Deserialize the installer.config xml file.
            InstallerConfig config = Serializer<InstallerConfig>.Deserialize(path + @"installer.config");
            config.Path.AppPath = path;  // set this for internal processing.

            JsonResponse json = new JsonResponse();

            try
            {
                // Run the installer.
                InstallWizard.Run(config);

                json.Success = true;
                json.Message = "The installer completed successfully!";
            }
            catch (Exception ex)
            {
                json.Success = false;
                json.Message = ex.Message;
                Log.Exception(ex);
            }

            return Json(json);
        }
    }
}
