using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CrudApiRestBasico.Models;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CrudApiRestBasico.Controllers
{
    [Route("api/[controller]")]
    public class EmpleadoController : Controller
    {
        private readonly AplicationDBContext context;
        public EmpleadoController(AplicationDBContext context)
        {
            this.context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public IEnumerable<Empleados> Get()
        {

            return context.Empleados.ToList();
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public Empleados Get(int id)
        {
            var empleado = context.Empleados.FirstOrDefault(e => e.IdEmpleado == id);
            return empleado;
        }

        // POST api/<controller>
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
