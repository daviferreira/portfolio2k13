var currentYear = parseInt($('ul[data-year]:first').data('year'), 10),
    title = $('#year-title'),
    year;
$(window).scroll(function () {
    var scrollTop = $(this).scrollTop() + 133,
        hasYear = false;
    $('ul[data-year]').each(function () {
        year = parseInt($(this).data('year'), 10);
        if ($(this).offset().top > scrollTop && hasYear !== true) {
            hasYear = true;
            if (year !== currentYear) {
                title.hide().html(year).fadeIn(200);
                currentYear = year;
            }
        }
    });
});