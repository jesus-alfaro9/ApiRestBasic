using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CrudApiRestBasico.Models
{
    public class Empleados
    {
        [Key]
        public int IdEmpleado { get; set; }
        public string Apellidos { get; set; }
        public string Nombre { get; set; }
        public string Cargo { get; set; }
        public DateTime FechaContratación { get; set; }
        public string Dirección { get; set; }
        public string Ciudad { get; set; }
        public string País { get; set; }
        public string TelDomicilio { get; set; }

    }
}
