let images = {}; // Objeto donde se almacenarán los cursos agrupados por fecha

// Función para obtener los cursos del servidor
function fetchCourses() {
    fetch("http://localhost:8080/Ashya-Art/CoursesServlet")
        .then(response => {
            if (!response.ok) throw new Error("Error en la respuesta del servidor");
            return response.json();
        })
        .then(data => {
            const grouped = {}; // Objeto para agrupar los cursos por fecha
            Object.keys(data).forEach(key => {
                const dateKey = key.split(" ")[0]; // Extraemos solo la fecha (sin la hora)
                const courseData = data[key];
                courseData.date = dateKey; // Añadimos la fecha a los datos del curso

                if (!grouped[dateKey]) grouped[dateKey] = []; // Si no existe la fecha, inicializamos el array
                grouped[dateKey].push(courseData); // Añadimos el curso a la fecha correspondiente
            });
            images = grouped; // Guardamos los cursos agrupados en el objeto 'images'
            renderCalendar(); // Renderizamos el calendario
        })
        .catch(error => {
            console.error("Error al obtener cursos:", error); // Manejamos errores al obtener los cursos
        });
}

// Cuando el contenido de la página se haya cargado, obtenemos los cursos
document.addEventListener("DOMContentLoaded", function () {
    fetchCourses(); // Llamada para obtener los cursos
});

// Variables para manejar el año y mes actuales
let currentYear = new Date().getFullYear();
let currentMonth = new Date().getMonth();

// Función para renderizar el calendario
function renderCalendar() {
    const calendar = document.getElementById("calendar"); // Elemento donde se renderiza el calendario
    const monthYear = document.getElementById("monthYear"); // Elemento para mostrar el mes y año

    calendar.innerHTML = ""; // Limpiamos el contenido del calendario

    const firstDay = new Date(currentYear, currentMonth, 1).getDay(); // Día de la semana del primer día del mes
    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate(); // Número de días del mes

    // Actualizamos el texto del mes y año
    monthYear.textContent = new Date(currentYear, currentMonth).toLocaleString("es-ES", {
        month: "long",
        year: "numeric"
    });

    // Agregamos los días vacíos antes del primer día del mes
    for (let i = 0; i < firstDay; i++) {
        calendar.appendChild(document.createElement("div"));
    }

    // Renderizamos los días del mes
    for (let day = 1; day <= daysInMonth; day++) {
        const dateKey = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`; // Clave de la fecha
        const dayElement = document.createElement("div");
        dayElement.className = "day";
        dayElement.innerHTML = `<strong>${day}</strong>`; // Mostramos el número del día

        // Si hay cursos en ese día, lo marcamos con un fondo y lo hacemos interactivo
        if (images[dateKey]) {
            const cursosDelDia = images[dateKey]; // Cursos de ese día
            dayElement.classList.add("event-day"); // Añadimos una clase para marcar el día con eventos
            dayElement.style.backgroundImage = `url('/Ashya-Art/resources/imagenes/workshops-services/courses/generica.jpeg')`; // Imagen de fondo
            dayElement.style.backgroundSize = "cover";
            dayElement.style.backgroundPosition = "center";

            dayElement.setAttribute("data-bs-toggle", "tooltip");
            dayElement.setAttribute("title", "Haz clic para ver los cursos disponibles");

            // Al hacer clic, abrimos un modal con los cursos
            dayElement.onclick = () => openModal(cursosDelDia);
        }

        calendar.appendChild(dayElement); // Añadimos el día al calendario
    }

    // Activamos los tooltips de Bootstrap
    new bootstrap.Tooltip(document.body, {
        selector: "[data-bs-toggle='tooltip']"
    });
}

// Función para abrir el modal con la lista de cursos
function openModal(courseList) {
    const modal = new bootstrap.Modal(document.getElementById("eventModal"));
    modal.show(); // Mostramos el modal

    const select = document.getElementById("courseSelect");
    select.innerHTML = ""; // Limpiamos las opciones previas del selector
    
    
    // Añadimos los cursos al select del modal
    courseList.forEach((curso, index) => {
        const option = document.createElement("option");
        option.value = index;
        option.setAttribute("data-id", curso.id); // Añadimos el id del curso como atributo
        option.textContent = curso.title; // Título del curso
        option.setAttribute("data-img", curso.img); // Imagen del curso
        option.setAttribute("data-price", curso.price); // Precio del curso
        option.setAttribute("data-time", curso.time); // Hora del curso
        option.setAttribute("data-spots", curso.spots); // Plazas disponibles
        option.setAttribute("data-link", curso.link); // Enlace al curso
        option.setAttribute("data-date", curso.date); // Fecha del curso
        option.setAttribute("data-description", curso.description); // Descripción del curso (nuevo atributo)
        option.setAttribute("data-location", curso.location); // Ubicación del curso (nuevo atributo)
        select.appendChild(option);
    });

    updateCourseDetails(); // Actualizamos los detalles del curso seleccionado
}

// Función para actualizar los detalles del curso seleccionado en el modal
function updateCourseDetails() {
    const select = document.getElementById("courseSelect");
    const selectedOption = select.options[select.selectedIndex]; // Obtenemos la opción seleccionada

    // Actualizamos la información en el modal con los atributos del curso
    //document.getElementById("eventImage").src = selectedOption.getAttribute("data-img"); //Este en principio Sobra
    document.getElementById("courseTitle").textContent = selectedOption.textContent;
    document.getElementById("courseDate").textContent = selectedOption.getAttribute("data-date");
    document.getElementById("courseTime").textContent = selectedOption.getAttribute("data-time");
    document.getElementById("coursePrice").textContent = `${selectedOption.getAttribute("data-price")} eur`;
    document.getElementById("courseSpots").textContent = selectedOption.getAttribute("data-spots");
    document.getElementById("courseLink").href = selectedOption.getAttribute("data-link");
}

// Función para cambiar de mes (previo o siguiente)
function changeMonth(step) {
    currentMonth += step;

    // Si el mes es menor a 0, retrocedemos al año anterior
    if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
    } else if (currentMonth > 11) { // Si el mes es mayor a 11, avanzamos al año siguiente
        currentMonth = 0;
        currentYear++;
    }

    renderCalendar(); // Renderizamos el calendario actualizado
}

//ESTO EN PRINCIPIO SOBRA
// Función para manejar el envío del formulario de reserva
//document.getElementById("reservationForm").addEventListener("submit", function (event) {
//    event.preventDefault(); // Prevenimos el comportamiento por defecto del formulario
//    alert("Reserva realizada con éxito."); // Mostramos un mensaje de éxito
//    document.getElementById("reservationForm").reset(); // Reseteamos el formulario
//    new bootstrap.Modal(document.getElementById("eventModal")).hide(); // Cerramos el modal
//});

// Actualizamos los detalles del curso al cargar la página
document.addEventListener("DOMContentLoaded", function () {
    updateCourseDetails();
});
