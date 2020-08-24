instance?="sbux-datalake:us-central1:master-instance-datalake"
container_name?="sql-proxy-auth"
docker_image?="registry.neoway.com.br/svcops/${container_name}"
proxyd_exists=$(shell docker ps --filter name=sql-proxy-auth | grep Up > /dev/null || echo false)

build: ## Build alpine proxy client
	docker build . -t ${docker_image}

proxyd: build ## Starts proxy container
ifeq ($(proxyd_exists), false)
	docker run --rm -p 5432:5432 -d --name ${container_name} ${docker_image}
endif

shell: ## Get a tty inside docker container.
	docker exec -it ${container_name} bash

proxy-login: proxyd ##@ Proxy login
	docker exec -it ${container_name} bash gcloud auth login

proxy-run: ## Starts proxy client
ifneq ($(proxyd_exists), false)
	docker exec -d ${container_name} bash proxy_auth.sh
	@echo "Proxy started"
else
	@echo "Please start the proxy by running:\n" \
		"make proxy-login" 
endif

proxy-run-logs: ## Runs proxy in attached mode
ifneq ($(proxyd_exists), false)
	docker exec ${container_name} bash proxy_auth.sh
else
	@echo "Please start the proxy by running:\n" \
		"make proxy-login" 
endif

clean: ## Remove current container
	@docker container stop	${container_name} 2> /dev/null;
	@echo "Cleaned" ;




