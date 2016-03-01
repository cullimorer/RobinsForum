// --------------------------------------------------------------------------------------------------------------------
// <copyright file="BundleConfig.cs" company="KriaSoft LLC">
//   Copyright © 2013 Konstantin Tarkus, KriaSoft LLC. See LICENSE.txt
// </copyright>
// --------------------------------------------------------------------------------------------------------------------

namespace App.Web
{
    using System.Web;
    using System.Web.Optimization;

    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/content/css/app").Include(
                "~/content/app.css",
                "~/content/forum.css"));

            bundles.Add(new ScriptBundle("~/js/jquery").Include(
                "~/scripts/vendor/jquery-{version}.js", 
                "~/scripts/bootbox.js"));

            bundles.Add(new ScriptBundle("~/js/app").Include(
                "~/scripts/vendor/angular-ui-router.js",
                "~/scripts/app/filters.js",
                "~/scripts/app/app.js",
                "~/scripts/app/Shared/controllers/*.js",
                "~/scripts/app/Shared/services/*.js",
                "~/scripts/app/Shared/directives/*.js",
                "~/scripts/app/Forum/controllers/*.js",
                "~/scripts/app/Forum/services/*.js",
                "~/scripts/app/Forum/directives/*.js",
                "~/scripts/app/Login/controllers/*.js",
                "~/scripts/app/Login/services/*.js",
                "~/scripts/app/Login/directives/*.js"               
                ));
        }
    }
}