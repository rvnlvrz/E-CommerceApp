// Navbar attachment logic
$(window).scroll(function () {
    if ($(this).scrollTop() > 0) {
        $(".navbar").addClass("fixed-top");
        document.body.style.paddingTop = $(".navbar").outerHeight(true) + "px";
    } else {
        $(".navbar").removeClass("fixed-top");
        document.body.style.paddingTop = "0";
    }
});