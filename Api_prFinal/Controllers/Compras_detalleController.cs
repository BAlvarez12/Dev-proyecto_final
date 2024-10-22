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
    public class Compras_detalleController : ControllerBase
    {
        private readonly Conexiones _context;

        public Compras_detalleController(Conexiones context)
        {
            _context = context;
        }

        // GET: api/Compras_detalle
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Compras_detalle>>> GetCompras_detalle()
        {
            return await _context.Compras_detalle.ToListAsync();
        }

        // GET: api/Compras_detalle/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Compras_detalle>> GetCompras_detalle(long id)
        {
            var compras_detalle = await _context.Compras_detalle.FindAsync(id);

            if (compras_detalle == null)
            {
                return NotFound();
            }

            return compras_detalle;
        }

        // PUT: api/Compras_detalle/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCompras_detalle(long id, Compras_detalle compras_detalle)
        {
            if (id != compras_detalle.id_compra_detalle)
            {
                return BadRequest();
            }

            _context.Entry(compras_detalle).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Compras_detalleExists(id))
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

        // POST: api/Compras_detalle
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Compras_detalle>> PostCompras_detalle(Compras_detalle compras_detalle)
        {
            _context.Compras_detalle.Add(compras_detalle);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCompras_detalle", new { id = compras_detalle.id_compra_detalle }, compras_detalle);
        }

        // DELETE: api/Compras_detalle/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCompras_detalle(long id)
        {
            var compras_detalle = await _context.Compras_detalle.FindAsync(id);
            if (compras_detalle == null)
            {
                return NotFound();
            }

            _context.Compras_detalle.Remove(compras_detalle);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool Compras_detalleExists(long id)
        {
            return _context.Compras_detalle.Any(e => e.id_compra_detalle == id);
        }
    }
}
