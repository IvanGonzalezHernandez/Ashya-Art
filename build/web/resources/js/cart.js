document.addEventListener("DOMContentLoaded", () => {

    let carrito = []; // Carrito donde se almacenarán los productos seleccionados

    // Elementos del DOM que se van a manipular
    const contenedorCarrito = document.getElementById("carrito-items");
    const contadorCarrito = document.getElementById("cart-count");
    const totalCarrito = document.getElementById("cart-total");
    const botonCheckout = document.getElementById("checkout-btn");

    // Funciones para actualizar el carrito
    function actualizarContadorCarrito() {
        const cantidadTotal = carrito.reduce((acc, producto) => acc + producto.cantidad, 0);
        contadorCarrito.innerText = cantidadTotal;
        actualizarTotalCarrito();
        guardarCarrito();
    }

    function actualizarTotalCarrito() {
        const total = carrito.reduce((acc, producto) => acc + producto.precio * producto.cantidad, 0);
        totalCarrito.innerText = `EUR ${total.toFixed(2)}`;
        botonCheckout.style.display = carrito.length > 0 ? "block" : "none";
    }

    function cargarProductosCarrito() {
        contenedorCarrito.innerHTML = '';
        if (carrito.length === 0) {
            contenedorCarrito.innerHTML = '<p>El carrito está vacío</p>';
            botonCheckout.style.display = "none";
            return;
        }

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
                        <button class="btn btn-outline-primary btn-sm btn-sumar">+</button>
                        <button class="btn btn-sm ms-3 btn-eliminar"><i class="bi bi-trash fs-4"></i></button>
                    </div>
                </div>
            `;
            contenedorCarrito.appendChild(item);
        });

        actualizarTotalCarrito();
    }

    // Función para agregar productos al carrito desde el modal
    function agregarAlCarritoDesdeModal() {
        const courseSelect = document.getElementById("courseSelect");
        if (!courseSelect)
            return;

        const selectedOption = courseSelect.options[courseSelect.selectedIndex];
        if (!selectedOption)
            return;

        const nuevoCurso = {
            id: selectedOption.value,
            nombre: selectedOption.text,
            precio: parseFloat(selectedOption.getAttribute("data-price")),
            imagen: selectedOption.getAttribute("data-img"),
            cantidad: 1
        };

        const itemExistente = carrito.find(item => item.id === nuevoCurso.id);
        if (itemExistente) {
            itemExistente.cantidad++;
        } else {
            carrito.push(nuevoCurso);
        }

        cargarProductosCarrito();
        actualizarContadorCarrito();
    }

    contenedorCarrito.addEventListener("click", (event) => {
        const button = event.target.closest("button.btn-eliminar");
        if (button) {
            const index = Number(button.closest("div[data-index]").getAttribute("data-index"));
            if (isNaN(index))
                return;
            carrito.splice(index, 1);
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

    function guardarCarrito() {
        localStorage.setItem("carrito", JSON.stringify(carrito));
    }

    function cargarCarritoDesdeLocalStorage() {
        const carritoGuardado = localStorage.getItem("carrito");
        if (carritoGuardado) {
            carrito = JSON.parse(carritoGuardado);
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }
    }

    cargarCarritoDesdeLocalStorage();

    document.getElementById("addToCartButton").addEventListener("click", agregarAlCarritoDesdeModal);

    window.onload = function () {
        document.getElementById("checkout-btn").addEventListener("click", () => {
            const modal = new bootstrap.Modal(document.getElementById('clienteModal'));
            modal.show();
        });

        document.getElementById("cliente-form").addEventListener("submit", async (e) => {
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


            try {
                const response = await fetch("http://localhost:8080/Ashya-Art/CheckoutServlet", {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(datosCheckout)
                });

                const data = await response.json();


                if (data.url) {
                    window.location.href = data.url;  // Solo redirige después de todo
                } else {
                    alert("No se recibió la URL de Stripe");
                }
            } catch (error) {
                console.error("Error:", error);
                alert("Error al conectar con el servidor");
            }
        });


    };



});
 