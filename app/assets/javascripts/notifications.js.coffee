notification = $('.notification')

# TODO: CSS transitions
if notification.length > 0
    notification.show()
    setTimeout ->
        notification.hide()
    , 5000
