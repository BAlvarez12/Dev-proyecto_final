<%@page import="modelo.Cliente" %>
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
        <h1 class="text-center">Clientes</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_cliente" onclick="limpiar()">Agregar Cliente</button>
        </div>

        <div class="modal fade" id="modal_cliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Clientes</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_cliente" method="post" class="form-group" id="form_cliente"> 
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="txt_nombres" class="form-label">Nombres:</label>
                                <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ingrese el Nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_apellidos" class="form-label">Apellidos:</label>
                                <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ingrese el Apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_nit" class="form-label">Nit:</label>
                                <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="Ingrese el NIT" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_genero" class="form-label">Género:</label>
                                <select name="txt_genero" id="txt_genero" class="form-select" required>
                                    <option value="">Seleccione un género</option>
                                    <option value="1">Masculino</option>
                                    <option value="0">Femenino</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="txt_telefono" class="form-label">Teléfono:</label>
                                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ingrese el teléfono" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_ce" class="form-label">Correo Electrónico:</label>
                                <input type="email" name="txt_ce" id="txt_ce" class="form-control" placeholder="Ingrese el correo electrónico" required>
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
                    <th scope="col">Nombres</th>
                    <th scope="col">Apellidos</th>
                    <th scope="col">Nit</th>
                    <th scope="col">Género</th>
                    <th scope="col">Teléfono</th>
                    <th scope="col">Correo Electrónico</th>
                </tr>
            </thead>
            <tbody id="tbl_clientes">
                <%
                    Cliente cliente = new Cliente();
                    DefaultTableModel tabla = cliente.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_cliente='" + tabla.getValueAt(t, 0) + "' data-genero='" + tabla.getValueAt(t, 4) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
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
                        ¿Está seguro de que desea eliminar este cliente?
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
                $("#txt_nombres").val('');
                $("#txt_apellidos").val('');
                $("#txt_nit").val('');
                $("#txt_genero").val('');
                $("#txt_telefono").val('');
                $("#txt_ce").val('');
            }

            $(document).ready(function() {
                // Clic en el boton eliminar
                $("#btnConfirmarEliminar").on("click", function() {
                    $("#form_cliente").append('<input type="hidden" name="btn_eliminar" value="eliminar">');
                    $("#form_cliente").submit();
                });

                // Clic en una fila para editar
                $('#tbl_clientes').on('click', 'tr', function() {
                    var target = $(this);
                    var id_cliente = target.data('id_cliente');
                    var nombres = target.find("td").eq(0).html();
                    var apellidos = target.find("td").eq(1).html();
                    var nit = target.find("td").eq(2).html();
                    var genero = target.find("td").eq(3).html();
                    var telefono = target.find("td").eq(4).html();
                    var correo_electronico = target.find("td").eq(5).html();
                    
                    $("#txt_id").val(id_cliente);
                    $("#txt_nombres").val(nombres);
                    $("#txt_apellidos").val(apellidos);
                    $("#txt_nit").val(nit);
                    $("#txt_genero").val(genero === "Masculino" ? 1 : 0);
                    $("#txt_telefono").val(telefono);
                    $("#txt_ce").val(correo_electronico);
                    
                    $("#modal_cliente").modal('show');
                });
            });
        </script>
    </div>
</body>
</html>