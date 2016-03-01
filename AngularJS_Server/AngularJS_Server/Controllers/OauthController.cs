using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AngularJS_Server.Context;
using AngularJS_Server.Context.Repositories;

namespace AngularJS_Server.Controllers
{
    public class OauthController : ApiController
    {
        OauthRepository _oauthRepo = new OauthRepository(new Entities());

        [HttpGet]
        [Route("OauthUsers")]
        public List<OauthUser> Get()
        {
            return _oauthRepo.GetUsers();
        }

        [HttpGet]
        [Route("OauthUsers/{oauthId}")]
        public OauthUser GetById(string oauthId)
        {
            return _oauthRepo.GetUserById(oauthId);
        }

        [HttpPost]
        [Route("OauthUsers")]
        public OauthUser AddOauthUser(OauthUser user)
        {
            return _oauthRepo.AddUser(user);
        }
    }
}
