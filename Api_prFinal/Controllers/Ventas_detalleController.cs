using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Api_prFinal.Models;

namespace Api_prFinal.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Ventas_detalleController : ControllerBase
    {
        private readonly Conexiones _context;

        public Ventas_detalleController(Conexiones context)
        {
            _context = context;
        }

        // GET: api/Ventas_detalle
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Ventas_detalle>>> GetVentas_detalle()
        {
            return await _context.Ventas_detalle.ToListAsync();
        }

        // GET: api/Ventas_detalle/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Ventas_detalle>> GetVentas_detalle(long id)
        {
            var ventas_detalle = await _context.Ventas_detalle.FindAsync(id);

            if (ventas_detalle == null)
            {
                return NotFound();
            }

            return ventas_detalle;
        }

        // PUT: api/Ventas_detalle/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutVentas_detalle(long id, Ventas_detalle ventas_detalle)
        {
            if (id != ventas_detalle.id_venta_detalle)
            {
                return BadRequest();
            }

            _context.Entry(ventas_detalle).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Ventas_detalleExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Ventas_detalle
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Ventas_detalle>> PostVentas_detalle(Ventas_detalle ventas_detalle)
        {
            _context.Ventas_detalle.Add(ventas_detalle);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetVentas_detalle", new { id = ventas_detalle.id_venta_detalle }, ventas_detalle);
        }

        // DELETE: api/Ventas_detalle/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVentas_detalle(long id)
        {
            var ventas_detalle = await _context.Ventas_detalle.FindAsync(id);
            if (ventas_detalle == null)
            {
                return NotFound();
            }

            _context.Ventas_detalle.Remove(ventas_detalle);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool Ventas_detalleExists(long id)
        {
            return _context.Ventas_detalle.Any(e => e.id_venta_detalle == id);
        }
    }
}
