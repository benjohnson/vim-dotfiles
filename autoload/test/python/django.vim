" Returns true if the given file belongs to your test runner
function! test#python#django#test_file(file) abort
  if fnamemodify(a:file, ':t') =~# '^test_.*\.py$'
    if exists('g:test#python#runner')
      return g:test#python#runner == 'django'
    else
      return executable(getcwd() . '/manage.py')
    endif
  endif
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#python#django#build_position(type, position) abort
  let path = s:get_import_path(a:position['file'])
  if a:type == 'nearest'
    let nearest_test_name = s:nearest_test(a:position)
    if nearest_test_name != ''
      return [path . '.' . nearest_test_name]
    else
      return [path]
    endif
  elseif a:type == 'file'
    return [path]
  else
    return []
  endif
endfunction

" Returns processed args (if you need to do any processing)
function! test#python#django#build_args(args) abort
  return a:args
endfunction

" Returns the executable of your test runner
function! test#python#django#executable() abort
  return getcwd() . '/manage.py test'
endfunction

function! s:get_import_path(filepath) abort
  " Get path to file from cwd and without extension.
  " Replace the /'s in the file path with .'s
  let path = fnamemodify(a:filepath, ':.:r')
  let path = substitute(path, '\/', '.', 'g')
  return path
endfunction!

function! s:nearest_test(position) abort
  " The default python levels do not strip out
  " (TestCase) from the class name.
  let levels = [
    \ '\v^\s*def (test_\w+)',
    \ '\v^\s*class (\S+)(\(\S+\)):',
  \]
  let name = test#base#nearest_test(a:position, levels)
  return join(name[0] + name[1], '.')
endfunction
