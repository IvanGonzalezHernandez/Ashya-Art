$(document).ready(function () {
if ($('#tablaCursos').length) {
$('#tablaCursos').DataTable({
ajax: {
url: contextPath + '/AdminServlet?tipo=cursos',
        dataSrc: '',
        error: function (xhr, status, error) {
        console.error("Error al cargar datos de cursos:", xhr.responseText);
        }
},
        columns: [
        {data: 'id'},
        {data: 'nombre'},
        {data: 'subtitulo'},
        {
        data: 'descripcion',
                render: function(data, type, row) {
                if (data.length > 50) { // número de caracteres
                return data.substring(0, 50) + '...';
                }
                return data;
                }
        },
        {data: 'precio'},
        {data: 'nivel'},
        {data: 'idioma'},
        {
        data: null,
                orderable: false,
                render: function (data, type, row) {
                return `
                        <button class="btn btn-danger btn-sm eliminar-curso" data-id="${row.id}">
                            Eliminar
                        </button>
                    `;
                }
        },
        {
        data: null,
                orderable: false,
                render: function (data, type, row) {
                return `
                        <button class="btn btn-warning btn-sm editar-curso" data-id="${row.id}">
                            Editar
                        </button>
                    `;
                }
        }
        ],
        responsive: true,
        dom: 'Bfrtip',
        buttons: generarBotones('cursos'),
        language: {
        language: {
        url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
        }

        }
});
}

if ($('#tablaClientes').length) {
$('#tablaClientes').DataTable({
ajax: {
url: contextPath + '/AdminServlet?tipo=clientes',
        dataSrc: '',
        error: function (xhr, status, error) {
        console.error("Error al cargar datos de clientes:", xhr.responseText);
        }
},
        columns: [
        {data: 'nombre'},
        {data: 'apellido'},
        {data: 'direccion'},
        {data: 'telefono'},
        {data: 'email'},
        {data: 'idStripe'}
        ],
        responsive: true,
        dom: 'Bfrtip',
        buttons: generarBotones('clientes'),
        language: {
        language: {
        url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
        }

        }
});
}

if ($('#tablaReservas').length) {
$('#tablaReservas').DataTable({
ajax: {
url: contextPath + '/AdminServlet?tipo=reservas',
        dataSrc: '',
        error: function (xhr, status, error) {
        console.error("Error al cargar datos de reservas:", xhr.responseText);
        }
},
        columns: [
        {data: 'nombreCurso'},
        {data: 'nombreCliente'},
        {data: 'fechaCurso'},
        {data: 'horaCurso'},
        {data: 'plazasReservadas'}
        ],
        responsive: true,
        dom: 'Bfrtip',
        buttons: generarBotones('reservas'),
        language: {
        language: {
        url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
        }

        }
});
}
});
// Función para generar los botones según la tabla
        function generarBotones(tabla) {
        let botones = [
        {
        extend: 'copyHtml5',
                text: '<i class="bi bi-clipboard"></i> Copiar',
                titleAttr: 'Copiar al portapapeles',
                className: 'btn btn-success'
        },
        {
        extend: 'excelHtml5',
                text: '<i class="bi bi-file-earmark-excel"></i> Excel',
                titleAttr: 'Exportar a Excel',
                className: 'btn btn-success'
        },
        {
        extend: 'pdfHtml5',
                text: '<i class="bi bi-file-earmark-pdf"></i> PDF',
                titleAttr: 'Exportar a PDF',
                orientation: 'landscape',
                pageSize: 'A4',
                className: 'btn btn-danger'
        },
        {
        extend: 'print',
                text: '<i class="bi bi-printer"></i> Imprimir',
                titleAttr: 'Imprimir tabla',
                className: 'btn btn-info'
        }
        ];
                // Personalización específica para cursos y reservas
                if (tabla === 'cursos') {
        botones[2].customize = function (doc) {
        doc.content[1].table.widths = ['10%', '20%', '20%', '20%', '10%', '10%', '10%', '10%'];
        };
        } else if (tabla === 'reservas') {
        botones[2].customize = function (doc) {
        doc.content[1].table.widths = ['20%', '20%', '20%', '15%', '15%'];
        };
        }

        return botones;
                }




// Evento para eliminar un curso
$(document).on('click', '.eliminar-curso', function () {
const idCurso = $(this).data('id'); // Obtener el ID del curso
        if (confirm('¿Seguro que quieres eliminar este curso?')) {
$.ajax({
url: contextPath + '/AdminServlet', // Ruta del Servlet
        method: 'POST',
        data: {
        action: 'eliminarCurso', // Enviar acción de eliminación
                id: idCurso                // Enviar el ID del curso
        },
        success: function (response) {
        alert('Curso eliminado correctamente');
                $('#tablaCursos').DataTable().ajax.reload(); // Recargar tabla
        },
        error: function (xhr, status, error) {
        console.error('Error al eliminar el curso:', xhr.responseText);
                alert('Error al eliminar el curso. Intenta nuevamente.');
        }
});
}
});
// Evento para abrir el modal con datos del curso
        $(document).on('click', '.editar-curso', function () {
const idCurso = $(this).data('id');
        // Buscar los datos en la tabla actual
        const table = $('#tablaCursos').DataTable();
        const rowData = table.row($(this).parents('tr')).data();
        // Rellenar el formulario
        $('#editarId').val(rowData.id);
        $('#editarImg').val(rowData.img);
        $('#editarNombre').val(rowData.nombre);
        $('#editarSubtitulo').val(rowData.subtitulo);
        $('#editarDescripcion').val(rowData.descripcion);
        $('#editarPrecio').val(rowData.precio);
        $('#editarNivel').val(rowData.nivel);
        $('#editarIdioma').val(rowData.idioma);
        // Mostrar el modal
        const modal = new bootstrap.Modal(document.getElementById('modalEditarCurso'));
        modal.show();
        });



