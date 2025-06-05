const modalProducto = new bootstrap.Modal(document.getElementById('productoAgregadoModal'));

function añadirAlCarrito(btn) {
    // Si quieres hacer algo con los datos, por ejemplo:
    const nombre = btn.dataset.nombre;
    console.log("Añadido al carrito:", nombre);

    // Mostrar modal
    modalProducto.show();
}