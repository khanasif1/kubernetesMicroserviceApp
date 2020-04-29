using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using k8.kubernetesWorld.Web.Models;
using System.Net.Http;
using Newtonsoft.Json;
using Microsoft.Extensions.Configuration;

namespace k8.kubernetesWorld.Web.Controllers
{
    public class ProductController : Controller
    {
        private readonly ILogger<ProductController> _logger;
        public IConfiguration Configuration { get; }
        public ProductController(ILogger<ProductController> logger, IConfiguration configuration)
        {
            _logger = logger;
            Configuration = configuration;

        }
        public async Task<IActionResult> Index()
        {
            string apiBase = Configuration.GetSection("AppSettings").GetSection("product").Value;
            List<Product.Product> productList = new List<Product.Product>();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync(
                    $"{apiBase}" +
                    //"http://localhost:2148" +
                    "/api/Product")
                    )
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    productList = JsonConvert.DeserializeObject<List<Product.Product>>(apiResponse);
                }
            }
            //List<Product.Product> productList = new List<Product.Product>() {
            //    new Product.Product { ID = 1, Name = "Car", Description = "Ford", EnrollmentDate = DateTime.Now },
            //    new Product.Product { ID = 1, Name = "Truck", Description = "Tesla", EnrollmentDate = DateTime.Now },
            //    new Product.Product { ID = 1, Name = "Plane", Description = "Boing", EnrollmentDate = DateTime.Now },
            //    new Product.Product { ID = 1, Name = "Bike", Description = "Ducati", EnrollmentDate = DateTime.Now }
            //};
            return View(productList);
        }
    }
}