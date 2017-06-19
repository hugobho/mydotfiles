let g:airline_left_sep= '⮀'
let g:airline_right_sep= '⮂'
let g:airline_section_b= ''
let g:airline_section_error= ''
let g:airline_section_warning= ''

let g:airline_powerline_fonts=1

let g:airline_symbols = exists('g:airline_symbols') ? g:airline_symbols : {}
let g:airline_symbols.branch = '⭠'

function! InitAirlineSections()
  let g:airline_section_y = airline#section#create(['branch'])
  let g:airline_section_z = airline#section#create(['','%l/%L',':','%c'])
endfunction

autocmd VimEnter * call InitAirlineSections()
