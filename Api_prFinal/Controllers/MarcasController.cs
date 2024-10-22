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
    public class MarcasController : ControllerBase
    {
        private readonly Conexiones _context;

        public MarcasController(Conexiones context)
        {
            _context = context;
        }

        // GET: api/Marcas
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Marcas>>> GetMarcas()
        {
            return await _context.Marcas.ToListAsync();
        }

        // GET: api/Marcas/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Marcas>> GetMarcas(short? id)
        {
            var marcas = await _context.Marcas.FindAsync(id);

            if (marcas == null)
            {
                return NotFound();
            }

            return marcas;
        }

        // PUT: api/Marcas/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMarcas(short? id, Marcas marcas)
        {
            if (id != marcas.id_marca)
            {
                return BadRequest();
            }

            _context.Entry(marcas).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MarcasExists(id))
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

        // POST: api/Marcas
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Marcas>> PostMarcas(Marcas marcas)
        {
            _context.Marcas.Add(marcas);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetMarcas", new { id = marcas.id_marca }, marcas);
        }

        // DELETE: api/Marcas/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMarcas(short? id)
        {
            var marcas = await _context.Marcas.FindAsync(id);
            if (marcas == null)
            {
                return NotFound();
            }

            _context.Marcas.Remove(marcas);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MarcasExists(short? id)
        {
            return _context.Marcas.Any(e => e.id_marca == id);
        }
    }
}
