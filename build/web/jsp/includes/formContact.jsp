<section class="py-5" style="background-color: #EFE5DB; color: #3E3028;">
    <div class="container d-flex justify-content-center">
        <div class="p-4 rounded shadow animate__animated animate__fadeInUp" style="max-width: 700px; width: 100%; background-color: #EFE5DB;">

            <h2 class="text-center mb-4" style="color: #3E3028;">Get in Touch with Ashya</h2>
            <p class="lead text-center mb-5" style="color: #3E3028;">
                Have a question, want to book a workshop, or just say hello? I'd love to hear from you.
            </p>

            <%
                String exito = request.getParameter("exito");
                String error = request.getParameter("error");

                if (exito != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin-bottom: 15px;">
                <%= exito%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
            <%
            } else if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-bottom: 15px;">
                <%= error%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
            <%
                }
            %>

            <form id="contact-form" action="<%= request.getContextPath()%>/ContactServlet" method="post" enctype="application/x-www-form-urlencoded" novalidate>

                <div class="mb-3 animate__animated animate__fadeInLeft">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" maxlength="50" required style="background-color: #F9F3EC;">
                    <div class="invalid-feedback">Please enter your name.</div>
                </div>

                <div class="mb-3 animate__animated animate__fadeInDown">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" maxlength="50" required style="background-color: #F9F3EC;">
                    <div class="invalid-feedback">Please enter a valid email address.</div>
                </div>

                <div class="mb-3 animate__animated animate__fadeInRight">
                    <label for="message" class="form-label">Message</label>
                    <textarea class="form-control" id="message" name="message" rows="3" maxlength="500" required style="background-color: #F9F3EC;"></textarea>
                    <div class="invalid-feedback">Please enter your message.</div>
                </div>

                <div class="animate__animated animate__fadeInUp text-start">
                    <button type="submit" class="btn btn-custom px-4 py-2">Send Message</button>
                </div>

            </form>
        </div>
    </div>
</section>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("contact-form");

        const campos = {
            name: {
                input: document.getElementById("name"),
                mensaje: "Please enter your name.",
                validar: valor => valor.trim().length > 0
            },
            email: {
                input: document.getElementById("email"),
                mensaje: "Please enter a valid email address.",
                validar: valor => /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/.test(valor.trim())
            },
            message: {
                input: document.getElementById("message"),
                mensaje: "Please enter your message.",
                validar: valor => valor.trim().length > 0
            }
        };

        const mostrarError = (input, mensaje) => {
            input.classList.add("is-invalid");
            input.classList.remove("is-valid");
            const feedback = input.nextElementSibling;
            if (feedback)
                feedback.textContent = mensaje;
        };

        const mostrarValido = (input) => {
            input.classList.remove("is-invalid");
            input.classList.add("is-valid");
        };

        Object.values(campos).forEach(({ input, mensaje, validar }) => {
            input.addEventListener("input", () => {
                const valor = input.value;
                if (!validar(valor)) {
                    mostrarError(input, mensaje);
                } else {
                    mostrarValido(input);
                }
            });
        });

        form.addEventListener("submit", (e) => {
            let formularioValido = true;

            Object.values(campos).forEach(({ input, mensaje, validar }) => {
                const valor = input.value;
                if (!validar(valor)) {
                    mostrarError(input, mensaje);
                    formularioValido = false;
                } else {
                    mostrarValido(input);
            }
            });

            if (!formularioValido) {
                e.preventDefault();
            }
        });
    });
</script>

