using CrudApiRestBasico.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CrudApiRestBasico
{
    public class AplicationDBContext:DbContext
    {
        public AplicationDBContext(DbContextOptions<AplicationDBContext> options) : base(options)
        {
                
        }
        public DbSet<Empleados> Empleados{ get; set; }

    }
}
