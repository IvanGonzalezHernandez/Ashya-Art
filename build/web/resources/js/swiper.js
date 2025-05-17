document.addEventListener("DOMContentLoaded", function () {
    // Carrusel de Cursos - efecto coverflow
    new Swiper(".swiper-cursos", {
        effect: "coverflow",
        grabCursor: true,
        centeredSlides: true,
        loop: true,
        slidesPerView: "auto",
        coverflowEffect: {
            rotate: 30,
            stretch: 0,
            depth: 150,
            modifier: 1,
            slideShadows: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
    });
});
