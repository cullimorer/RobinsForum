using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AngularJS_Server.Context.Repositories
{
    public class OauthRepository
    {
        private Entities _serverContext;

        public OauthRepository(Entities context)
        {
            _serverContext = context;
        }
        
        public List<OauthUser> GetUsers()
        {
            try
            {
                return this._serverContext.OauthUsers.ToList();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public OauthUser GetUserById(string oauthId)
        {
            try
            {
                return this._serverContext.OauthUsers.FirstOrDefault(x => x.OauthId == oauthId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public OauthUser AddUser(OauthUser user)
        {
            try
            {
                var currentUser = this._serverContext.OauthUsers.FirstOrDefault(x => x.OauthId == user.OauthId);                
                if (currentUser != null)
                {
                    user.Id = currentUser.Id;
                    var entry = this._serverContext.Entry<OauthUser>(currentUser);
                    entry.CurrentValues.SetValues(user);
                    
                    _serverContext.SaveChanges();
                    return user;
                }
                else
                {
                    var result = this._serverContext.OauthUsers.Add(user);
                    this._serverContext.SaveChanges();
                    return result;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
