<%@page import="modelo.Proveedor" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-label {
            font-weight: bold;
        }
        .modal-body {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 0.5rem;
        }
        .form-control {
            border-radius: 0.5rem;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
        }
        .modal-footer {
            border-top: none;
        }
        h1 {
            color: #00bfa5;
            font-weight: bold;
            margin-bottom: 2rem;
        }
        .btn-custom {
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .table-header {
            background-color: #000000;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Proveedores</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_proveedores" onclick="limpiar()">Agregar Proveedor</button>
        </div>

        <div class="modal fade" id="modal_proveedores" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Proveedores</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_proveedor" method="post" class="form-group" id="form_proveedor">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="txt_proveedor" class="form-label">Proveedor:</label>
                                <input type="text" name="txt_proveedor" id="txt_proveedor" class="form-control" placeholder="Ingrese el Nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_nit" class="form-label">Nit:</label>
                                <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="Ingrese el Nit" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_direccion" class="form-label">Dirección:</label>
                                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ingrese la Dirección" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_telefono" class="form-label">Teléfono:</label>
                                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ingrese el Teléfono" required>
                            </div>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Guardar</button>
                                <button type="submit" name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                <button type="button" class="btn btn-danger" id="btn_eliminar" data-bs-toggle="modal" data-bs-target="#modalConfirmacion">Eliminar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-striped table-bordered mt-4">
            <thead class="table-header">
                <tr>
                    <th scope="col">Proveedor</th>
                    <th scope="col">Nit</th>
                    <th scope="col">Dirección</th>
                    <th scope="col">Teléfono</th>
                </tr>
            </thead>
            <tbody id="tbl_proveedor">
                <%
                    Proveedor proveedor = new Proveedor();
                    DefaultTableModel tabla = proveedor.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_proveedores='" + tabla.getValueAt(t, 0) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>

        <!-- Confirmar eliminacion -->
        <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Eliminar</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ¿Está seguro de que desea eliminar este proveedor?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" id="btnConfirmarEliminar">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/5hb7x1l5F3i5s0l4l7NME57K7lN5e5q5g5d6vA" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMN00AokAGBfS8f8k5PcUtx8RmgQ4Ly4Qo9VV7Si1LpD+plWTo+lFi4iA2cPw0J8" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGhv1BBm4rZr5f9EaZhl8y3tlF8ox8a4f4Y5WeUc0e6e/mGyf4gpPeUyG6g" crossorigin="anonymous"></script>

        <script type="text/javascript">
            function limpiar() {
                $("#txt_id").val(0);
                $("#txt_proveedor").val('');
                $("#txt_nit").val('');
                $("#txt_direccion").val('');
                $("#txt_telefono").val('');
            }

            $(document).ready(function() {
                // Clic en el boton eliminar
                $("#btnConfirmarEliminar").on("click", function() {
                    $("#form_proveedor").append('<input type="hidden" name="btn_eliminar" value="eliminar">');
                    $("#form_proveedor").submit();
                });

                // Clic en una fila para editar
                $('#tbl_proveedor').on('click', 'tr', function() {
                    var target = $(this);
                    var id_proveedores = target.data('id_proveedores');
                    var proveedor = target.find("td").eq(0).html();
                    var nit = target.find("td").eq(1).html();
                    var direccion = target.find("td").eq(2).html();
                    var telefono = target.find("td").eq(3).html();
                    
                    $("#txt_id").val(id_proveedores);
                    $("#txt_proveedor").val(proveedor);
                    $("#txt_nit").val(nit);
                    $("#txt_direccion").val(direccion);
                    $("#txt_telefono").val(telefono);
                    
                    $("#modal_proveedores").modal('show');
                });
            });
        </script>
    </div>
</body>
</html>>