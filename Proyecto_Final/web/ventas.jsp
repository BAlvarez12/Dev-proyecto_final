<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List" %>
<%@page import="modelo.Cliente" %>
<%@page import="modelo.Empleado" %>
<%@page import="modelo.Productos" %>
<%@page import="modelo.Ventas" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        .form-label {
            font-weight: bold;
        }
        .modal-lg {
            max-width: 80%;
        }
        .modal-body {
            background-color: #f8f9fa;
            padding: 2rem;
            border-radius: 0.5rem;
        }
        .form-control {
            border-radius: 0.5rem;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .modal-footer {
            border-top: none;
        }
        h1.text-center {
            color: #00bfa5;
            font-weight: bold;
            margin-bottom: 2rem;
        }
        .btn-custom {
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .alert-stock {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Registrar Venta</h1>
        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-primary btn-custom" id="btn_crear_venta" data-bs-toggle="modal" data-bs-target="#modal_venta" onclick="limpiar()">Crear Venta</button>
        </div>
        <div class="modal fade" id="modal_venta" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Detalles de Venta</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_ventas" method="post" id="form_venta" class="form-group">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">No de venta:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-4">
                                    <label for="txt_no_factura" class="form-label">No. Factura:</label>
                                    <input type="number" name="txt_no_factura" id="txt_no_factura" class="form-control" placeholder="Ingrese No. de Factura" required>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <label for="txt_serie" class="form-label">Serie:</label>
                                    <input type="text" name="txt_serie" id="txt_serie" class="form-control" placeholder="Ingrese Serie" required>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <label for="txt_fecha_factura" class="form-label">Fecha Factura:</label>
                                    <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="drop_cliente" class="form-label">Cliente:</label>
                                    <select name="drop_cliente" id="drop_cliente" class="form-select">
                                        <% Cliente cliente = new Cliente();
                                           HashMap<String,String> drop = cliente.drop_clientes();
                                           for(String i: drop.keySet()){
                                               out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                           } %>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label for="drop_empleado" class="form-label">Empleado:</label>
                                    <select name="drop_empleado" id="drop_empleado" class="form-select">
                                        <% Empleado empleadoDrop = new Empleado();
                                           HashMap<String,String> dropE = empleadoDrop.drop_empleados();
                                           for(String i: dropE.keySet()){
                                               out.println("<option value='" + i + "'>" + dropE.get(i) + "</option>");
                                           } %>
                                    </select>
                                </div>
                                <div class="mb-4">
                                    <label for="txt_fecha_ingreso" class="form-label">Fecha Ingreso:</label>
                                    <input type="DATETIME" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" readonly>
                                </div>
                            </div>
                            <hr class="my-4">
                            <h4 class="mb-4">Detalles de Productos</h4>
                            <div id="productos_container">
                                <div class="row producto-detalle">
                                    <div class="col-md-4 mb-4">
                                        <label for="drop_producto_1" class="form-label">Producto:</label>
                                        <select name="drop_producto[]" id="drop_producto_1" class="form-select">
                                            <% Productos productos = new Productos();
                                               HashMap<String,String> dropP = productos.drop_productos();
                                               for(String i: dropP.keySet()){
                                                   out.println("<option value='" + i + "'>" + dropP.get(i) + "</option>");
                                               } %>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-4">
                                        <label for="txt_cantidad_1" class="form-label">Cantidad:</label>
                                        <input type="number" name="txt_cantidad[]" id="txt_cantidad_1" class="form-control" placeholder="Cantidad" required>
                                    </div>
                                    <div class="col-md-4 mb-4">
                                        <label for="txt_precio_unitario_1" class="form-label">Precio Unitario:</label>
                                        <input type="number" step="0.01" name="txt_precio_unitario[]" id="txt_precio_unitario_1" class="form-control" placeholder="Precio Unitario" required>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-secondary mb-4" id="btn_agregar_producto">Agregar Producto</button>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary btn-custom" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-custom">Guardar</button>
                                <button type="button" class="btn btn-danger" id="btn_anular" data-bs-toggle="modal" data-bs-target="#modalConfirmacion" style="display: none;">Anular Venta</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-bordered table-hover mt-4">
            <thead class="table-dark">
                <tr>
                    <th scope="col">No. Factura</th>
                    <th scope="col">Serie</th>
                    <th scope="col">Fecha Factura</th>
                    <th scope="col">Cliente</th>
                    <th scope="col">Empleado</th>
                    <th scope="col">Producto</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio Unitario</th>
                </tr>
            </thead>
            <tbody id="tbl_venta">
                 <%
                    Ventas ventas = new Ventas();
                    DefaultTableModel tabla = new DefaultTableModel();
                    tabla = ventas.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_venta=" + tabla.getValueAt(t, 0) + " data-estado=" + tabla.getValueAt(t, 4) +  " data-fecha_ingreso=" + tabla.getValueAt(t, 9) + " data-id_cliente=" + tabla.getValueAt(t, 5) + " data-id_empleados=" + tabla.getValueAt(t, 7) + " data-id_producto=" + tabla.getValueAt(t, 10) +">");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>"); // No factura
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>"); // Serie
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>"); // Fecha factura
                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>"); // Cliente
                        out.println("<td>" + tabla.getValueAt(t, 8) + "</td>"); // Empleado
                        out.println("<td>" + tabla.getValueAt(t, 11) + "</td>"); // Producto
                        out.println("<td>" + tabla.getValueAt(t, 12) + "</td>"); // Cantidad
                        out.println("<td>" + tabla.getValueAt(t, 13) + "</td>"); // Precio Unitario
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            // Agregar nuevo producto
            let contadorProductos = 1;
            $('#btn_agregar_producto').click(function() {
                contadorProductos++;
                const productoHtml = `
                    <div class="row producto-detalle">
                        <div class="col-md-4 mb-4">
                            <label for="drop_producto_${contadorProductos}" class="form-label">Producto:</label>
                            <select name="drop_producto[]" id="drop_producto_${contadorProductos}" class="form-select">
                                <% Productos productosPl = new Productos();
                                   HashMap<String,String> dropPl = productosPl.drop_productos();
                                   for(String i: dropPl.keySet()){
                                       out.println("<option value='" + i + "'>" + dropPl.get(i) + "</option>");
                                   } %>
                            </select>
                        </div>
                        <div class="col-md-4 mb-4">
                            <label for="txt_cantidad_${contadorProductos}" class="form-label">Cantidad:</label>
                            <input type="number" name="txt_cantidad[]" id="txt_cantidad_${contadorProductos}" class="form-control" placeholder="Cantidad" required>
                        </div>
                        <div class="col-md-4 mb-4">
                            <label for="txt_precio_unitario_${contadorProductos}" class="form-label">Precio Unitario:</label>
                            <input type="number" step="0.01" name="txt_precio_unitario[]" id="txt_precio_unitario_${contadorProductos}" class="form-control" placeholder="Precio Unitario" required>
                        </div>
                    </div>
                `;
                $('#productos_container').append(productoHtml);
            });
        });
    </script>
</body>
</html>
