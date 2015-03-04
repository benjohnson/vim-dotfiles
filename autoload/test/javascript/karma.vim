" Returns true if the given file belongs to your test runner
function! test#javascript#karma#test_file(file) abort
  return a:file =~? '_test.js$'
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#javascript#karma#build_position(type, position) abort
  return []
endfunction

" Returns processed args (if you need to do any processing)
function! test#javascript#karma#build_args(args) abort
  return a:args
endfunction

" Returns the executable of your test runner
function! test#javascript#karma#executable() abort
  return 'grunt --base media --gruntfile media/Gruntfile.js test'
endfunction
