document.addEventListener("DOMContentLoaded", function () {
    new Swiper(".swiper-cursos", {
        effect: "coverflow",
        grabCursor: true,
        centeredSlides: true,
        loop: true,
        slidesPerView: 1.2, // Valor por defecto
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
        breakpoints: {
            480: {
                slidesPerView: 1.4,
                coverflowEffect: {
                    rotate: 15,
                    depth: 80,
                },
            },
            768: {
                slidesPerView: 2,
                coverflowEffect: {
                    rotate: 20,
                    depth: 100,
                },
            },
            1024: {
                slidesPerView: 2.5,
                coverflowEffect: {
                    rotate: 30,
                    depth: 150,
                },
            },
            1280: {
                slidesPerView: 3,
                coverflowEffect: {
                    rotate: 30,
                    depth: 200,
                },
            },
        },
    });
});
