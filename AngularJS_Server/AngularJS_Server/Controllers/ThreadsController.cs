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
    public class ThreadsController : ApiController
    {
        ThreadsRepository _threadRepo = new ThreadsRepository(new Entities());

        [HttpGet]
        [Route("threads")]
        public List<Thread> Get()
        {
            return _threadRepo.GetThreads();
        }

        [HttpGet]
        [Route("threads/{id}")]
        public Thread GetById(int id)
        {
            return _threadRepo.GetThreadById(id);
        }

        [HttpPost]
        [Route("threads")]
        public Thread Add(Thread thread)
        {
            return _threadRepo.AddThread(thread);
        }

        [HttpPut]
        [Route("threads/{id}")]
        public Thread Update(Thread thread, int id)
        {
            thread.Id = id;
            return _threadRepo.UpdateThread(thread);
        }
    }
}
