<%@page import="modelo.Marcas" %>
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
        <h1 class="text-center">Marcas</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_marca" onclick="limpiar()">Agregar Marca</button>
        </div>

        <div class="modal fade" id="modal_marca" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Marcas</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_marca" method="post" class="form-group" id="form_marca">
                            <div class="mb-3">
                                <label for="txt_id" class="form-label">ID:</label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="txt_marca" class="form-label">Marca:</label>
                                <input type="text" name="txt_marca" id="txt_marca" class="form-control" placeholder="Ingrese la marca" required>
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
                    <th scope="col">Marca</th>
                </tr>
            </thead>
            <tbody id="tbl_marca">
                <%
                    Marcas marcas = new Marcas();
                    DefaultTableModel tabla = marcas.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_marca='" + tabla.getValueAt(t, 0) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
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
                        ¿Está seguro de que desea eliminar esta marca?
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
                $("#txt_marca").val('');
            }

            $(document).ready(function() {
                // Cuando el usuario haga clic en el botón de confirmar eliminación
                $("#btnConfirmarEliminar").on("click", function() {
                    $("#form_marca").append('<input type="hidden" name="btn_eliminar" value="eliminar">');
                    // Enviar el formulario al confirmar eliminación
                    $("#form_marca").submit();
                });

                // Clic en una fila para editar
                $('#tbl_marca').on('click', 'tr', function() {
                    var target = $(this);
                    var id_marca = target.data('id_marca');
                    var marca = target.find("td").eq(0).html();
                    
                    $("#txt_id").val(id_marca);
                    $("#txt_marca").val(marca);
                    
                    $("#modal_marca").modal('show');
                });
            });
        </script>
    </div>
</body>
</html>