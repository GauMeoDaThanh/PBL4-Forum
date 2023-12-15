(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();


    // Initiate the wowjs
    new WOW().init();


    // Back to top button
    $('.back-to-top').click(function () {
        $('html, body').animate({
            scrollTop: 0
        }, 0, 'swing');
        return false;
    });




})(jQuery);

//

//
window.addEventListener("load", function() {
    // Wait for the entire page, including images and other resources, to be fully loaded
    var elementToFocus = document.getElementById("element-focus");

    // Check if the element exists
    if (elementToFocus) {
        // Scroll to the element with smooth behavior
        elementToFocus.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
});
//
function clickOnBell() {
    var dropdown = document.querySelector('.header__popup')
    if(dropdown.style.display ==='none') {
        dropdown.style.display ='block'
        // document.querySelector('.account-setting').style.display = 'none'
    }
    else {
        dropdown.style.display ='none'

    }
}

// Rating star
// Select all elements with the "i" tag and store them in a NodeList called "stars"
function onStarClick() {
    alert("Hello Star 1");
    var rating_label = document.querySelector(".rating-label");
    var rating_number = document.querySelector(".rating-number");
    var rating = document.getElementById("rating");
    const stars = document.querySelectorAll(".stars i");

    // Add an event listener to each star
    stars.forEach((star, index1) => {
        star.addEventListener("click", () => {
            // Add the "active" class to the clicked star and any stars with a lower index
            // and remove the "active" class from any stars with a higher index
            stars.forEach((star, index2) => {
                index1 >= index2 ? star.classList.add("active") : star.classList.remove("active");
            });
            alert("Hello Star 2");
            // Update rating_label based on the clicked star's index
            if (index1 == 0) {
                rating_label.innerHTML = 'Rất tệ';
                rating_number.innerHTML = '1';
                rating.value = "1";
            } else if (index1 == 1) {
                rating_label.innerHTML = 'Tệ';
                rating_number.innerHTML = '2';
                rating.value = "2";
            } else if (index1 == 2) {
                rating_label.innerHTML = 'Bình thường';
                rating_number.innerHTML = '3';
                rating.value = "3";

            } else if (index1 == 3) {
                rating_label.innerHTML = 'Tốt';
                rating_number.innerHTML = '4';
                rating.value = "4";

            } else if (index1 == 4) {
                rating_label.innerHTML = 'Rất tốt';
                rating_number.innerHTML = '5';
                rating.value = "5";

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

    login.style.display="none";
    register.style.display="block";
    loginTitle.style.display="none";
    registerTitle.style.display="block";
}

function ClickLoginTab() {
    var login = document.getElementById("form-login");
    var register = document.getElementById("form-register");
    var loginTitle = document.getElementById("LoginLabel");
    var registerTitle = document.getElementById("RegisterLabel");

    login.style.display="block";
    register.style.display="none";
    loginTitle.style.display="block";
    registerTitle.style.display="none";
}
// Upload ảnh đại diện
function displaySelectedImage(event, elementId) {
    const selectedImage = document.getElementById(elementId);
    const fileInput = event.target;

    if (fileInput.files && fileInput.files[0]) {
        const reader = new FileReader();

        reader.onload = function(e) {
            selectedImage.src = e.target.result;
        };

        reader.readAsDataURL(fileInput.files[0]);
        selectedImage.style.display='block';

    }

    var buttonDeleteImage = document.getElementById("button-deleteImage");
    buttonDeleteImage.style.display='block'

}

// Click reply button
function replyPost(postOwner,postContent,idPost,ownerPostTo,contentPostTo,idPostTo,blockReply){
    var postOwnerElement = document.getElementById(postOwner);
    var postContentElement=document.getElementById(postContent);
    // var idPostElement = document.getElementById(idPost);

    var ownerPostToElement=document.getElementById(ownerPostTo);
    var contentPostToElement=document.getElementById(contentPostTo);
    var idPostToElement = document.getElementById(idPostTo);

    var blockReplyElement=document.getElementById(blockReply);

    ownerPostToElement.innerHTML=postOwnerElement.innerHTML
    contentPostToElement.innerHTML=postContentElement.innerHTML
    idPostToElement.value=idPost
    blockReplyElement.style.display='block'

    // truot xuong khung chat
    var focus = document.getElementById("element-focus-reply")

    focus.scrollIntoView({ behavior: 'smooth', block: 'center' });

}

function resetReply(ownerPostTo,contentPostTo,idPostTo,blockReply) {
    var ownerPostToElement=document.getElementById(ownerPostTo);
    var contentPostToElement=document.getElementById(contentPostTo);
    var idPostToElement = document.getElementById(idPostTo);
    var blockReplyElement=document.getElementById(blockReply);

    ownerPostToElement.innerHTML=""
    contentPostToElement.innerHTML=""
    idPostToElement.value=""
    blockReplyElement.style.display='none'
}

// display multiple image
function uploadImages(id) {
    var input = document.getElementById('formFileMultiple-'+id);
    var viewImageContainer = document.getElementById('view-image-container-'+id);
    console.log('formFileMultiple-'+id)
    console.log('view-image-container-'+id)

    viewImageContainer.innerHTML = "";

    var files = input.files;

    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var reader = new FileReader();

        reader.onload = function (e) {
            var viewImage = document.createElement('div');
            viewImage.classList.add('view-image', 'm-2');

            var imageElement = document.createElement('img');
            imageElement.src = e.target.result;
            imageElement.height = "150";

            viewImage.appendChild(imageElement);
            viewImageContainer.appendChild(viewImage);
        };

        reader.readAsDataURL(file);
    }
}

