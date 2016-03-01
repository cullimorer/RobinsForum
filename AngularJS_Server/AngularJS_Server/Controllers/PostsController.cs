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
    public class PostsController : ApiController
    {
        private PostsRepository _postRepo;

        public PostsController()
        {
            _postRepo = new PostsRepository(new Entities());
        }

        [HttpGet]
        [Route("threads/{threadId}/posts")]
        public List<Post> Get(int threadId)
        {
            return _postRepo.GetPosts(threadId);
        }

        [HttpGet]
        [Route("threads/{threadId}/posts/{id}")]
        public Post GetById(int threadId, int id)
        {
            return _postRepo.GetPostById(id);
        }

        [HttpPost]
        [Route("threads/{threadId}/posts")]
        public Post Add(Post post, int threadId)
        {
            post.ThreadId = threadId;
            return _postRepo.AddPost(post);
        }

        [HttpPut]
        [Route("threads/{threadId}/posts/{id}")]
        public Post Update(Post post, int threadId, int id)
        {
            post.Id = id;
            post.ThreadId = threadId;
            return _postRepo.UpdatePost(post);
        }
    }
}
