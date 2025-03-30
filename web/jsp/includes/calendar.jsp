<div class="container">
    <div class="controls">
        <button class="btn btn-link text-dark" onclick="changeMonth(-1)" aria-label="Anterior">
            <i class="bi bi-caret-left-fill" style="font-size: 1.5rem;"></i>
        </button>
        <h1 id="monthYear"></h1>
        <button class="btn btn-link text-dark" onclick="changeMonth(1)" aria-label="Siguiente">
            <i class="bi bi-caret-right-fill" style="font-size: 1.5rem;"></i>
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
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img id="eventImage" src="" alt="Imagen del curso">
                <p id="eventDescription"></p>
                <h6>Formulario de Reserva</h6>
                <form id="reservationForm">
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Reservar</button>
                </form>
            </div>
        </div>
    </div>
</div>