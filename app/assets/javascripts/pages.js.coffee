works = $('#row-works')
worksOffset = works.offset().top + 50
time = 40

showHover = (el, time) ->
  setTimeout -> 
    $(el).addClass('hover')
    setTimeout ->
      $(el).removeClass('hover')
    , time + 30
  , time

$(window).bind 'scroll.works', ->
  if $(this).scrollTop() + $(this).height() > worksOffset
    setTimeout ->
      works.find('a').each (i, el) ->
        showHover(el, time * (i + 1))
      $(this).unbind 'scroll.works'
    , 300

title = $('#page-title')
titleOffset = title.offset().top

$(window).bind 'scroll.title', ->
  if $(this).scrollTop() > titleOffset
    title.css {
      position: 'fixed',
      top: 0,
      margin: 0
    }
