export APP_NAME=collabora-office
export VERSION := $(shell jq -r .Version < app.json)
export CLASSIC_VERSION := $(shell jq -r .ClassicVersion < app.json)
export BUILD_DATE := $(shell date +'%Y%m%d')
export TAG=$(VERSION)-$(BUILD_DATE)
export CLASSIC_TAG=$(CLASSIC_VERSION)-$(BUILD_DATE)


help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## 构建镜像
	docker build -t hub.qucheng.com/app/$(APP_NAME):$(TAG) -f Dockerfile .
	docker tag hub.qucheng.com/app/$(APP_NAME):$(TAG) hub.qucheng.com/app/$(APP_NAME)

build-classic: ## 构建镜像
	docker build -t hub.qucheng.com/app/$(APP_NAME):$(CLASSIC_TAG) -f 6.4/Dockerfile .

build-public: ## 国外构建镜像
	docker build -t easysoft/$(APP_NAME):$(TAG) -f Dockerfile .
	docker build -t easysoft/$(APP_NAME):$(CLASSIC_TAG) -f 6.4/Dockerfile .
	docker tag easysoft/$(APP_NAME):$(TAG) easysoft/$(APP_NAME)

build-all: build build-classic build-public  ## 构建所有镜

push: ## push 镜像到 hub.qucheng.com
	docker push hub.qucheng.com/app/$(APP_NAME):$(TAG)

push-classic: ## push 镜像到 hub.qucheng.com
	docker push hub.qucheng.com/app/$(APP_NAME):$(CLASSIC_TAG)

push-public: ## push 镜像到 hub.docker.com
	docker push easysoft/$(APP_NAME):$(TAG)
	docker push easysoft/$(APP_NAME):$(CLASSIC_TAG)
	docker push easysoft/$(APP_NAME):latest
push-all: push push-classic push-public ## 推送所有镜像

push-sync-tcr: push-public ## 同步到腾讯镜像仓库
	curl http://i.haogs.cn:3839/sync?image=easysoft/$(APP_NAME):$(TAG)
	curl http://i.haogs.cn:3839/sync?image=easysoft/$(APP_NAME):$(CLASSIC_TAG)
	curl http://i.haogs.cn:3839/sync?image=easysoft/$(APP_NAME):latest

run: ## 运行
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml up -d

run-classic: ## 运行经典版
	export TAG=$(CLASSIC_TAG) ;docker-compose -f docker-compose.yml up -d

smoke-test: ## 冒烟测试新版
	hack/make-rules/smoke-test.sh "collabora-office" "run"

smoke-test-classic: ## 冒烟测试经典版
	hack/make-rules/smoke-test.sh "collabora-office" "run-classic"

ps: ## 运行状态
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml ps

stop: ## 停服务
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml stop
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml rm -f

restart: build clean ps ## 重构

clean: stop ## 停服务
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml down
	docker volume prune -f

logs: ## 查看运行日志
	export TAG=$(TAG) ;docker-compose -f docker-compose.yml logs
