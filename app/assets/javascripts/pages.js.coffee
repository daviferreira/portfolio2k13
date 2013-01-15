works = $('#row-works')
offset = works.offset().top + 50
time = 40

showHover = (el, time) ->
  setTimeout -> 
    $(el).addClass('hover')
    setTimeout ->
      $(el).removeClass('hover')
    , time + 30
  , time

$(window).scroll ->
  if $(this).scrollTop() + $(this).height() > offset
    setTimeout ->
      works.find('a').each (i, el) ->
        showHover(el, time * (i + 1))
      $(this).unbind 'scroll'
    , 300
