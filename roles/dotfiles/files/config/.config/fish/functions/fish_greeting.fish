function fish_greeting
	set currentPwd $PWD
	set error 0

	cd ~/.dotfiles
	if [ (git status --porcelain | wc -l) != 0 ]
		echo -e "\e[31mYou have uncommited changes in your .dotfiles.\e[0m"
		set error 1
	end
	if [ (git rev-list --left-right --count master...origin/master | awk '{print $1}') != 0 ]
		echo -e "\e[31mYou have unpushed changes in your .dotfiles.\e[0m"
		set error 1
	end

	cd ~/Programowanie/Bash/bin
	if [ (git status --porcelain | wc -l) != 0 ]
		echo -e "\e[31mYou have uncommited changes in your bin.\e[0m"
		set error 1
	end
	if [ (git rev-list --left-right --count master...origin/master | awk '{print $1}') != 0 ]
		echo -e "\e[31mYou have unpushed changes in your bin.\e[0m"
		set error 1
	end

	if test -e /tmp/listOfUpgrades
		set numberOfUpgrades (cat /tmp/listOfUpgrades | wc -l)
		if [ $numberOfUpgrades != 0 ]
			echo -e "\e[31mYou have $numberOfUpgrades upgrades awaiting to install.\e[0m"
			set error 1
		end
	end

        if test -e /tmp/non-actual-repos
                echo -e -n "\e[31m"
                cat /tmp/non-actual-repos
                echo -e "\e[0m"
                set error 1
        end

        if test -e /tmp/apps_versions
                echo -e -n "\e[31m"
                grep -v -e '^$' /tmp/apps_versions
                echo -e "\e[0m"
                set error 1
        end

	cd $currentPwd

	if [ $error = 0 ]
		echo -e "\e[32mNothing to be worried about, enjoy your day!\e[0m"
	else
		echo -e "\e[41;5;1mFix it!\e[0m"
	end
end
