set -x PATH ./bin ./node_modules/.bin  ~/.config/bin $PATH
set -x MYVIMRC ~/.config/.vimrc $MYVIMRC


abbr -a s subl .
abbr -a a atom .
abbr -a g gitX .
abbr -a m mvim .
abbr -a v nvim .


abbr -a gp git push
abbr -a gs git sync
abbr -a gpf git push --force
abbr -a gpr git new-pull-request
abbr -a co git checkout

function gac
 git add -A
 if [ "$argv" = "" ]
   git commit -m ""
 else
   git commit -m "$argv"
 end
end

function gco
  git checkout $argv
end

function cs
 git checkout $argv
 git sync
end

function gacp
 gac $argv
 git push
end

alias blender "~/../../Applications/Blender/blender.app/Contents/MacOS/blender"

# PROMPT
## function fish_prompt --description 'Write out the prompt'
##
## # Just calculate these once, to save a few cycles when displaying the prompt
## if not set -q __fish_prompt_normal
##   set -g __fish_prompt_normal (set_color normal)
## end
##
## if not set -q __git_cb
##   set __git_cb " ["(set_color blue)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)"]"
## end
##
## if not set -q __fish_prompt_cwd
##   set -g __fish_prompt_cwd (set_color $fish_color_cwd)
## end
##
## printf '\n%s%s%s%s > ' $__fish_prompt_cwd (prompt_pwd) $__fish_prompt_normal $__git_cb
## end

function ....
 cd ../../..
end

function ...
 cd ../..
end

function d
 cd $argv
end

function c
 clear
end

function l
 ls -1
end


function cd
 # perform the cd.
 set __cd_old_path (pwd | wc -c)
 builtin cd $argv
 set __cd_new_path (pwd | wc -c)

 # show new files.
 ls -1
end

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate this once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_normal
   set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __git_cb
   set __git_cb " ["(set_color blue)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)"]"
  end

	set -l normal (set_color normal)

	# Hack; fish_config only copies the fish_prompt function (see #736)
	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		# initialize our new variables
		if not set -q __fish_classic_git_prompt_initialized
			set -qU fish_color_user; or set -U fish_color_user -o green
			set -qU fish_color_host; or set -U fish_color_host -o cyan
			set -qU fish_color_status; or set -U fish_color_status red
			set -U __fish_classic_git_prompt_initialized
		end
	end

	set -l color_cwd
	set -l prefix
	switch $USER
	case root toor
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		else
			set color_cwd $fish_color_cwd
		end
		set suffix '#'
	case '*'
		set color_cwd $fish_color_cwd
		set suffix '>'
	end

	set -l prompt_status
	if test $last_status -ne 0
		set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
	end

  printf '\n'
  if test $last_status -eq 0
    echo -n -s $normal (basename $PWD) $__git_cb $prompt_status; set_color green; echo " (> o_o) > "
  else
    echo -n -s $normal (basename $PWD) $__git_cb $prompt_status; set_color brred; echo " ¥(x_x)¥ "
  end
end
