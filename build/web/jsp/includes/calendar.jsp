<%@page import="java.util.List"%>

<!-- Contenedor principal del calendario -->
<div class="containerCalendar container py-5 text-center">
    <div class="controls">
        <button class="btn btn-link" onclick="changeMonth(-1)" aria-label="Anterior" style="color: #3E3028;">
            <i class="bi bi-caret-left-fill" style="font-size: 1.5rem;"></i>
        </button>
        <h1 id="monthYear"></h1>
        <button class="btn btn-link" onclick="changeMonth(1)" aria-label="Siguiente" style="color: #3E3028;">
            <i class="bi bi-caret-right-fill" style="font-size: 1.5rem; "></i>
        </button>
    </div>

    <div class="header" id="header">
        <div>Dom</div>
        <div>Lun</div>
        <div>Mar</div>
        <div>Mié</div>
        <div>Jue</div>
        <div>Vie</div>
        <div>Sáb</div>
    </div>

    <div class="calendar" id="calendar"></div>
</div>

<!-- Modal para mostrar detalles del curso -->
<div class="modal fade text-center" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">

                <!-- Selección de Curso (se llena con JS) -->
                <h6>Seleccione un curso:</h6>
                <select id="courseSelect" class="form-select" onchange="updateCourseDetails()">
                    <option value="">Seleccione una opción</option>
                </select>

                <!-- Imagen del curso seleccionado -->
                <img id="eventImage" src="/Ashya-Art/resources/imagenes/workshops-services/courses/hand_building_class.png"
                     alt="Imagen del curso"
                     style="width: 100%; height: auto; max-height: 300px; object-fit: cover; margin-top: 10px;">

                <h5 id="courseTitle" class="mb-3 fw-bold"></h5>
                <p><strong>Fecha:</strong> <span id="courseDate"></span></p>
                <p><strong>Horario:</strong> <span id="courseTime"></span></p>
                <p><strong>Precio:</strong> <span id="coursePrice"></span></p>
                <p><strong>Plazas restantes:</strong> <span id="courseSpots"></span></p>
                <p><a id="courseLink" href="/Ashya-Art/workshops" target="_blank">Más información</a></p>



                <!-- Botón para agregar al carrito -->
                <button type="button" id="addToCartButton" class="btn btn-custom w-100">Add to the cart</button>

            </div>
        </div>
    </div>
</div>
