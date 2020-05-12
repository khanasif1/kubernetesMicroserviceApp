using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace k8.kubernetesWorld.Web.Controllers
{
    public class StaffController : Controller
    {
        private readonly ILogger<StaffController> _logger;
        public IConfiguration Configuration { get; }
        public StaffController(ILogger<StaffController> logger, IConfiguration configuration)
        {
            _logger = logger;
            Configuration = configuration;

        }
        public async Task<IActionResult> Index()
        {
            string apiBase = Configuration.GetSection("AppSettings").GetSection("staff").Value;
            List<Staff> productList = new List<Staff>();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync(
                    $"{apiBase}" +
                    //"http://localhost:5652" +
                    "/api/Staff")
                    )
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    productList = JsonConvert.DeserializeObject<List<Staff>>(apiResponse);
                }
            }
            //List<Employee.Employee> productList = new List<Employee.Employee>() {
            //    new Employee.Employee { ID = 1, FirstName = "Car", LastName = "Ford", EnrollmentDate = DateTime.Now },
            //    new Employee.Employee { ID = 1, FirstName = "Truck",LastName = "Tesla", EnrollmentDate = DateTime.Now },
            //    new Employee.Employee { ID = 1, FirstName = "Plane",LastName = "Boing", EnrollmentDate = DateTime.Now },
            //    new Employee.Employee { ID = 1, FirstName = "Bike", LastName= "Ducati", EnrollmentDate = DateTime.Now }
            //};
            return View(productList);
        }
    }
}