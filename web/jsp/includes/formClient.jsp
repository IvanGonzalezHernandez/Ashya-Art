<!-- Modal Bootstrap para datos del cliente -->
<div class="modal fade" id="clienteModal" tabindex="-1" aria-labelledby="clienteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="cliente-form" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title" id="clienteModalLabel">Datos del Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" required>
                        <div class="invalid-feedback" id="error-nombre"></div>
                    </div>
                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellido</label>
                        <input type="text" class="form-control" id="apellido" required>
                        <div class="invalid-feedback" id="error-apellido"></div>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="correo" required>
                        <div class="invalid-feedback" id="error-correo"></div>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="tel" class="form-control" id="telefono" required>
                        <div class="invalid-feedback" id="error-telefono"></div>
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion" required>
                        <div class="invalid-feedback" id="error-direccion"></div>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="comercial">
                        <label class="form-check-label" for="comercial">
                            Acepto recibir información comercial
                        </label>
                    </div>
                    <div class="form-check mt-2">
                        <input class="form-check-input" type="checkbox" id="politica" required>
                        <label class="form-check-label" for="politica">
                            Acepto la política de privacidad
                        </label>
                        <div class="invalid-feedback" id="error-politica"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-custom">Continuar al pago</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("cliente-form");
        if (!form)
            return; // Si no existe, salimos para evitar errores

        const campos = {
            nombre: {
                input: document.getElementById("nombre"),
                errorDiv: document.getElementById("error-nombre"),
                mensaje: "Por favor, introduce tu nombre.",
                validar: valor => valor.trim() !== ""
            },
            apellido: {
                input: document.getElementById("apellido"),
                errorDiv: document.getElementById("error-apellido"),
                mensaje: "Por favor, introduce tu apellido.",
                validar: valor => valor.trim() !== ""
            },
            correo: {
                input: document.getElementById("correo"),
                errorDiv: document.getElementById("error-correo"),
                mensaje: "Por favor, introduce un correo válido.",
                validar: valor => /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/.test(valor.trim())
            },
            telefono: {
                input: document.getElementById("telefono"),
                errorDiv: document.getElementById("error-telefono"),
                mensaje: "Por favor, introduce un teléfono válido (9-15 dígitos, puede incluir +, espacios y guiones).",
                validar: valor => /^\+?[\d\s\-()]{9,15}$/.test(valor.trim())
            },
            direccion: {
                input: document.getElementById("direccion"),
                errorDiv: document.getElementById("error-direccion"),
                mensaje: "Por favor, introduce una dirección.",
                validar: valor => valor.trim() !== ""
            },
            politica: {
                input: document.getElementById("politica"),
                errorDiv: document.getElementById("error-politica"),
                mensaje: "Debes aceptar la política de privacidad.",
                validar: () => document.getElementById("politica").checked
            }
        };

        const mostrarError = (campo) => {
            campo.input.classList.add("is-invalid");
            campo.input.classList.remove("is-valid");
            if (campo.errorDiv)
                campo.errorDiv.textContent = campo.mensaje;
        };

        const mostrarValido = (campo) => {
            campo.input.classList.remove("is-invalid");
            campo.input.classList.add("is-valid");
            if (campo.errorDiv)
                campo.errorDiv.textContent = "";
        };

        Object.values(campos).forEach(campo => {
            campo.input.addEventListener("input", () => {
                const valor = campo.input.type === "checkbox" ? campo.input.checked : campo.input.value.trim();
                if (!campo.validar(valor)) {
                    mostrarError(campo);
                } else {
                    mostrarValido(campo);
                }
            });
        });

        form.addEventListener("submit", e => {
            let valido = true;
            Object.values(campos).forEach(campo => {
                const valor = campo.input.type === "checkbox" ? campo.input.checked : campo.input.value.trim();
                if (!campo.validar(valor)) {
                    mostrarError(campo);
                    valido = false;
                } else {
                    mostrarValido(campo);
                }
            });

            if (!valido) {
                e.preventDefault();
            }
        });
    });
</script>
