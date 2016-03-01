using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AngularJS_Server.Context.Repositories
{
    public class ThreadsRepository
    {
        private Entities _serverContext;

        public ThreadsRepository(Entities context)
        {
            _serverContext = context;
        }

        public List<Thread> GetThreads()
        {
            try
            {
                return _serverContext.Threads.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Thread GetThreadById(int id)
        {
            try
            {
                return _serverContext.Threads.FirstOrDefault(x => x.Id == id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Thread AddThread(Thread thread)
        {
            try
            {
                var result = this._serverContext.Threads.Add(thread);
                this._serverContext.SaveChanges();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Thread UpdateThread(Thread thread)
        {
            try
            {
                var currentThread = this._serverContext.Threads.FirstOrDefault(x => x.Id == thread.Id);
                var entry = this._serverContext.Entry<Thread>(currentThread);
                entry.CurrentValues.SetValues(thread);

                _serverContext.SaveChanges();
                return thread;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
