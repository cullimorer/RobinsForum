using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AngularJS_Server.Context.Repositories
{
    public class CategoriesRepository
    {
        private Entities _serverContext;

        public CategoriesRepository(Entities context)
        {
            _serverContext = context;
        }

        public List<Category> GetCategories()
        {
            try
            {
                return _serverContext.Categories.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Category GetCategoryById(int id)
        {
            try
            {
                return _serverContext.Categories.FirstOrDefault(x => x.Id == id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Category AddCategory(Category category)
        {
            try
            {
                var result = this._serverContext.Categories.Add(category);
                this._serverContext.SaveChanges();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Category UpdateCategory(Category category)
        {
            try
            {
                var currentCategory = this._serverContext.Categories.FirstOrDefault(x => x.Id == category.Id);
                var entry = this._serverContext.Entry<Category>(currentCategory);
                entry.CurrentValues.SetValues(category);

                _serverContext.SaveChanges();
                return category;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
