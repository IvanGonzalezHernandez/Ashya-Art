document.addEventListener("DOMContentLoaded", () => {
    // Definir los productos disponibles en el sistema
    const productos = [
        {id: 1, nombre: "Hand Building Ceramic Class", precio: 90.00, imagen: "./logo.png"},
        {id: 2, nombre: "Wheel Throwing Class", precio: 120.00, imagen: "./logo.png"}
    ];

    // Carrito donde se almacenarán los productos seleccionados
    let carrito = [];

    // Elementos del DOM que se van a manipular
    const contenedorCarrito = document.getElementById("carrito-items");  // Contenedor donde se listarán los productos del carrito
    const contadorCarrito = document.getElementById("cart-count");  // Elemento que muestra el número de productos en el carrito
    const totalCarrito = document.getElementById("cart-total");  // Elemento que muestra el total del carrito
    const botonCheckout = document.getElementById("checkout-btn");  // Botón para proceder al pago

    // Actualiza el contador del carrito, el total y guarda el carrito en el localStorage
    function actualizarContadorCarrito() {
        // Calcula el número total de productos en el carrito
        const cantidadTotal = carrito.reduce((acc, producto) => acc + producto.cantidad, 0);
        // Actualiza el texto del contador
        contadorCarrito.innerText = cantidadTotal;
        actualizarTotalCarrito();  // Actualiza el total del carrito
        guardarCarrito();  // Guarda el carrito en localStorage
    }

    // Calcula y muestra el total del carrito
    function actualizarTotalCarrito() {
        const total = carrito.reduce((acc, producto) => acc + producto.precio * producto.cantidad, 0);
        totalCarrito.innerText = `EUR ${total.toFixed(2)}`;  // Muestra el total formateado
        // Muestra el botón de checkout solo si el carrito tiene productos
        botonCheckout.style.display = carrito.length > 0 ? "block" : "none";
    }

    // Carga y muestra los productos del carrito
    function cargarProductosCarrito() {
        // Limpia el contenedor de productos
        contenedorCarrito.innerHTML = '';

        // Si el carrito está vacío, muestra un mensaje
        if (carrito.length === 0) {
            contenedorCarrito.innerHTML = '<p>El carrito está vacío</p>';
            botonCheckout.style.display = "none";  // Oculta el botón de checkout si no hay productos
            return;
        }

        // Si el carrito tiene productos, muestra cada uno
        carrito.forEach((producto, index) => {
            const item = document.createElement("div");  // Crea un nuevo elemento para cada producto
            item.classList.add("d-flex", "align-items-center", "mb-3");
            item.setAttribute("data-index", index);  // Asocia un índice para identificar el producto

            // Agrega el HTML del producto con los botones de suma, resta y eliminar
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
            contenedorCarrito.appendChild(item);  // Agrega el producto al contenedor
        });

        actualizarTotalCarrito();  // Actualiza el total del carrito después de agregar productos
    }

    // Función que se ejecuta cuando se agrega un producto al carrito desde el modal
    function agregarAlCarritoDesdeModal() {
        const courseSelect = document.getElementById("courseSelect");  // Obtiene el elemento select del modal
        if (!courseSelect)
            return;

        const selectedOption = courseSelect.options[courseSelect.selectedIndex];  // Obtiene la opción seleccionada
        if (!selectedOption)
            return;

        // Crea un objeto del producto a agregar
        const nuevoCurso = {
            id: selectedOption.value,
            nombre: selectedOption.text,
            precio: parseFloat(selectedOption.getAttribute("data-price")),
            imagen: selectedOption.getAttribute("data-img"),
            cantidad: 1
        };

        // Verifica si el producto ya existe en el carrito
        const itemExistente = carrito.find(item => item.id === nuevoCurso.id);
        if (itemExistente) {
            itemExistente.cantidad++;  // Si ya está, aumenta la cantidad
        } else {
            carrito.push(nuevoCurso);  // Si no está, lo agrega al carrito
        }

        cargarProductosCarrito();  // Carga los productos nuevamente
        actualizarContadorCarrito();  // Actualiza el contador y el total
    }

    // Evento para manejar las interacciones con el carrito
    contenedorCarrito.addEventListener("click", (event) => {
        // Eliminar producto
        const button = event.target.closest("button.btn-eliminar");  // Busca el botón de eliminar más cercano
        if (button) {
            const index = Number(button.closest("div[data-index]").getAttribute("data-index"));
            if (isNaN(index))
                return;  // Verifica que sea un índice válido

            // Elimina el producto del carrito
            carrito.splice(index, 1);

            // Recarga el carrito y actualiza el contador
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }

        // Sumar cantidad
        else if (event.target.classList.contains("btn-sumar")) {
            const index = Number(event.target.closest("div[data-index]").getAttribute("data-index"));
            carrito[index].cantidad++;  // Aumenta la cantidad del producto
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }

        // Restar cantidad
        else if (event.target.classList.contains("btn-restar")) {
            const index = Number(event.target.closest("div[data-index]").getAttribute("data-index"));
            if (carrito[index].cantidad > 1) {
                carrito[index].cantidad--;  // Disminuye la cantidad si es mayor a 1
            } else {
                carrito.splice(index, 1);  // Elimina el producto si la cantidad llega a 1
            }
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }
    });

    // Guarda el carrito en el almacenamiento local
    function guardarCarrito() {
        localStorage.setItem("carrito", JSON.stringify(carrito));
    }

    // Carga el carrito desde el almacenamiento local al cargar la página
    function cargarCarritoDesdeLocalStorage() {
        const carritoGuardado = localStorage.getItem("carrito");
        if (carritoGuardado) {
            carrito = JSON.parse(carritoGuardado);  // Convierte el carrito guardado de JSON a objeto
            cargarProductosCarrito();
            actualizarContadorCarrito();
        }
    }

    cargarCarritoDesdeLocalStorage();  // Carga el carrito cuando se abre la página

    // Evento para agregar productos al carrito desde el botón del modal
    document.getElementById("addToCartButton").addEventListener("click", agregarAlCarritoDesdeModal);

// Añadir un evento de escucha para el clic en el botón de checkout
    document.getElementById("checkout-btn").addEventListener("click", async () => {
        // Obtener el carrito del almacenamiento local (localStorage)
        const carrito = JSON.parse(localStorage.getItem("carrito")) || [];

        try {
            // Enviar una solicitud POST al servlet para crear una sesión de Stripe
            const response = await fetch("http://localhost:8080/Ashya-Art/CheckoutServlet", {
                method: "POST", // Método HTTP: POST
                headers: {"Content-Type": "application/json"}, // El tipo de contenido que se enviará es JSON
                body: JSON.stringify(carrito), // Convertir el carrito a JSON y enviarlo
            });

            // Convertir la respuesta en JSON
            const data = await response.json();
            console.log("Respuesta del servidor:", data);  // Mostrar la respuesta del servidor en la consola

            // Si se recibe la URL de Stripe, redirigir a la página de pago de Stripe
            if (data.url) {
                window.location.href = data.url;  // Redirigir a Stripe Checkout
            } else {
                alert("Error: No se recibió la URL de Stripe");  // Si no se recibió la URL
            }
        } catch (error) {
            // Si ocurre un error, mostrarlo en la consola y alertar al usuario
            console.error("Error:", error);
            alert("Error al conectar con el servidor");
        }
    });


});
