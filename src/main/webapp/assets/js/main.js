(function ($) {
  "use strict";

  // Spinner
  var spinner = function () {
    setTimeout(function () {
      if ($("#spinner").length > 0) {
        $("#spinner").removeClass("show");
      }
    }, 1);
  };
  spinner();

  // Initiate the wowjs
  new WOW().init();

  // Back to top button
  //    $(window).scroll(function () {
  //     if ($(this).scrollTop() > 300) {
  //         $('.back-to-top').fadeIn('slow');
  //     } else {
  //         $('.back-to-top').fadeOut('slow');
  //     }
  //     });
  //     $('.back-to-top').click(function () {
  //         $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
  //         return false;
  //     });

  $(".back-to-top").click(function () {
    $("html, body").animate(
      {
        scrollTop: 0,
      },
      0,
      "swing"
    );
    return false;
  });

  // Team carousel
  $(".team-carousel").owlCarousel({
    autoplay: true,
    smartSpeed: 1000,
    center: false,
    dots: false,
    loop: true,
    margin: 50,
    nav: true,
    navText: [
      '<i class="bi bi-arrow-left"></i>',
      '<i class="bi bi-arrow-right"></i>',
    ],
    responsiveClass: true,
    responsive: {
      0: {
        items: 1,
      },
      768: {
        items: 2,
      },
      992: {
        items: 3,
      },
    },
  });

  // Testimonial carousel

  $(".testimonial-carousel").owlCarousel({
    autoplay: true,
    smartSpeed: 1500,
    center: true,
    dots: true,
    loop: true,
    margin: 0,
    nav: true,
    navText: false,
    responsiveClass: true,
    responsive: {
      0: {
        items: 1,
      },
      576: {
        items: 1,
      },
      768: {
        items: 2,
      },
      992: {
        items: 3,
      },
    },
  });

  // Fact Counter

  $(document).ready(function () {
    $(".counter-value").each(function () {
      $(this)
        .prop("Counter", 0)
        .animate(
          {
            Counter: $(this).text(),
          },
          {
            duration: 2000,
            easing: "easeInQuad",
            step: function (now) {
              $(this).text(Math.ceil(now));
            },
          }
        );
    });
  });
})(jQuery);

//
function clickOnBell() {
  var dropdown = document.querySelector(".header__popup");
  if (dropdown.style.display === "none") {
    dropdown.style.display = "block";
    // document.querySelector('.account-setting').style.display = 'none'
  } else {
    dropdown.style.display = "none";
  }
}

// Rating star
// Select all elements with the "i" tag and store them in a NodeList called "stars"
function onStarClick() {
  var rating_label = document.querySelector(".rating-label");
  var rating_number = document.querySelector(".rating-number");
  const stars = document.querySelectorAll(".stars i");

  // Add an event listener to each star
  stars.forEach((star, index1) => {
    star.addEventListener("click", () => {
      // Add the "active" class to the clicked star and any stars with a lower index
      // and remove the "active" class from any stars with a higher index
      stars.forEach((star, index2) => {
        index1 >= index2
          ? star.classList.add("active")
          : star.classList.remove("active");
      });

      // Update rating_label based on the clicked star's index
      if (index1 == 0) {
        rating_label.innerHTML = "Rất tệ";
        rating_number.innerHTML = "1";
      } else if (index1 == 1) {
        rating_label.innerHTML = "Tệ";
        rating_number.innerHTML = "2";
      } else if (index1 == 2) {
        rating_label.innerHTML = "Bình thường";
        rating_number.innerHTML = "3";
      } else if (index1 == 3) {
        rating_label.innerHTML = "Tốt";
        rating_number.innerHTML = "4";
      } else if (index1 == 4) {
        rating_label.innerHTML = "Rất tốt";
        rating_number.innerHTML = "5";
      }
    });
  });
}

// Login,Register tab

function ClickRegisterTab() {
  var login = document.getElementById("form-login");
  var register = document.getElementById("form-register");
  var loginTitle = document.getElementById("LoginLabel");
  var registerTitle = document.getElementById("RegisterLabel");

  login.style.display = "none";
  register.style.display = "block";
  loginTitle.style.display = "none";
  registerTitle.style.display = "block";
}

function ClickLoginTab() {
  var login = document.getElementById("form-login");
  var register = document.getElementById("form-register");
  var loginTitle = document.getElementById("LoginLabel");
  var registerTitle = document.getElementById("RegisterLabel");

  login.style.display = "block";
  register.style.display = "none";
  loginTitle.style.display = "block";
  registerTitle.style.display = "none";
}
