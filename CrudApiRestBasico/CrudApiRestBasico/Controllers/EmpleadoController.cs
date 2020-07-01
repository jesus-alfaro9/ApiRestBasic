using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CrudApiRestBasico.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
        public ActionResult Post([FromBody]Empleados empleado)
        {
            try
            {
                context.Empleados.Add(empleado);
                context.SaveChanges();
                return Ok();
            }
            catch (Exception)
            {
                return BadRequest();
              
            }

        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody]Empleados empleado)
        {
            if (empleado.IdEmpleado== id)
            {
                context.Entry(empleado).State = EntityState.Modified;
                context.SaveChanges();
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var empleado = context.Empleados.FirstOrDefault(p => p.IdEmpleado == id);

            if (empleado!= null)
            {
                context.Empleados.Remove(empleado);
                context.SaveChanges();
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
