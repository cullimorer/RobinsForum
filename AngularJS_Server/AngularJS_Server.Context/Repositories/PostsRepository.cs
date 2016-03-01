using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AngularJS_Server.Context.Repositories
{
    public class PostsRepository
    {
        private Entities _serverContext;

        public PostsRepository(Entities context)
        {
            _serverContext = context;
        }

        public List<Post> GetPosts(int threadId)
        {
            try
            {
                return _serverContext.Posts.Where(x => x.ThreadId == threadId).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Post GetPostById(int id)
        {
            try
            {
                return _serverContext.Posts.FirstOrDefault(x => x.Id == id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Post AddPost(Post post)
        {
            try
            {
                var result = this._serverContext.Posts.Add(post);
                this._serverContext.SaveChanges();
                result.OauthUser = this._serverContext.OauthUsers.FirstOrDefault(x => x.Id == result.OauthUserId);
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Post UpdatePost(Post post)
        {
            try
            {
                var currentPost = this._serverContext.Posts.FirstOrDefault(x => x.Id == post.Id);
                var entry = this._serverContext.Entry<Post>(currentPost);
                entry.CurrentValues.SetValues(post);

                _serverContext.SaveChanges();
                return post;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
