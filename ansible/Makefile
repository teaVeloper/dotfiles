.PHONY: desktop laptop work

desktop:
	ansible-playbook playbooks/desktop.yml -i inventories/desktop --ask-become-pass

laptop:
	ansible-playbook playbooks/laptop.yml -i inventories/laptop --ask-become-pass

work:
	ansible-playbook playbooks/work.yml -i inventories/work --ask-become-pass
generic:
	ansible-playbook playbooks/main.yml -i inventories/hosts.ini -e "machine_type=desktop" --ask-become-pass

# desktop:
# 	ansible-playbook playbooks/main.yml -i inventories/hosts.ini -e "machine_type=desktop" --ask-become-pass
#
# laptop:
# 	ansible-playbook playbooks/main.yml -i inventories/hosts.ini -e "machine_type=laptop" --ask-become-pass
#
# work:
# 	ansible-playbook playbooks/main.yml -i inventories/hosts.ini -e "machine_type=work" --ask-become-pass
#
