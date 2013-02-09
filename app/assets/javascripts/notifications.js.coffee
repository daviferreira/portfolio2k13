notification = $('.notification')

# TODO: CSS transitions
if notification.length > 0
    notification.slideDown(300)
    setTimeout ->
        notification.slideUp(300)
    , 5000
