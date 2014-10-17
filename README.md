Archlinux news helper
=====================

Pulls the most recent archlinux news to the terminal and confirms you have read it before running "sudo pacman -Syu" for you


TODO:
- [x] only display message if the script has not run since the last update to http://archlinux.org/news/
- [ ] bring actual news content to the terminal, rather than redirecting using xdg-open
- [x] give option to not bring news content into terminal via using input [y/N/a]
- [ ] detect pacman wrappers (such as yaourt and aura) and offer to run the script using that as a backend instead of pacman directly. (To allow the user their preferred method of updating, such as via powerpill)
- [ ] highlight the title of a unread news post, in the case it contains keywords such as "manual", "user", "intervention", or "required"
- [ ] show the last time the news was read, and show the post date of all news articles where the date is more recent than the last time the news was read