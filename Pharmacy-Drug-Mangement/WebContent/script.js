let slideIndex = 0;
const slidesContainer = document.querySelector('.slides');
const slides = document.querySelectorAll('.slide');

function updateSlidePosition() {
    // Adjust the transform to show the current slide
    slidesContainer.style.transform = `translateX(-${slideIndex * 100}%)`;
}

function changeSlide(n) {
    slideIndex = (slideIndex + n + slides.length) % slides.length;
    updateSlidePosition();
}

// Auto-slide every 3 seconds
function autoSlide() {
    changeSlide(1);
    setTimeout(autoSlide, 5000);
}

updateSlidePosition();
autoSlide();