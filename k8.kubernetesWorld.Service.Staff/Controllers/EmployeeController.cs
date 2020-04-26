using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using k8.kubernetesWorld.Service.Employee.EFModel;
using k8.kubernetesWorld.Service.Employee.Data;

namespace k8.kubernetesWorld.Service.Employee.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private readonly ILogger<object> _logger;
        public IConfiguration Configuration { get; }
        public EmployeeController(ILogger<object> logger, IConfiguration configuration)
        {
            _logger = logger;
            Configuration = configuration;
        }

        [HttpGet]
        public List<EFModel.Employee> Get()
        {
            List<EFModel.Employee> _response = new List<EFModel.Employee>();
            try
            {
                DbInitializer.Initialize(Configuration);
                using (SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DefaultConnection")))
                {
                    connection.Open();
                    Console.WriteLine("Connected successfully.");
                    using (SqlCommand command = new SqlCommand("USE employeeDB; Select * from [Employee];", connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                _response.Add(new EFModel.Employee 
                                { 
                                    ID=Convert.ToInt32(reader.GetInt64(0)),
                                    FirstName = reader.GetString(1),
                                    LastName = reader.GetString(2),
                                    EnrollmentDate=reader.GetDateTime(3)
                                });
                            }
                        }
                    }
                }                
            }
            catch (Exception ex)
            {
                _response.Add(new EFModel.Employee { _message = ex.Message.ToString() });

            }
            return _response;
        }
    }
}