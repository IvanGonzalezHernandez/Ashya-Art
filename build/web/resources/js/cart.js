document.addEventListener("DOMContentLoaded", () => {

    let carrito = []; // Carrito donde se almacenarán los productos seleccionados (cursos y tarjetas de regalo)

    // Elementos del DOM que se van a manipular
    const contenedorCarrito = document.getElementById("carrito-items");
    const contadorCarrito = document.getElementById("cart-count");
    const totalCarrito = document.getElementById("cart-total");
    const botonCheckout = document.getElementById("checkout-btn");

    // Actualiza el contador del carrito
    function actualizarContadorCarrito() {
        const cantidadTotal = carrito.reduce((acc, producto) => acc + producto.cantidad, 0);
        contadorCarrito.innerText = cantidadTotal;
        actualizarTotalCarrito(); // Actualiza el precio total
        guardarCarrito();         // Guarda el carrito en localStorage
    }

    // Calcula y actualiza el total a pagar
    function actualizarTotalCarrito() {
        const total = carrito.reduce((acc, producto) => acc + producto.precio * producto.cantidad, 0);
        totalCarrito.innerText = `EUR ${total.toFixed(2)}`;
        botonCheckout.style.display = carrito.length > 0 ? "block" : "none";
    }

    // Muestra los productos del carrito en el DOM
    function cargarProductosCarrito() {
        contenedorCarrito.innerHTML = '';
        if (carrito.length === 0) {
            contenedorCarrito.innerHTML = '<p>El carrito está vacío</p>';
            botonCheckout.style.display = "none";
            return;
        }

        // Genera HTML dinámicamente por cada producto (curso o tarjeta de regalo)
        carrito.forEach((producto, index) => {
            const item = document.createElement("div");
            item.classList.add("d-flex", "align-items-center", "mb-3");
            item.setAttribute("data-index", index);
            item.innerHTML = `
                <img src="${producto.imagen}" width="60" class="me-3">
                <div>
                    <h5>${producto.nombre}</h5>
                    <p>EUR ${producto.precio.toFixed(2)}</p>
                    <div class="d-flex align-items-center">
                        <button class="btn btn-outline-primary btn-sm btn-restar">-</button>
                        <span class="mx-2">${producto.cantidad}</span>
                        <button class="btn btn-sm btn-sumar">+</button>
                        <button class="btn btn-sm ms-3 btn-eliminar"><i class="bi bi-trash fs-4"></i></button>
                    </div>
                </div>
            `;
            contenedorCarrito.appendChild(item);
        });

        actualizarTotalCarrito(); // Recalcula el total
    }

    // Agrega productos al carrito desde el modal de curso
    function agregarAlCarritoDesdeModalCurso() {
        const courseSelect = document.getElementById("courseSelect");
        if (!courseSelect)
            return;

        const selectedOption = courseSelect.options[courseSelect.selectedIndex];
        if (!selectedOption)
            return;

        // Construye el objeto producto para el curso
        const nuevoCurso = {
            id: selectedOption.getAttribute("data-id"),
            nombre: selectedOption.text,
            precio: parseFloat(selectedOption.getAttribute("data-price")),
            imagen: selectedOption.getAttribute("data-img"),
            fecha: selectedOption.getAttribute("data-date"),
            hora: selectedOption.getAttribute("data-time"),
            cantidad: 1,
            tipo: "curso"
        };

        // Si ya existe el curso, suma cantidad, si no, lo agrega
        const itemExistente = carrito.find(item => item.id === nuevoCurso.id);
        if (itemExistente) {
            itemExistente.cantidad++;
        } else {
            carrito.push(nuevoCurso);
        }

        cargarProductosCarrito();
        actualizarContadorCarrito();
    }

    // Agrega tarjetas de regalo al carrito
    function agregarAlCarritoDesdeModalTarjeta() {
        const tarjetaLinks = document.querySelectorAll(".agregar-tarjeta");
        tarjetaLinks.forEach((tarjeta) => {
            tarjeta.addEventListener('click', function (event) {
                event.preventDefault();  // Evitar el comportamiento por defecto del enlace

                // Obtener los datos de la tarjeta
                const id = tarjeta.getAttribute('data-id');
                const nombre = tarjeta.getAttribute('data-nombre');
                const precio = tarjeta.getAttribute('data-precio');
                const imagen = tarjeta.getAttribute('data-img');

                // Crear el objeto tarjeta de regalo
                const tarjetaRegalo = {
                    id: id,
                    nombre: nombre,
                    precio: parseFloat(precio), // Convertir el precio a número
                    imagen: imagen,
                    cantidad: 1,
                    tipo: "tarjeta"
                };

                // Verificar si la tarjeta ya está en el carrito
                const tarjetaExistente = carrito.find(item => item.id === id);

                if (tarjetaExistente) {
                    tarjetaExistente.cantidad++;
                } else {
                    carrito.push(tarjetaRegalo);
                }

                cargarProductosCarrito();
                actualizarContadorCarrito();
            });
        });
    }

    // Manejo de clics dentro del carrito (sumar/restar/eliminar)
    contenedorCarrito.addEventListener("click", (event) => {
        const button = event.target.closest("button.btn-eliminar");
        if (button) {
            const index = Number(button.closest("div[data-index]").getAttribute("data-index"));
            if (isNaN(index))
                return;
            carrito.splice(index, 1); // Elimina producto
            cargarProductosCarrito();
            actualizarContadorCarrito();
        } else if (event.target.classList.contains("btn-sumar")) {
            const index = Number(event.target.closest("div[data-index]").getAttribute("data-index"));
            carrito[index].cantidad++;
            cargarProductosCarrito();
            actualizarContadorCarrito();
        } else if (event.target.classList.contains("btn-restar")) {
            const index = Number(event.target.closest("div[data-index]").getAttribute("data-index"));
            if (carrito[index].cantidad > 1) {
                carrito[index].cantidad--;
            } else {
                carrito.splice(index, 1);
            }
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }
    });

    // Guarda el carrito en localStorage
    function guardarCarrito() {
        localStorage.setItem("carrito", JSON.stringify(carrito));
    }

    // Carga el carrito desde localStorage
    function cargarCarritoDesdeLocalStorage() {
        const carritoGuardado = localStorage.getItem("carrito");
        if (carritoGuardado) {
            carrito = JSON.parse(carritoGuardado);
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }
    }

    cargarCarritoDesdeLocalStorage(); // Carga datos si existen

    // Evento al hacer clic en "Agregar al carrito" desde el modal de curso
    const addToCartButtonCurso = document.getElementById("addToCartButton");
    if (addToCartButtonCurso) {
        addToCartButtonCurso.addEventListener("click", agregarAlCarritoDesdeModalCurso);
    }

    // Llama la función para manejar las tarjetas de regalo
    agregarAlCarritoDesdeModalTarjeta();

    // Evento para mostrar el modal del formulario cliente al hacer checkout
    const btn = document.getElementById("checkout-btn");
    if (btn) {
        btn.addEventListener("click", () => {
            const modal = document.getElementById("clienteModal");
            if (modal) {
                const bootstrapModal = new bootstrap.Modal(modal);
                bootstrapModal.show();
            }
        });
    }

    const clienteForm = document.getElementById("cliente-form");
    if (clienteForm) {
        clienteForm.addEventListener("submit", async (e) => {
            e.preventDefault();

            const carrito = JSON.parse(localStorage.getItem("carrito")) || [];

            const cliente = {
                nombre: document.getElementById("nombre").value.trim(),
                apellido: document.getElementById("apellido").value.trim(),
                direccion: document.getElementById("direccion").value.trim(),
                telefono: document.getElementById("telefono").value.trim(),
                email: document.getElementById("correo").value.trim()
            };

            const datosCheckout = {
                cliente: cliente,
                carrito: carrito
            };

            const baseUrl = window.location.hostname.includes("localhost")
                    ? "http://localhost:8080/Ashya-Art"
                    : "http://ashyaart.germanywestcentral.cloudapp.azure.com:8080/Ashya-Art";

            try {
                const response = await fetch(`${baseUrl}/CheckoutServlet`, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(datosCheckout)
                });

                const data = await response.json();

                if (data.url) {
                    window.location.href = data.url;
                } else {
                    alert("No se recibió la URL de Stripe");
                }
            } catch (error) {
                console.error("Error:", error);
                alert("Error al conectar con el servidor");
            }
        });
    }

});
