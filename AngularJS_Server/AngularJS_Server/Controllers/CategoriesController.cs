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
    public class CategoriesController : ApiController
    {
        CategoriesRepository _categoryRepo = new CategoriesRepository(new Entities());

        [HttpGet]
        [Route("categories")]
        public List<Category> Get()
        {
            return _categoryRepo.GetCategories();
        }

        [HttpGet]
        [Route("categories/{id}")]
        public Category GetById(int id)
        {
            return _categoryRepo.GetCategoryById(id);
        }

        [HttpPost]
        [Route("categories")]
        public Category Add(Category category)
        {
            return _categoryRepo.AddCategory(category);
        }

        [HttpPut]
        [Route("categories/{id}")]
        public Category Update(Category category, int id)
        {
            category.Id = id;
            return _categoryRepo.UpdateCategory(category);
        }
    }
}
