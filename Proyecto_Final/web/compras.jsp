<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="modelo.Compras" %>
<%@page import="modelo.Proveedor" %>
<%@page import="modelo.Productos" %>
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
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Registrar Compras</h1>
        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-primary btn-custom" id="btn_crear_compra" data-bs-toggle="modal" data-bs-target="#modal_compra" onclick="limpiar()">Crear Compra</button>
        </div>
        <div class="modal fade" id="modal_compra" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Detalles de Compras</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_compras" method="post" id="form_venta" class="form-group" onsubmit="return validarFormulario()">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">No Compra:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-4">
                                    <label for="txt_no_compra" class="form-label">No. Orden de Compra:</label>
                                    <input type="number" name="txt_no_compra" id="txt_no_compra" class="form-control" placeholder="Ingrese No de la compra" required>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label for="drop_proveedor" class="form-label">Proveedor:</label>
                                    <select name="drop_proveedor" id="drop_proveedor" class="form-select" required>
                                        <% Proveedor proveedordrop = new Proveedor();
                                           HashMap<String,String> drop = proveedordrop.drop_proveedores();
                                           for(String i: drop.keySet()){
                                               out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                           }
                                        %>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <label for="txt_fecha_orden" class="form-label">Fecha Orden:</label>
                                    <input type="date" name="txt_orden" id="txt_orden" class="form-control" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="txt_fecha_ingreso" class="form-label">Fecha Ingreso:</label>
                                <input type="datetime-local" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" readonly>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label for="drop_producto" class="form-label">Producto:</label>
                                <select name="drop_producto" id="drop_producto" class="form-select" required>
                                    <% Productos productoDrop = new Productos();
                                       HashMap<String,String> dropE = productoDrop.drop_productos();
                                       for(String i: dropE.keySet()){
                                           out.println("<option value='" + i + "'>" + dropE.get(i) + "</option>");
                                       }
                                    %>
                                </select>
                            </div>
                            <hr class="my-4">
                            <h4 class="mb-4">Detalles de la Compra</h4>
                            <div class="row">
                                <div class="col-md-4 mb-4">
                                    <label for="txt_cantidad" class="form-label">Cantidad:</label>
                                    <input type="number" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Cantidad" required>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <label for="txt_precio_unitario" class="form-label">Precio Unitario:</label>
                                    <input type="number" step="0.01" name="txt_precio_unitario" id="txt_precio_unitario" class="form-control" placeholder="Precio Unitario" required>
                                </div>
                            </div>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary btn-custom" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-custom">Guardar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                <button type="button" class="btn btn-danger" id="btn_anular" data-bs-toggle="modal" data-bs-target="#modalConfirmacion" style="display: none;">Anular Compra</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmar anulación -->
        <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Anulación de Compra</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ¿Está seguro de que desea anular esta compra?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" id="btnConfirmarAnular">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-bordered table-hover mt-4">
            <thead class="table-dark">
                <tr>
                    <th scope="col">No. Orden de Compra</th>
                    <th scope="col">Proveedor</th>
                    <th scope="col">Fecha Orden</th>
                    <th scope="col">Producto</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio Unitario</th>
                    </tr>
            </thead>
            <tbody id="tbl_compras">
                 <% Compras compras = new Compras();
                    DefaultTableModel tabla = new DefaultTableModel();
                    tabla = compras.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_compras=" + tabla.getValueAt(t, 0) + " data-id_proveedores=" + tabla.getValueAt(t, 2) + " data-fecha_ingreso=" + tabla.getValueAt(t, 5) + " data-id_producto=" + tabla.getValueAt(t, 6) + ">");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>"); // No orden de compra
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>"); // Proveedor
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>"); // Fecha Orden
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>"); // Producto
                        out.println("<td>" + tabla.getValueAt(t, 8) + "</td>"); // Cantidad
                        out.println("<td>" + tabla.getValueAt(t, 9) + "</td>"); // Precio Unitario
                        out.println("");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function limpiar() {
            $("#txt_id").val(0);
            $("#txt_no_compra").val('');
            $("#drop_proveedor").val(1);
            $("#txt_orden").val('');
            $("#txt_fecha_ingreso").val('');
            $("#drop_producto").val(1);
            $("#txt_cantidad").val('');
            $("#txt_precio_unitario").val('');
            $("#btn_anular").hide();
        }

        function validarFormulario() {
            if (!document.getElementById('txt_no_compra').checkValidity()) {
                alert("El campo 'No. Orden de Compra' es obligatorio.");
                return false;
            }
            return true;
        }

        function anularCompra(idCompra) {
            $("#txt_id").val(idCompra);
            $("#modalConfirmacion").modal('show');
        }

        $(document).ready(function() {
            // Confirmar la anulación
            document.getElementById("btnConfirmarAnular").addEventListener("click", function() {
                var form = document.getElementById("form_venta");
                var inputAnular = document.createElement("input");
                inputAnular.setAttribute("type", "hidden");
                inputAnular.setAttribute("name", "btn_anular");
                inputAnular.setAttribute("value", "anular");
                form.appendChild(inputAnular);
                form.submit();
                var modalEl = document.getElementById('modalConfirmacion');
                var modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();
            });

            // Cargar datos al modal al hacer clic en una fila de la tabla
            $('#tbl_compras').on('click', 'tr', function() {
                var target = $(this);
                var id_compras = target.data('id_compras');
                var id_proveedores = target.data('id_proveedores');
                var id_producto = target.data('id_producto');
                var fecha_ingreso = target.data('fecha_ingreso');
                var no_orden = target.find("td").eq(0).html();
                var fecha_orden = target.find("td").eq(2).html();
                var cantidad = target.find("td").eq(4).html();
                var precio_unitario = target.find("td").eq(5).html();
               
                $("#txt_id").val(id_compras);
                $("#txt_no_compra").val(no_orden);
                $("#txt_orden").val(fecha_orden);
                $("#drop_proveedor").val(id_proveedores);
                $("#drop_producto").val(id_producto);
                $("#txt_cantidad").val(cantidad);
                $("#txt_precio_unitario").val(precio_unitario);
                $("#txt_fecha_ingreso").val(fecha_ingreso);
                $("#btn_anular").show();
                $("#modal_compra").modal('show');
            });
        });
    </script>
</body>
</html>
