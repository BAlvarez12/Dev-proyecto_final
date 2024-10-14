<%@page import="modelo.Puesto" %>
<%@page import="java.util.HashMap" %>
<%@page import="modelo.Empleado" %>
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
        <h1 class="text-center">Empleados</h1>
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#modal_empleado" onclick="limpiar()">Agregar Empleado</button>
        </div>
        <div class="modal fade" id="modal_empleado" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                       <h1 class="modal-title fs-5" id="exampleModalLabel">Empleado</h1>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_empleado" method="post" id="form_empleado" class="form-group">
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
                                <label for="txt_direccion" class="form-label">Dirección:</label>
                                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ingrese la Dirección" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_telefono" class="form-label">Teléfono:</label>
                                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ingrese el número de teléfono" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_dpi" class="form-label">Número de Identificación:</label>
                                <input type="number" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="Ingrese el número de identificación" required>
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
                                <label for="txt_fn" class="form-label">Fecha de Nacimiento:</label>
                                <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="drop_puesto" class="form-label">Tipo de Puesto:</label>
                                <select name="drop_puesto" id="drop_puesto" class="form-select">
                                   <%
                                      Puesto puesto = new Puesto();
                                      HashMap<String,String> drop = puesto.drop_puesto();
                                      for(String i: drop.keySet()){
                                        out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                      }
                                   %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="txt_fe_inicio" class="form-label">Fecha de Inicio de Labores:</label>
                                <input type="date" name="txt_fe_inicio" id="txt_fe_inicio" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="txt_fe_ingreso" class="form-label">Fecha de Ingreso:</label>
                                <input type="date" name="txt_fe_ingreso" id="txt_fe_ingreso" class="form-control" required>
                            </div>
                            <div class="modal-footer mt-4">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Guardar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
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
                    <th scope="col">Dirección</th>
                    <th scope="col">Teléfono</th>
                    <th scope="col">DPI</th>
                    <th scope="col">Género</th>
                    <th scope="col">Fecha de Nacimiento</th>
                    <th scope="col">Puesto</th>
                    <th scope="col">Fecha de Inicio</th>
                    <th scope="col">Fecha de Ingreso</th>
                </tr>
            </thead>
            <tbody id="tbl_empleado">
                <%
                    Empleado empleado = new Empleado();
                    DefaultTableModel tabla = new DefaultTableModel();
                    tabla = empleado.leer();
                    for(int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id_empleados=" + tabla.getValueAt(t, 0) + " data-id_puesto=" + tabla.getValueAt(t, 9) +">");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>"); //Nombres
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>"); //Apellidos
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>"); //Direccion
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>"); //Telefono
                        out.println("<td>" + tabla.getValueAt(t, 5) + "</td>"); //DPI
                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>"); //GENERO
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>"); //fecha nacimiento
                        out.println("<td>" + tabla.getValueAt(t, 8) + "</td>"); //puesto
                        out.println("<td>" + tabla.getValueAt(t, 10) + "</td>");//fecha inicio labores
                        out.println("<td>" + tabla.getValueAt(t, 11) + "</td>");//fecha ingreso
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Confirmar eliminacion -->
    <div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Eliminar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Está seguro de que desea eliminar este empleado?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" id="btnConfirmarEliminar">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function limpiar() {
            $("#txt_id").val(0);
            $("#txt_nombres").val('');
            $("#txt_apellidos").val('');
            $("#txt_direccion").val('');
            $("#txt_telefono").val('');
            $("#txt_dpi").val('');
            $("#txt_genero").val('');
            $("#txt_fn").val('');
            $("#drop_puesto").val(1);
            $("#txt_fe_inicio").val('');
            $("#txt_fe_ingreso").val('');
        }

        $(document).ready(function() {
            // Clic en el botón eliminar
            document.getElementById("btnConfirmarEliminar").addEventListener("click", function() {
                var form = document.getElementById("form_empleado");
                var inputEliminar = document.createElement("input");
                inputEliminar.setAttribute("type", "hidden");
                inputEliminar.setAttribute("name", "btn_eliminar");
                inputEliminar.setAttribute("value", "eliminar");
                form.appendChild(inputEliminar);
                form.submit();
                var modalEl = document.getElementById('modalConfirmacion');
                var modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();
            });

            $('#tbl_empleado').on('click', 'tr', function() {
                var target = $(this);
                var id_empleados = target.data('id_empleados');
                var id_puesto = target.data('id_puesto');
                var nombres = target.find("td").eq(0).html();
                var apellidos = target.find("td").eq(1).html();
                var direccion = target.find("td").eq(2).html();
                var telefono = target.find("td").eq(3).html();
                var dpi = target.find("td").eq(4).html();
                var genero = target.find("td").eq(5).html();
                var nacimiento = target.find("td").eq(6).html();
                var fecha_inicio = target.find("td").eq(8).html();
                var fecha_ingreso = target.find("td").eq(9).html();
                
                $("#txt_id").val(id_empleados);
                $("#txt_nombres").val(nombres);
                $("#txt_apellidos").val(apellidos);
                $("#txt_direccion").val(direccion);
                $("#txt_telefono").val(telefono);
                $("#txt_dpi").val(dpi);
                $("#txt_genero").val(genero === "Masculino" ? 1 : 0);
                $("#txt_fn").val(nacimiento);
                $("#drop_puesto").val(id_puesto);
                $("#txt_fe_inicio").val(fecha_inicio);
                $("#txt_fe_ingreso").val(fecha_ingreso);
                $("#modal_empleado").modal('show');
            });
        });
    </script>
</body>
</html>