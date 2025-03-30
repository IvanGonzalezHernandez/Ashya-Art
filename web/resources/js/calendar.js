const images = {
    "2025-03-01": {img: '/Ashya-Art/resources/imagenes/workshops-services/courses/kintsugi_class.png', title: 'Curso 1', desc: 'Descripción del curso 1'},
    "2025-03-03": {img: '/Ashya-Art/resources/imagenes/workshops-services/courses/kintsugi_class.png', title: 'Curso 2', desc: 'Descripción del curso 2'},
    "2025-03-10": {img: '/Ashya-Art/resources/imagenes/workshops-services/courses/kintsugi_class.png', title: 'Curso 3', desc: 'Descripción del curso 3'}
};


let currentYear = new Date().getFullYear();
let currentMonth = new Date().getMonth();

function renderCalendar() {
    const calendar = document.getElementById("calendar");
    const monthYear = document.getElementById("monthYear");
    calendar.innerHTML = "";
    const firstDay = new Date(currentYear, currentMonth, 1).getDay();
    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
    monthYear.textContent = new Date(currentYear, currentMonth).toLocaleString("es-ES", {month: "long", year: "numeric"});

    for (let i = 0; i < firstDay; i++) {
        calendar.appendChild(document.createElement("div"));
    }
    for (let day = 1; day <= daysInMonth; day++) {
        const dateKey = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
        const dayElement = document.createElement("div");
        dayElement.className = "day";
        dayElement.innerHTML = `<strong>${day}</strong>`;

        if (images[dateKey]) {
            dayElement.classList.add("event-day");
            dayElement.style.backgroundImage = `url('${images[dateKey].img}')`; // Establecer imagen de fondo
            dayElement.style.backgroundSize = "cover"; // Asegurarse de que la imagen cubra toda la celda
            dayElement.style.backgroundPosition = "center"; // Centrar la imagen
            dayElement.setAttribute("data-bs-toggle", "tooltip");
            dayElement.setAttribute("data-bs-placement", "top");
            dayElement.setAttribute("title", images[dateKey].title);
            dayElement.onclick = () => openModal(images[dateKey]);
        }
        calendar.appendChild(dayElement);
    }

    new bootstrap.Tooltip(document.body, {
        selector: "[data-bs-toggle='tooltip']"
    });
}

function openModal(event) {
    //document.getElementById("eventTitle").textContent = event.title;
    //document.getElementById("eventImage").src = event.img;
    //document.getElementById("eventDescription").textContent = event.desc;
    new bootstrap.Modal(document.getElementById("eventModal")).show();
}

function changeMonth(step) {
    currentMonth += step;
    if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
    } else if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
    }
    renderCalendar();
}

document.addEventListener("DOMContentLoaded", function () {
    renderCalendar();
});

// Evento para el formulario de reserva
document.getElementById("reservationForm").addEventListener("submit", function (event) {
    event.preventDefault();
    alert("Reserva realizada con éxito.");
    document.getElementById("reservationForm").reset();
    new bootstrap.Modal(document.getElementById("eventModal")).hide();
});

function updateCourseDetails() {
    const select = document.getElementById("courseSelect");
    const selectedOption = select.options[select.selectedIndex];

    // Obtener los atributos de la opción seleccionada
    const imgSrc = selectedOption.getAttribute("data-img");
    const coursePrice = selectedOption.getAttribute("data-price");
    const courseTime = selectedOption.getAttribute("data-time");
    const courseSpots = selectedOption.getAttribute("data-spots");

    // Actualizar los elementos del modal
    document.getElementById("eventImage").src = imgSrc;
    document.getElementById("coursePrice").textContent = coursePrice + " eur";
    document.getElementById("courseTime").textContent = courseTime;
    document.getElementById("courseSpots").textContent = courseSpots;
}


document.addEventListener("DOMContentLoaded", function () {
    updateCourseDetails();
});