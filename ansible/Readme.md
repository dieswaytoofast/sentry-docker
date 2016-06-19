## Notes

1. Bringing everything up

```
$ mie.yml
```
1. Taking everything down

```
$ mie_down.yml

```
1. Taking everything down, and cleaning up volumes

```
$ mie_down.yml --extra-vars refresh=true
```
1. Using tags (append `-t <tag>` to a playbook)
	1. Building images

		```
		$ mie.yml -t build
		```
	1. Building only the workers
	2. 
		```
		$ mie.yml -t build
		```
	1. Running only the workers
	
		```
		$ mie.yml -t run_workers
		```
	1. Listing all the tags available
	2. 
		```
		$ mie.yml --list-tags
		```